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
    private static let placeholderSlideID = UUID()

    let slide: LyricSlide?
    let style: SlideTextStyle
    let language: LyricLanguage
    let scopeLabel: String
    var compact: Bool = false
    var previewText: String?
    var backgroundStyle: LyricPreviewBackgroundStyle = .settingsDefault(.default)
    var animationProfile: SlideAnimationProfile = SlideAnimationProfile()
    var selectedTransitionTarget: TextAnimationTarget?
    var selectedEffectTarget: TextAnimationTarget?
    var isAnimationPlaying: Bool = true
    var showsAnimations: Bool = false
    var isInteractive: Bool = false
    var transitionReplayToken: Int = 0
    var skipsTransitionOnSlideChange: Bool = false
    var onWordTap: ((Int, Int) -> Void)?
    var onTransitionReplay: (() -> Void)? = nil

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
        let aspect = canvas.width / max(canvas.height, 1)

        Color.clear
            .aspectRatio(aspect, contentMode: .fit)
            .overlay {
                GeometryReader { geometry in
                    let fittedSize = geometry.size
                    let scale = fittedSize.width / canvas.width

                    ZStack {
                        previewBackground
                            .frame(width: canvas.width, height: canvas.height)
                            .scaleEffect(scale)
                            .frame(width: fittedSize.width, height: fittedSize.height)

                        if !displayText.isEmpty {
                            editorTextPreview(
                                text: displayText,
                                containerSize: canvas,
                                sizing: .exact,
                                scale: scale,
                                fittedSize: fittedSize
                            )
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
                    .frame(width: fittedSize.width, height: fittedSize.height)
                }
            }
            .clipShape(shape)
            .overlay {
                if backgroundStyle == .borderOnly {
                    shape.strokeBorder(Color.primary.opacity(0.18), lineWidth: 1.5)
                }
            }
            .overlay(alignment: .topTrailing) {
                if let onTransitionReplay, animationProfile.hasTransition {
                    Button(action: onTransitionReplay) {
                        Label("Replay", systemImage: "arrow.clockwise")
                            .font(.caption.weight(.semibold))
                            .labelStyle(.iconOnly)
                            .frame(width: 32, height: 32)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .buttonStyle(.plain)
                    .padding(10)
                    .help("Replay transition")
                }
            }
            .contentShape(shape)
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
            editorTextPreview(
                text: displayText,
                containerSize: containerSize,
                sizing: sizing,
                scale: 1,
                fittedSize: containerSize
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

    @ViewBuilder
    private func editorTextPreview(
        text: String,
        containerSize: CGSize,
        sizing: EditorPreviewSizing,
        scale: CGFloat,
        fittedSize: CGSize
    ) -> some View {
        let activeConfiguration: PresentationTextConfiguration = {
            switch sizing {
            case .exact:
                previewConfiguration
            case .scaledApproximation:
                previewConfiguration.scaledApproximation(for: containerSize)
            }
        }()

        let insets = activeConfiguration.contentInsets(for: containerSize)
        let availableSize = activeConfiguration.availableTextSize(in: containerSize)
        let fontSize: CGFloat = {
            switch sizing {
            case .exact:
                if !activeConfiguration.isAdaptiveScalingEnabled {
                    return activeConfiguration.maxFontSize
                }
                return PresentationTextMeasurer.fittingFontSize(
                    text: text,
                    in: availableSize,
                    configuration: activeConfiguration
                )
            case .scaledApproximation:
                return PresentationTextMeasurer.fittingFontSize(
                    text: text,
                    in: availableSize,
                    configuration: activeConfiguration
                )
            }
        }()

        SlideTransitionTextContainer(
            slideID: slide?.id ?? Self.placeholderSlideID,
            text: text,
            playsTransition: showsAnimations && animationProfile.hasTransition,
            transitionSpeed: animationProfile.previewTransitionSpeed(selectedTarget: selectedTransitionTarget),
            transitionWordStagger: animationProfile.transitionWordStagger,
            replayToken: transitionReplayToken,
            skipsTransitionOnSlideChange: skipsTransitionOnSlideChange
        ) { transitionState, displayedText in
            if showsAnimations || isInteractive {
                AnimatedPresentationText(
                    text: displayedText,
                    configuration: activeConfiguration,
                    availableSize: availableSize,
                    fontSize: fontSize,
                    animationProfile: animationProfile,
                    transitionState: transitionState,
                    selectedTransitionTarget: selectedTransitionTarget,
                    selectedEffectTarget: selectedEffectTarget,
                    isAnimating: showsAnimations && isAnimationPlaying,
                    isInteractive: isInteractive,
                    scalesToFitWidth: activeConfiguration.isAdaptiveScalingEnabled,
                    onSelectionTap: onWordTap
                )
            } else {
                ExplicitLinePresentationText(
                    lines: PresentationTextMeasurer.explicitLines(from: displayedText),
                    fontSize: fontSize,
                    configuration: activeConfiguration,
                    availableSize: availableSize,
                    scalesToFitWidth: activeConfiguration.isAdaptiveScalingEnabled
                )
            }
        }
        .padding(insets)
        .frame(width: containerSize.width, height: containerSize.height, alignment: .center)
        .scaleEffect(scale)
        .frame(width: fittedSize.width, height: fittedSize.height)
        .allowsHitTesting(isInteractive)
    }
}
