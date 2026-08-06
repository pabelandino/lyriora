//
//  LyricEditorSlideHorizontalListView.swift
//  Lyriora
//

import SwiftUI

struct LyricEditorSlideHorizontalListView: View {
    let slides: [LyricSlide]
    let styleProfile: LyricStyleProfile
    let language: LyricLanguage
    let defaultBackgroundSettings: DefaultBackgroundSettings

    private let cardWidth: CGFloat = 180
    private let rowHeight: CGFloat = 160

    var body: some View {
        if slides.isEmpty {
            Text("Import or paste lyrics above to generate slides.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(slides) { slide in
                        NavigationLink(value: slide.id) {
                            LyricEditorSlideCard(
                                slide: slide,
                                style: styleProfile.resolvedStyle(for: slide),
                                language: language,
                                defaultBackgroundSettings: defaultBackgroundSettings
                            )
                            .frame(width: cardWidth)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 2)
            }
            .frame(height: rowHeight)
            .id(slidesRefreshID)
        }
    }

    private var slidesRefreshID: String {
        let style = styleProfile.defaultStyle
        return slides.map(\.id.uuidString).joined(separator: "-")
            + "|\(slides.count)|\(style.maxLinesPerSlide)|\(style.lineSpacing)|\(style.maxFontSize)"
    }
}

private struct LyricEditorSlideCard: View {
    let slide: LyricSlide
    let style: SlideTextStyle
    let language: LyricLanguage
    let defaultBackgroundSettings: DefaultBackgroundSettings

    private let cornerRadius: CGFloat = 12

    private var textConfiguration: PresentationTextConfiguration {
        style.presentationConfiguration(isPreview: true)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(slide.tag.localizedName(for: language))
                    .font(.caption2.weight(.bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.ultraThinMaterial, in: Capsule())

                Spacer(minLength: 0)

                Text("\(slide.order + 1)")
                    .font(.caption2.monospacedDigit().weight(.semibold))
                    .foregroundStyle(.secondary)
            }

            ZStack {
                PresentationBackgroundLayer(
                    background: nil,
                    defaultBackgroundSettings: defaultBackgroundSettings,
                    blurDefaultBackground: false
                )

                EditorAdaptivePresentationText(
                    text: slide.text,
                    configuration: textConfiguration,
                    containerSize: CGSize(width: 156, height: 88),
                    sizing: .scaledApproximation
                )
            }
            .frame(height: 96)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))

            if slide.style != nil {
                Text("Custom style")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.green)
            }
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.primary.opacity(0.04))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.08), lineWidth: 1)
        }
    }
}
