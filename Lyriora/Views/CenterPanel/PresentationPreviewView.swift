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
        viewModel.showsVideoPlaybackControls
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
                PresentationVideoControls(viewModel: viewModel, scrubValue: $scrubValue)
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

    private var usesLocalVideoPlayerStage: Bool {
        isVideoBackground && !(state.background?.isYouTube ?? false)
    }

    @ViewBuilder
    private func previewStageContent(fittedSize: CGSize, scale: CGFloat) -> some View {
        if usesLocalVideoPlayerStage {
            ZStack {
                Color.black

                if let background = state.background {
                    PresentationBackgroundView(
                        background: background,
                        defaultBackgroundSettings: defaultBackgroundSettings,
                        contentMode: backgroundContentMode,
                        canvasSize: canvasSize,
                        sharedVideoPlayer: viewModel.videoPlayback.player,
                        videoLoops: state.videoLoops,
                        isVideoPlaying: state.isVideoPlaying,
                        videoStopToken: state.videoStopToken,
                        youtubePlayback: viewModel.youtubePlayback
                    )
                    .frame(width: fittedSize.width, height: fittedSize.height)
                }

                if state.showLyrics, let slideText = state.slideText {
                    AdaptivePresentationText(
                        text: slideText,
                        configuration: textConfiguration,
                        animationProfile: state.slideAnimationProfile ?? SlideAnimationProfile(),
                        wordFontSizeOverrides: state.wordFontSizeOverrides,
                        slideID: state.slideID ?? AdaptivePresentationText.placeholderSlideID,
                        presentationToken: state.slidePresentationToken,
                        animationQuality: .preview
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
                sharedVideoPlayer: viewModel.videoPlayback.player,
                youtubePlayback: viewModel.youtubePlayback,
                animationQuality: .preview
            )
            .frame(width: canvasSize.width, height: canvasSize.height)
            .scaleEffect(scale)
            .frame(width: fittedSize.width, height: fittedSize.height)
            .clipped()
        }
    }
}

private struct PresentationVideoControls: View {
    @Bindable var viewModel: AppViewModel
    @Binding var scrubValue: TimeInterval
    @Bindable private var videoPlayback: VideoPlaybackController
    @Bindable private var youtubePlayback: YouTubePlaybackController

    init(viewModel: AppViewModel, scrubValue: Binding<TimeInterval>) {
        self.viewModel = viewModel
        self._scrubValue = scrubValue
        self._videoPlayback = Bindable(viewModel.videoPlayback)
        self._youtubePlayback = Bindable(viewModel.youtubePlayback)
    }

    var body: some View {
        VStack(spacing: 6) {
            Slider(
                value: sliderBinding,
                in: 0...max(activeDuration, 0.01)
            ) { editing in
                if usesYouTubePlayback {
                    youtubePlayback.isScrubbing = editing
                    if editing {
                        scrubValue = youtubePlayback.currentTime
                    } else {
                        viewModel.seekVideo(to: scrubValue)
                    }
                } else {
                    videoPlayback.isScrubbing = editing
                    if editing {
                        scrubValue = videoPlayback.currentTime
                    } else {
                        viewModel.seekVideo(to: scrubValue)
                    }
                }
            }
            .tint(.green)

            HStack(spacing: 8) {
                Text(VideoDurationFormatter.playbackTime(for: displayedCurrentTime))
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)

                Spacer(minLength: 8)

                Text(VideoDurationFormatter.playbackTime(for: activeDuration))
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 4)
    }

    private var usesYouTubePlayback: Bool {
        viewModel.hasYouTubeBackgroundSelected
    }

    private var activeDuration: TimeInterval {
        usesYouTubePlayback ? youtubePlayback.duration : videoPlayback.duration
    }

    private var sliderBinding: Binding<TimeInterval> {
        Binding(
            get: {
                if usesYouTubePlayback {
                    return youtubePlayback.isScrubbing ? scrubValue : youtubePlayback.currentTime
                }
                return videoPlayback.isScrubbing ? scrubValue : videoPlayback.currentTime
            },
            set: { newValue in
                scrubValue = newValue
            }
        )
    }

    private var displayedCurrentTime: TimeInterval {
        if usesYouTubePlayback {
            return youtubePlayback.isScrubbing ? scrubValue : youtubePlayback.currentTime
        }
        return videoPlayback.isScrubbing ? scrubValue : videoPlayback.currentTime
    }
}

extension PresentationPreviewView {
    private var previewMetadataBar: some View {
        HStack(spacing: 8) {
            if state.isBiblePresentation,
               let reference = state.bibleReferenceLabel,
               let version = state.bibleVersionName {
                Label(reference, systemImage: "book")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                Text(version)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .lineLimit(1)
            } else {
                Label("Live preview", systemImage: "play.rectangle")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }

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
            sharedVideoPlayer: viewModel.videoPlayback.player,
            youtubePlayback: viewModel.youtubePlayback,
            isAnimating: true,
            animationQuality: .live
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
    var youtubePlayback: YouTubePlaybackController?
    var isAnimating: Bool = true
    var animationQuality: PresentationAnimationQuality = .live

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
                            sharedVideoPlayer: sharedVideoPlayer,
                            videoLoops: state.videoLoops,
                            isVideoPlaying: state.isVideoPlaying,
                            videoStopToken: state.videoStopToken,
                            youtubePlayback: youtubePlayback
                        )
                    }

                    if state.showLyrics, let slideText = state.slideText {
                        AdaptivePresentationText(
                            text: slideText,
                            configuration: textConfiguration,
                            animationProfile: state.slideAnimationProfile ?? SlideAnimationProfile(),
                            wordFontSizeOverrides: state.wordFontSizeOverrides,
                            slideID: state.slideID ?? AdaptivePresentationText.placeholderSlideID,
                            presentationToken: state.slidePresentationToken,
                            isAnimating: isAnimating,
                            animationQuality: animationQuality
                        )
                    }

                    if state.isBiblePresentation,
                       let reference = state.bibleReferenceLabel,
                       let version = state.bibleVersionName {
                        VStack {
                            Spacer()
                            BiblePresentationFooterView(reference: reference, versionName: version)
                                .padding(.horizontal, canvasSize.width * 0.06)
                                .padding(.bottom, canvasSize.height * 0.05)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .ignoresSafeArea()
    }
}

struct BiblePresentationFooterView: View {
    let reference: String
    let versionName: String

    var body: some View {
        HStack(spacing: 12) {
            Text(reference)
                .font(.title3.weight(.semibold))
            Spacer(minLength: 8)
            Text(versionName)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .background {
            Capsule(style: .continuous)
                .fill(.black.opacity(0.45))
                .glassEffect(.regular, in: .capsule)
        }
    }
}
