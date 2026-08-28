//
//  AnimatedPresentationText.swift
//  Lyriora
//

import SwiftUI

struct AnimatedPresentationText: View {
    let text: String
    let configuration: PresentationTextConfiguration
    let availableSize: CGSize
    let fontSize: CGFloat
    var animationProfile: SlideAnimationProfile = SlideAnimationProfile()
    var transitionState: SlideTransitionState = SlideTransitionState()
    var selectedTransitionTarget: TextAnimationTarget?
    var selectedEffectTarget: TextAnimationTarget?
    var isAnimating: Bool = true
    var animationQuality: PresentationAnimationQuality = .preview
    var isInteractive: Bool = false
    var scalesToFitWidth: Bool = false
    var wordFontSizeOverrides: [WordFontSizeOverride] = []
    var selectedFontSizeTarget: TextAnimationTarget? = nil
    var onSelectionTap: ((Int, Int) -> Void)?

    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let parsed: ParsedSlideText

    init(
        text: String,
        configuration: PresentationTextConfiguration,
        availableSize: CGSize,
        fontSize: CGFloat,
        animationProfile: SlideAnimationProfile = SlideAnimationProfile(),
        transitionState: SlideTransitionState = SlideTransitionState(),
        selectedTransitionTarget: TextAnimationTarget? = nil,
        selectedEffectTarget: TextAnimationTarget? = nil,
        isAnimating: Bool = true,
        animationQuality: PresentationAnimationQuality = .preview,
        isInteractive: Bool = false,
        scalesToFitWidth: Bool = false,
        wordFontSizeOverrides: [WordFontSizeOverride] = [],
        selectedFontSizeTarget: TextAnimationTarget? = nil,
        onSelectionTap: ((Int, Int) -> Void)? = nil
    ) {
        self.text = text
        self.configuration = configuration
        self.availableSize = availableSize
        self.fontSize = fontSize
        self.animationProfile = animationProfile
        self.transitionState = transitionState
        self.selectedTransitionTarget = selectedTransitionTarget
        self.selectedEffectTarget = selectedEffectTarget
        self.isAnimating = isAnimating
        self.animationQuality = animationQuality
        self.isInteractive = isInteractive
        self.scalesToFitWidth = scalesToFitWidth
        self.wordFontSizeOverrides = wordFontSizeOverrides
        self.selectedFontSizeTarget = selectedFontSizeTarget
        self.onSelectionTap = onSelectionTap
        self.parsed = SlideTextTokenizer.parse(text)
    }

    private func resolvedFontSize(lineIndex: Int, wordIndex: Int) -> CGFloat {
        WordFontSizeResolver.fontSize(
            for: lineIndex,
            word: wordIndex,
            base: fontSize,
            overrides: wordFontSizeOverrides
        )
    }

    private var proRenderQuality: ProTextRenderQuality {
        animationQuality == .live ? .live : .preview
    }

    private var shouldRenderAnimatedContent: Bool {
        animationProfile.hasAnimations || isInteractive
            || selectedTransitionTarget != nil || selectedEffectTarget != nil
            || selectedFontSizeTarget != nil
            || !wordFontSizeOverrides.isEmpty
    }

    private var allowsEffectTimelineUpdates: Bool {
        // External/live output runs in a separate UIWindowScene whose phase is often
        // not `.active` while the iPad window has focus — keep live effects running.
        animationQuality == .live || scenePhase == .active
    }

    private var shouldRunEffectTimeline: Bool {
        isAnimating
            && !reduceMotion
            && allowsEffectTimelineUpdates
            && animationProfile.hasPersistentEffects
            && transitionState.showsPersistentEffects
    }

    var body: some View {
        if shouldRenderAnimatedContent {
            animatedBody
        } else {
            ExplicitLinePresentationText(
                lines: PresentationTextMeasurer.explicitLines(from: text),
                fontSize: fontSize,
                configuration: configuration,
                availableSize: availableSize,
                scalesToFitWidth: scalesToFitWidth
            )
        }
    }

