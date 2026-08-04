//
//  SlideGridView.swift
//  Lyriora
//

import SwiftUI

struct SlideGridView: View {
    let slides: [LyricSlide]
    let styleProfile: LyricStyleProfile?
    let language: LyricLanguage
    let selectedSlideIndex: Int?
    let presentationState: PresentationState
    let defaultBackgroundSettings: DefaultBackgroundSettings
    let onSelect: (LyricSlide) -> Void

    private let thumbnailMaxWidth: CGFloat = 188
    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            if slides.isEmpty {
                ContentUnavailableView(
                    "No slides",
                    systemImage: "rectangle.on.rectangle.slash",
                    description: Text("Select a lyric from the library to see its slides.")
                )
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(slides) { slide in
                            SlideThumbnailView(
                                slide: slide,
                                style: styleProfile?.resolvedStyle(for: slide),
                                language: language,
                                isSelected: slide.index == selectedSlideIndex,
                                presentationState: presentationState,
                                defaultBackgroundSettings: defaultBackgroundSettings
                            )
                            .frame(maxWidth: thumbnailMaxWidth)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                onSelect(slide)
                            }
                            .id(slide.id)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
                .transparentScrollContent()
            }
        }
    }
}

private struct SlideThumbnailView: View {
    let slide: LyricSlide
    let style: SlideTextStyle?
    let language: LyricLanguage
    let isSelected: Bool
    let presentationState: PresentationState
    let defaultBackgroundSettings: DefaultBackgroundSettings

    private let cornerRadius: CGFloat = 14
    private let textAreaMinHeight: CGFloat = 84
    private let textInset: CGFloat = 12

    private var textConfiguration: PresentationTextConfiguration {
        PresentationTextConfiguration(style: thumbnailStyle)
    }

    private var thumbnailStyle: SlideTextStyle {
        var resolved = style ?? .previewDefault
        resolved.paddingRatio = max(resolved.paddingRatio, 0.12)
        resolved.maxFontSize = min(resolved.maxFontSize, 24)
        resolved.minFontSize = min(resolved.minFontSize, 11)
        resolved.isAdaptiveScalingEnabled = true
        return resolved
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(slide.tag.localizedName(for: language))
                .font(.caption2.weight(.bold))
                .foregroundStyle(.white.opacity(0.85))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.35))

            ZStack {
                ToggleablePresentationBackgroundLayer(
                    isVisible: presentationState.showBackground,
                    background: presentationState.background,
                    defaultBackgroundSettings: defaultBackgroundSettings,
                    blurDefaultBackground: false,
                    showsDefaultWhenEmpty: false
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                AdaptivePresentationText(
                    text: slide.text,
                    configuration: textConfiguration
                )
                .padding(textInset)
            }
            .frame(minHeight: textAreaMinHeight)
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(
                    isSelected ? Color.white.opacity(0.9) : Color.white.opacity(0.08),
                    lineWidth: isSelected ? 2 : 1
                )
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
