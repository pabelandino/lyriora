//
//  PresentationPreviewView.swift
//  Lyriora
//

import AVFoundation
import SwiftUI

struct PresentationPreviewView: View {
    @Bindable var viewModel: AppViewModel
    let state: PresentationState
    let fallbackConfiguration: PresentationTextConfiguration
    let defaultBackgroundSettings: DefaultBackgroundSettings
    let backgroundContentMode: BackgroundContentMode
    let presentationCanvasSize: CGSize
    let displayInfo: ExternalDisplayInfo

    @Bindable private var videoPlayback: VideoPlaybackController
    @State private var scrubValue: TimeInterval = 0

    private let cornerRadius: CGFloat = 28
    private let stageCornerRadius: CGFloat = 14

    init(
        viewModel: AppViewModel,
        state: PresentationState,
        fallbackConfiguration: PresentationTextConfiguration,
        defaultBackgroundSettings: DefaultBackgroundSettings,
        backgroundContentMode: BackgroundContentMode,
        presentationCanvasSize: CGSize,
        displayInfo: ExternalDisplayInfo
    ) {
        self.viewModel = viewModel
        self.state = state
        self.fallbackConfiguration = fallbackConfiguration
        self.defaultBackgroundSettings = defaultBackgroundSettings
        self.backgroundContentMode = backgroundContentMode
        self.presentationCanvasSize = presentationCanvasSize
        self.displayInfo = displayInfo
        self._videoPlayback = Bindable(viewModel.videoPlayback)
    }

    private var canvasSize: CGSize {
        PresentationLayout.resolvedCanvasSize(presentationCanvasSize)
    }

    private var canvasAspectRatio: CGFloat {
        PresentationLayout.aspectRatio(for: canvasSize)
    }

    private var showsSlidePlaceholder: Bool {
        state.showLyrics && state.slideText == nil
    }

    private var showsVideoControls: Bool {
        viewModel.hasVideoBackgroundSelected && state.showBackground
    }

    private var isVideoBackground: Bool {
        state.showBackground && state.background?.kind == .video
    }

    private var textConfiguration: PresentationTextConfiguration {
        if let style = state.slideStyle {
            return style.presentationConfiguration(isPreview: false)
        }
        return fallbackConfiguration
    }

    var body: some View {
        VStack(spacing: 10) {
            previewStage

            if showsVideoControls {
                videoPlaybackControls
            }

            previewMetadataBar
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(.clear)
                .glassEffect(.regular, in: .rect(cornerRadius: cornerRadius, style: .continuous))
        }
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
                        previewStageContent(fittedSize: fittedSize, scale: scale)

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

    @ViewBuilder
    private func previewStageContent(fittedSize: CGSize, scale: CGFloat) -> some View {
        if isVideoBackground {
            ZStack {
                Color.black

                if let background = state.background {
                    PresentationBackgroundView(
                        background: background,
                        defaultBackgroundSettings: defaultBackgroundSettings,
                        contentMode: backgroundContentMode,
                        canvasSize: canvasSize,
                        sharedVideoPlayer: viewModel.videoPlayback.player
                    )
                    .frame(width: fittedSize.width, height: fittedSize.height)
                }

                if state.showLyrics, let slideText = state.slideText {
                    AdaptivePresentationText(
                        text: slideText,
                        configuration: textConfiguration
                    )
                    .frame(width: canvasSize.width, height: canvasSize.height)
                    .scaleEffect(scale)
                    .frame(width: fittedSize.width, height: fittedSize.height)
                }
            }
            .frame(width: fittedSize.width, height: fittedSize.height)
            .clipped()
        } else {
            PresentationContentView(
                state: state,
                fallbackConfiguration: fallbackConfiguration,
                defaultBackgroundSettings: defaultBackgroundSettings,
                backgroundContentMode: backgroundContentMode,
                canvasSize: canvasSize,
                sharedVideoPlayer: viewModel.videoPlayback.player
            )
            .frame(width: canvasSize.width, height: canvasSize.height)
            .scaleEffect(scale)
            .frame(width: fittedSize.width, height: fittedSize.height)
            .clipped()
            .drawingGroup()
        }
    }

    private var videoPlaybackControls: some View {
        VStack(spacing: 6) {
            Slider(
                value: sliderBinding,
                in: 0...max(videoPlayback.duration, 0.01)
            ) { editing in
                videoPlayback.isScrubbing = editing
                if editing {
                    scrubValue = videoPlayback.currentTime
                } else {
                    viewModel.seekVideo(to: scrubValue)
                }
            }
            .tint(.green)

            HStack(spacing: 8) {
                Text(VideoDurationFormatter.playbackTime(for: displayedCurrentTime))
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)

                Spacer(minLength: 8)

                Text(VideoDurationFormatter.playbackTime(for: videoPlayback.duration))
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 4)
    }

    private var sliderBinding: Binding<TimeInterval> {
        Binding(
            get: {
                videoPlayback.isScrubbing ? scrubValue : videoPlayback.currentTime
            },
            set: { newValue in
                scrubValue = newValue
            }
        )
    }

    private var displayedCurrentTime: TimeInterval {
        videoPlayback.isScrubbing ? scrubValue : videoPlayback.currentTime
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
        .allowsHitTesting(false)
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
            ),
            sharedVideoPlayer: viewModel.videoPlayback.player
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
    var sharedVideoPlayer: AVPlayer?

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
                            canvasSize: canvasSize,
                            sharedVideoPlayer: sharedVideoPlayer
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
