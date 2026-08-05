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
    var backgroundContentMode: BackgroundContentMode = .fill
    var presentationCanvasSize: CGSize = .zero
    let onSelect: (LyricSlide) -> Void

    private var layoutCanvasSize: CGSize {
        PresentationLayout.resolvedCanvasSize(presentationCanvasSize)
    }

    private let thumbnailWidth: CGFloat = 168
    private let gridSpacing: CGFloat = 8
    private let horizontalPadding: CGFloat = 16
    private let verticalPadding: CGFloat = 14

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            if slides.isEmpty {
                ContentUnavailableView(
                    "No slides",
                    systemImage: "rectangle.on.rectangle.slash",
                    description: Text("Select a lyric from the library to see its slides.")
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                GeometryReader { geometry in
                    ScrollView {
                        slideRows(in: geometry.size.width)
                            .padding(.horizontal, horizontalPadding)
                            .padding(.vertical, verticalPadding)
                    }
                    .transparentScrollContent()
                }
            }
        }
    }

    @ViewBuilder
    private func slideRows(in totalWidth: CGFloat) -> some View {
        let availableWidth = max(0, totalWidth - (horizontalPadding * 2))
        let columnCount = Self.columnCount(
            for: availableWidth,
            thumbnailWidth: thumbnailWidth,
            spacing: gridSpacing
        )
        let rows = Self.rowChunks(from: slides, columnCount: columnCount)

        VStack(spacing: gridSpacing) {
            ForEach(Array(rows.enumerated()), id: \.offset) { _, rowSlides in
                HStack(spacing: gridSpacing) {
                    ForEach(rowSlides, id: \.order) { slide in
                        SlideThumbnailView(
                            slide: slide,
                            style: styleProfile?.resolvedStyle(for: slide),
                            language: language,
                            isSelected: slide.index == selectedSlideIndex,
                            presentationState: presentationState,
                            defaultBackgroundSettings: defaultBackgroundSettings,
                            backgroundContentMode: backgroundContentMode,
                            canvasSize: layoutCanvasSize
                        )
                        .frame(width: thumbnailWidth)
                        .onTapGesture {
                            onSelect(slide)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private static func columnCount(
        for availableWidth: CGFloat,
        thumbnailWidth: CGFloat,
        spacing: CGFloat
    ) -> Int {
        max(1, Int((availableWidth + spacing) / (thumbnailWidth + spacing)))
    }

    private static func rowChunks(from slides: [LyricSlide], columnCount: Int) -> [[LyricSlide]] {
        guard !slides.isEmpty else { return [] }

        return stride(from: 0, to: slides.count, by: columnCount).map { start in
            Array(slides[start..<min(start + columnCount, slides.count)])
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
    var backgroundContentMode: BackgroundContentMode = .fill
    var canvasSize: CGSize = PresentationLayout.referenceCanvasSize

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

    private var usesDefaultGradientBackground: Bool {
        presentationState.background?.kind == .video
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
                    background: usesDefaultGradientBackground ? nil : presentationState.background,
                    defaultBackgroundSettings: defaultBackgroundSettings,
                    contentMode: backgroundContentMode,
                    canvasSize: canvasSize,
                    blurDefaultBackground: false,
                    showsDefaultWhenEmpty: usesDefaultGradientBackground
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
