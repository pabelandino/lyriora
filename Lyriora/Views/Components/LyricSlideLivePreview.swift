//
//  LyricSlideLivePreview.swift
//  Lyriora
//

import SwiftUI

enum LyricPreviewBackgroundStyle: Equatable {
    case borderOnly
    case settingsDefault(DefaultBackgroundSettings)
}

struct LyricSlideLivePreview: View {
    let slide: LyricSlide?
    let style: SlideTextStyle
    let language: LyricLanguage
    let scopeLabel: String
    var compact: Bool = false
    var previewText: String?
    var backgroundStyle: LyricPreviewBackgroundStyle = .settingsDefault(.default)

    @Environment(\.previewContainerSize) private var previewContainerSize

    private var cornerRadius: CGFloat { compact ? 18 : 20 }
    private var compactHeight: CGFloat { 200 }

    private var displayText: String {
        previewText ?? slide?.text ?? ""
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    private var previewConfiguration: PresentationTextConfiguration {
        style.presentationConfiguration(isPreview: compact)
    }

    private var referenceCanvasSize: CGSize {
        PresentationLayout.textStylePreviewCanvasSize
    }

    private var resolvedContainerSize: CGSize {
        if let previewContainerSize, previewContainerSize.width > 1 {
            return previewContainerSize
        }
        return CGSize(width: 640, height: compact ? compactHeight : 400)
    }

    var body: some View {
        if compact {
            referenceCanvasPreview
                .frame(maxWidth: resolvedContainerSize.width)
                .frame(maxWidth: .infinity)
        } else {
            VStack(spacing: 12) {
                headerRow
                legacyPreviewCard
            }
            .frame(width: resolvedContainerSize.width, alignment: .center)
        }
    }

    @ViewBuilder
    private var headerRow: some View {
        HStack {
            Text(scopeLabel)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            Spacer()

            if let slide {
                Text(slide.tag.localizedName(for: language))
                    .font(.caption.weight(.bold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.ultraThinMaterial, in: Capsule())
            }
        }
    }

    @ViewBuilder
    private var referenceCanvasPreview: some View {
        let canvas = referenceCanvasSize

        GeometryReader { geometry in
            let fittedSize = geometry.size
            let scale = fittedSize.width / canvas.width

            ZStack {
                previewBackground
                    .frame(width: canvas.width, height: canvas.height)
                    .scaleEffect(scale)
                    .frame(width: fittedSize.width, height: fittedSize.height)

                if !displayText.isEmpty {
                    EditorAdaptivePresentationText(
                        text: displayText,
                        configuration: previewConfiguration,
                        containerSize: canvas,
                        sizing: .exact
                    )
                    .frame(width: canvas.width, height: canvas.height)
                    .scaleEffect(scale)
                    .frame(width: fittedSize.width, height: fittedSize.height)
                } else {
                    Text("Select a slide or import lyrics to preview.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(
                            backgroundStyle == .borderOnly
                                ? Color.secondary
                                : Color.white.opacity(0.65)
                        )
                        .padding(24)
                }
            }
        }
        .clipShape(shape)
        .overlay {
            if backgroundStyle == .borderOnly {
                shape.strokeBorder(Color.primary.opacity(0.18), lineWidth: 1.5)
            }
        }
        .allowsHitTesting(false)
    }

    @ViewBuilder
    private var legacyPreviewCard: some View {
        let size = resolvedContainerSize

        ZStack {
            previewBackground

            previewCardContent(containerSize: size, sizing: .scaledApproximation)
        }
        .frame(width: size.width, height: size.height)
        .clipShape(shape)
        .overlay {
            if backgroundStyle == .borderOnly {
                shape.strokeBorder(Color.primary.opacity(0.18), lineWidth: 1.5)
            }
        }
    }

    @ViewBuilder
    private var previewBackground: some View {
        switch backgroundStyle {
        case .borderOnly:
            Color.clear
        case .settingsDefault(let settings):
            PresentationBackgroundLayer(
                background: nil,
                defaultBackgroundSettings: settings,
                blurDefaultBackground: false
            )
        }
    }

    @ViewBuilder
    private func previewCardContent(
        containerSize: CGSize,
        sizing: EditorPreviewSizing
    ) -> some View {
        if !displayText.isEmpty {
            EditorAdaptivePresentationText(
                text: displayText,
                configuration: previewConfiguration,
                containerSize: containerSize,
                sizing: sizing
            )
        } else {
            Text("Select a slide or import lyrics to preview.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(backgroundStyle == .borderOnly ? Color.secondary : Color.white.opacity(0.65))
                .padding(24)
                .frame(width: containerSize.width, height: containerSize.height, alignment: .center)
        }
    }
}