    @ViewBuilder
    private var animatedBody: some View {
        if animationProfile.hasPersistentEffects {
            TimelineView(
                .animation(
                    minimumInterval: animationQuality.effectFrameInterval,
                    paused: !shouldRunEffectTimeline
                )
            ) { context in
                textStack(time: context.date.timeIntervalSinceReferenceDate)
            }
        } else {
            textStack(time: 0)
        }
    }

    @ViewBuilder
    private func textStack(time: TimeInterval) -> some View {
        VStack(spacing: configuration.lineSpacing) {
            ForEach(Array(parsed.paragraphLineRanges.enumerated()), id: \.offset) { paragraphIndex, lineRange in
                paragraphGroupView(
                    paragraphIndex: paragraphIndex,
                    lineRange: lineRange,
                    time: time
                )
            }
        }
        .frame(width: availableSize.width, height: availableSize.height, alignment: .center)
        .shadow(
            color: configuration.shadowEnabled
                ? configuration.shadowColor.opacity(configuration.shadowOpacity)
                : .clear,
            radius: configuration.shadowRadius,
            y: configuration.shadowYOffset
        )
    }

    @ViewBuilder
    private func paragraphGroupView(
        paragraphIndex: Int,
        lineRange: Range<Int>,
        time: TimeInterval
    ) -> some View {
        let paragraphUsesContainer = false

        VStack(spacing: configuration.lineSpacing) {
            ForEach(Array(lineRange), id: \.self) { lineIndex in
                if parsed.lines[lineIndex].isEmpty {
                    emptyLinePlaceholder
                } else {
                    lineGroupView(
                        lineIndex: lineIndex,
                        paragraphIndex: paragraphIndex,
                        time: time,
                        suppressWordMotion: paragraphUsesContainer
                    )
                }
            }
        }
    }

    @ViewBuilder
    private func lineGroupView(
        lineIndex: Int,
        paragraphIndex: Int,
        time: TimeInterval,
        suppressWordMotion: Bool
    ) -> some View {
        let words = parsed.lines[lineIndex]

        HStack(spacing: fontSize * 0.22) {
            ForEach(Array(words.enumerated()), id: \.offset) { wordIndex, word in
                wordView(
                    word: word,
                    lineIndex: lineIndex,
                    wordIndex: wordIndex,
                    paragraphIndex: paragraphIndex,
                    time: time,
                    suppressWordMotion: suppressWordMotion
                )
                .fixedSize(horizontal: true, vertical: false)
            }
        }
        .scaledToFitWidth(maxWidth: availableSize.width, enabled: true)
    }

