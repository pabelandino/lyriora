//
//  PresentationPreviewView.swift
//  Lyriora
//

import SwiftUI

struct PresentationPreviewView: View {
    let state: PresentationState
    let fallbackConfiguration: PresentationTextConfiguration
    let defaultBackgroundSettings: DefaultBackgroundSettings
    let backgroundContentMode: BackgroundContentMode
    let presentationCanvasSize: CGSize
    let displayInfo: ExternalDisplayInfo

    private let cornerRadius: CGFloat = 28
    private let stageCornerRadius: CGFloat = 14

    private var canvasSize: CGSize {
        PresentationLayout.resolvedCanvasSize(presentationCanvasSize)
    }

    private var canvasAspectRatio: CGFloat {
        PresentationLayout.aspectRatio(for: canvasSize)
    }

    private var showsSlidePlaceholder: Bool {
        state.showLyrics && state.slideText == nil
    }

    var body: some View {
        VStack(spacing: 10) {
            previewStage
            previewMetadataBar
        }
        .padding(12)
        .glassEffect(.regular, in: .rect(cornerRadius: cornerRadius, style: .continuous))
        .allowsHitTesting(false)
    }

    private var previewStage: some View {
        Color.clear
            .aspectRatio(canvasAspectRatio, contentMode: .fit)
            .frame(maxWidth: .infinity)
            .overlay {
                GeometryReader { geometry in
                    let fittedSize = geometry.size
                    let scale = fittedSize.width / canvasSize.width

                    ZStack {
                        PresentationContentView(
                            state: state,
                            fallbackConfiguration: fallbackConfiguration,
                            defaultBackgroundSettings: defaultBackgroundSettings,
                            backgroundContentMode: backgroundContentMode,
                            canvasSize: canvasSize
                        )
                        .frame(width: canvasSize.width, height: canvasSize.height)
                        .scaleEffect(scale)
                        .frame(width: fittedSize.width, height: fittedSize.height)
                        .clipped()

                        if showsSlidePlaceholder {
                            RoundedRectangle(cornerRadius: stageCornerRadius, style: .continuous)
                                .fill(.black.opacity(0.45))

                            Text("Select a slide to preview")
                                .font(.title3.weight(.medium))
                                .foregroundStyle(.white.opacity(0.85))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 24)
                        }
                    }
                    .frame(width: fittedSize.width, height: fittedSize.height)
                    .clipShape(RoundedRectangle(cornerRadius: stageCornerRadius, style: .continuous))
                }
                .allowsHitTesting(false)
            }
            .background(Color.black.opacity(0.92))
            .clipShape(RoundedRectangle(cornerRadius: stageCornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: stageCornerRadius, style: .continuous)
                    .strokeBorder(.white.opacity(0.12), lineWidth: 1)
            }
            .allowsHitTesting(false)
    }

    private var previewMetadataBar: some View {
        HStack(spacing: 8) {
            Label("Live preview", systemImage: "play.rectangle")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            Spacer(minLength: 8)

            if displayInfo.isConnected {
                Label(displayInfo.resolutionDescription, systemImage: "display")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            } else {
                Text("1920 × 1080 reference")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(.horizontal, 4)
    }
}

struct ExternalPresentationView: View {
    @Bindable var viewModel: AppViewModel
    var layoutRevision: Int

    var body: some View {
        PresentationContentView(
            state: viewModel.presentationState,
            fallbackConfiguration: PresentationTextConfiguration(settings: viewModel.settings.externalDisplay),
            defaultBackgroundSettings: viewModel.settings.defaultBackground,
            backgroundContentMode: viewModel.settings.backgroundContentMode,
            canvasSize: PresentationLayout.resolvedCanvasSize(
                viewModel.externalDisplayManager.presentationCanvasSize
            )
        )
        .id(layoutRevision)
        .ignoresSafeArea()
    }
}

struct PresentationContentView: View {
    let state: PresentationState
    let fallbackConfiguration: PresentationTextConfiguration
    let defaultBackgroundSettings: DefaultBackgroundSettings
    var backgroundContentMode: BackgroundContentMode = .fill
    var canvasSize: CGSize = PresentationLayout.referenceCanvasSize

    private var textConfiguration: PresentationTextConfiguration {
        if let style = state.slideStyle {
            return style.presentationConfiguration(isPreview: false)
        }
        return fallbackConfiguration
    }

    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay {
                ZStack {
                    if state.showBackground, let background = state.background {
                        PresentationBackgroundView(
                            background: background,
                            defaultBackgroundSettings: defaultBackgroundSettings,
                            contentMode: backgroundContentMode,
                            canvasSize: canvasSize
                        )
                    }

                    if state.showLyrics, let slideText = state.slideText {
                        AdaptivePresentationText(
                            text: slideText,
                            configuration: textConfiguration
                        )
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .ignoresSafeArea()
    }
}
