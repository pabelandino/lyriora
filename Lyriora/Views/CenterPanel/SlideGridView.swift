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

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
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
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(slides) { slide in
                            SlideThumbnailView(
                                slide: slide,
                                style: styleProfile?.resolvedStyle(for: slide),
                                language: language,
                                isSelected: slide.index == selectedSlideIndex,
                                presentationState: presentationState,
                                defaultBackgroundSettings: defaultBackgroundSettings
                            )
                            .onTapGesture {
                                onSelect(slide)
                            }
                            .id(slide.id)
                        }
                    }
                    .padding(16)
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

    private let cornerRadius: CGFloat = 16

    private var textConfiguration: PresentationTextConfiguration {
        if let style {
            return style.presentationConfiguration(isPreview: true)
        }
        return PresentationTextConfiguration(style: .previewDefault)
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(slide.tag.localizedName(for: language))
                .font(.caption2.weight(.bold))
                .foregroundStyle(.white.opacity(0.85))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.35))

            ZStack {
                ToggleablePresentationBackgroundLayer(
                    isVisible: presentationState.showBackground,
                    background: presentationState.background,
                    defaultBackgroundSettings: defaultBackgroundSettings,
                    blurDefaultBackground: false
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                AdaptivePresentationText(
                    text: slide.text,
                    configuration: textConfiguration
                )
            }
            .frame(minHeight: 72)
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(.white.opacity(0.9), lineWidth: 2)
            }
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