    @ViewBuilder
    private func wordView(
        word: String,
        lineIndex: Int,
        wordIndex: Int,
        paragraphIndex: Int,
        time: TimeInterval,
        suppressWordMotion: Bool
    ) -> some View {
        let matchesTransition = selectedTransitionTarget.map {
            TextAnimationSelectionResolver.matches(
                target: $0,
                lineIndex: lineIndex,
                wordIndex: wordIndex,
                parsed: parsed
            )
        } ?? false

        let matchesEffect = selectedEffectTarget.map {
            TextAnimationSelectionResolver.matches(
                target: $0,
                lineIndex: lineIndex,
                wordIndex: wordIndex,
                parsed: parsed
            )
        } ?? false

        let matchesFontSize = selectedFontSizeTarget.map {
            TextAnimationSelectionResolver.matches(
                target: $0,
                lineIndex: lineIndex,
                wordIndex: wordIndex,
                parsed: parsed
            )
        } ?? false

        let isSelected = matchesTransition || matchesEffect || matchesFontSize
        let selectionColor: Color = {
            if matchesTransition && matchesEffect {
                return .accentColor
            }
            if matchesFontSize && (matchesTransition || matchesEffect) {
                return .orange
            }
            if matchesFontSize {
                return .orange
            }
            return matchesTransition ? .blue : .purple
        }()

        let resolvedEffect = animationProfile.resolvedEffectAnimation(
            lineIndex: lineIndex,
            wordIndex: wordIndex,
            paragraphIndex: paragraphIndex,
            parsed: parsed
        )
        let effectKind = resolvedEffect?.kind ?? .none
        let segmentIndex = animationProfile.effectSegmentIndex(
            lineIndex: lineIndex,
            wordIndex: wordIndex,
            paragraphIndex: paragraphIndex,
            parsed: parsed
        )
        let intensity = resolvedEffect?.intensity ?? animationProfile.effectIntensity
        let speed = resolvedEffect?.speed ?? animationProfile.effectSpeed
        let showsPersistentEffect = transitionState.showsPersistentEffects && effectKind != .none
        let globalWordIndex = parsed.globalWordIndex(lineIndex: lineIndex, wordIndex: wordIndex)
        let totalWords = max(1, parsed.totalWordCount)

        let resolvedTransition = animationProfile.resolvedTransitionAnimation(
            lineIndex: lineIndex,
            wordIndex: wordIndex,
            paragraphIndex: paragraphIndex,
            parsed: parsed
        )
        let transitionKind = resolvedTransition?.kind ?? .none
        let transitionIntensity = resolvedTransition?.intensity ?? animationProfile.transitionIntensity
        let transitionSpeed = resolvedTransition?.speed ?? animationProfile.transitionSpeed
        let transitionSegmentIndex = animationProfile.transitionSegmentIndex(
            lineIndex: lineIndex,
            wordIndex: wordIndex,
            paragraphIndex: paragraphIndex,
            parsed: parsed
        )
        let scopedTransitionWordCount = animationProfile.transitionWordCount(
            lineIndex: lineIndex,
            wordIndex: wordIndex,
            paragraphIndex: paragraphIndex,
            parsed: parsed
        )

        let coreLabel = wordCoreLabel(
            word: word,
            lineIndex: lineIndex,
            wordIndex: wordIndex,
            kind: showsPersistentEffect ? effectKind : .none,
            segmentIndex: segmentIndex,
            time: time,
            intensity: intensity,
            speed: speed
        )

        let labeled = coreLabel
            .padding(.horizontal, isSelected ? 2 : 0)
            .padding(.vertical, isSelected ? 1 : 0)
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(selectionColor.opacity(0.22))
                        .overlay {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .strokeBorder(selectionColor.opacity(0.55), lineWidth: 1)
                        }
                }
            }

        Group {
            if transitionKind != .none {
                transitionWrappedLabel(
                    labeled: labeled,
                    word: word,
                    lineIndex: lineIndex,
                    wordIndex: wordIndex,
                    transitionKind: transitionKind,
                    transitionIntensity: transitionIntensity,
                    transitionSpeed: transitionSpeed,
                    globalWordIndex: globalWordIndex,
                    transitionSegmentIndex: transitionSegmentIndex,
                    totalWords: totalWords,
                    scopedTransitionWordCount: scopedTransitionWordCount
                )
            } else {
                labeled
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            guard isInteractive else { return }
            onSelectionTap?(lineIndex, wordIndex)
        }
    }

    @ViewBuilder
    private func transitionWrappedLabel(
        labeled: some View,
        word: String,
        lineIndex: Int,
        wordIndex: Int,
        transitionKind: TextAnimationKind,
        transitionIntensity: Double,
        transitionSpeed: Double,
        globalWordIndex: Int,
        transitionSegmentIndex: Int,
        totalWords: Int,
        scopedTransitionWordCount: Int
    ) -> some View {
        if transitionKind == .typewriter {
            typewriterTransitionView(
                word: word,
                lineIndex: lineIndex,
                wordIndex: wordIndex,
                globalWordIndex: globalWordIndex,
                totalWords: totalWords,
                intensity: transitionIntensity,
                speed: transitionSpeed
            )
        } else if animationProfile.transitionWordStagger {
            labeled.sequentialWordTransition(
                kind: transitionKind,
                globalProgress: transitionState.enterProgress,
                wordIndex: globalWordIndex,
                totalWords: totalWords,
                isExiting: transitionState.isExiting,
                intensity: transitionIntensity,
                speed: transitionSpeed
            )
        } else {
            let usesSpatialLayout = transitionKind.usesSpatialTransitionLayout
            labeled.slideTransitionEffect(
                kind: transitionKind,
                progress: transitionState.enterProgress,
                isExiting: transitionState.isExiting,
                segmentIndex: usesSpatialLayout ? transitionSegmentIndex : 0,
                totalWords: usesSpatialLayout ? scopedTransitionWordCount : 1,
                intensity: transitionIntensity,
                speed: transitionSpeed
            )
        }
    }

    @ViewBuilder
    private func typewriterTransitionView(
        word: String,
        lineIndex: Int,
        wordIndex: Int,
        globalWordIndex: Int,
        totalWords: Int,
        intensity: Double,
        speed: Double
    ) -> some View {
        let wordFontSize = resolvedFontSize(lineIndex: lineIndex, wordIndex: wordIndex)
        let localProgress: Double = {
            if animationProfile.transitionWordStagger {
                return TextAnimationEffects.sequentialWordLocalProgress(
                    globalProgress: transitionState.enterProgress,
                    wordIndex: globalWordIndex,
                    totalWords: totalWords,
                    isExiting: transitionState.isExiting,
                    speed: speed
                )
            }
            return transitionState.enterProgress
        }()

        if localProgress < 0 {
            TypewriterRevealText(
                text: word,
                progress: 0,
                font: configuration.font(size: wordFontSize),
                color: configuration.textColor,
                showsCursor: false
            )
            .opacity(0)
            .frame(maxWidth: 0)
            .clipped()
            .allowsHitTesting(false)
        } else {
            EmptyView()
                .typewriterTransition(
                    text: word,
                    progress: localProgress,
                    font: configuration.font(size: wordFontSize),
                    color: configuration.textColor,
                    showsCursor: !transitionState.isExiting
                )
        }
    }

    @ViewBuilder
    private func wordCoreLabel(
        word: String,
        lineIndex: Int,
        wordIndex: Int,
        kind: TextAnimationKind,
        segmentIndex: Int,
        time: TimeInterval,
        intensity: Double,
        speed: Double
    ) -> some View {
        let wordFontSize = resolvedFontSize(lineIndex: lineIndex, wordIndex: wordIndex)
        if kind.usesProLayerRendering {
            ProTextSegmentView(
                text: word,
                font: configuration.font(size: wordFontSize),
                color: configuration.textColor,
                kind: kind,
                time: time,
                segmentIndex: segmentIndex,
                intensity: intensity,
                speed: speed,
                renderQuality: proRenderQuality
            )
        } else if kind != .none {
            let transform = TextAnimationEffects.transform(
                kind: kind,
                time: time,
                segmentIndex: segmentIndex,
                intensity: intensity,
                speed: speed
            )
            Text(word)
                .font(configuration.font(size: wordFontSize))
                .foregroundStyle(configuration.textColor)
                .modifier(AnimatedTextSegmentModifier(transform: transform))
        } else {
            Text(word)
                .font(configuration.font(size: wordFontSize))
                .foregroundStyle(configuration.textColor)
        }
    }

    private var emptyLinePlaceholder: some View {
        Text(" ")
            .font(configuration.font(size: fontSize))
            .opacity(0)
            .frame(maxWidth: availableSize.width)
    }
}

private struct NaturalWidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

private extension View {
    func scaledToFitWidth(maxWidth: CGFloat, enabled: Bool) -> some View {
        modifier(ScaledToFitWidthModifier(maxWidth: maxWidth, enabled: enabled))
    }
}

private struct ScaledToFitWidthModifier: ViewModifier {
    let maxWidth: CGFloat
    let enabled: Bool

    @State private var naturalWidth: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: true, vertical: false)
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: NaturalWidthPreferenceKey.self, value: proxy.size.width)
                }
            }
            .onPreferenceChange(NaturalWidthPreferenceKey.self) { naturalWidth = $0 }
            .scaleEffect(scaleAmount, anchor: .center)
            .frame(maxWidth: maxWidth)
    }

    private var scaleAmount: CGFloat {
        guard enabled, naturalWidth > 0, maxWidth > 0, naturalWidth > maxWidth else {
            return 1
        }
        return maxWidth / naturalWidth
    }
}
