//
//  LyricEditorSlideHorizontalListView.swift
//  Lyriora
//

import SwiftUI

struct LyricEditorSlideHorizontalListView: View {
    let slides: [LyricSlide]
    let styleProfile: LyricStyleProfile
    let language: LyricLanguage

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
                                language: language
                            )
                            .frame(width: cardWidth)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 2)
            }
            .frame(height: rowHeight)
        }
    }
}

private struct LyricEditorSlideCard: View {
    let slide: LyricSlide
    let style: SlideTextStyle
    let language: LyricLanguage

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
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.05, green: 0.11, blue: 0.24),
                                Color(red: 0.10, green: 0.22, blue: 0.44)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                EditorAdaptivePresentationText(
                    text: slide.text,
                    configuration: textConfiguration,
                    containerSize: CGSize(width: 156, height: 88)
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
