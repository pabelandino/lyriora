//
//  TextAnimationEffects.swift
//  Lyriora
//

import SwiftUI

struct TextAnimationTransform: Equatable {
    var opacity: Double = 1
    var offset: CGSize = .zero
    var scale: CGFloat = 1
    var rotation: Angle = .zero
    var blur: CGFloat = 0
}

enum TextAnimationEffects {
    static func transitionTransform(
        kind: TextAnimationKind,
        progress: Double,
        isExiting: Bool,
        segmentIndex: Int,
        totalWords: Int = 1,
        intensity: Double,
        speed: Double,
        applyTimingStagger: Bool = false
    ) -> TextAnimationTransform {
        guard kind != .none, !kind.isProEffect else { return TextAnimationTransform() }

        let clampedIntensity = min(max(intensity, 0.2), 2)
        let clampedSpeed = min(max(speed, 0.25), 3)
        let effectiveIndex = isExiting ? max(0, totalWords - 1 - segmentIndex) : segmentIndex
        let stagger = applyTimingStagger && totalWords > 1
            ? transitionStagger(
                segmentIndex: effectiveIndex,
                totalWords: totalWords,
                speed: clampedSpeed
            )
            : 0
        let direction: Double = isExiting ? -1 : 1

        let eased = min(1, transitionProgress(progress: progress, stagger: stagger, speed: clampedSpeed) * clampedIntensity)
        let amount = eased
        let segmentPhase = Double(segmentIndex)

        switch kind {
        case .fadeIn:
            return TextAnimationTransform(opacity: max(0, min(1, amount)))

        case .staggerFade:
            if totalWords > 1 {
                let spatial = 0.45 + 0.55 * (0.5 + 0.5 * sin(segmentPhase * 0.85))
                return TextAnimationTransform(opacity: max(0, min(1, amount * spatial)))
            }
            return TextAnimationTransform(opacity: max(0, min(1, amount)))

        case .slideUp:
            let travel = 28.0 * direction
            return TextAnimationTransform(
                opacity: amount,
                offset: CGSize(width: 0, height: travel * (1 - amount))
            )

        case .slideDown:
            let travel = -28.0 * direction
            return TextAnimationTransform(
                opacity: amount,
                offset: CGSize(width: 0, height: travel * (1 - amount))
            )

        case .slideLeft:
            let travel = 34.0 * direction
            return TextAnimationTransform(
                opacity: amount,
                offset: CGSize(width: travel * (1 - amount), height: 0)
            )

        case .slideRight:
            let travel = -34.0 * direction
            return TextAnimationTransform(
                opacity: amount,
                offset: CGSize(width: travel * (1 - amount), height: 0)
            )

        case .popIn, .zoomPulse:
            let scale = 0.72 + 0.28 * amount
            return TextAnimationTransform(opacity: amount, scale: scale)

        case .elastic:
            let overshoot = 1 + 0.12 * clampedIntensity * sin(amount * .pi)
            return TextAnimationTransform(
                opacity: amount,
                offset: CGSize(width: 0, height: -10 * (1 - amount) * direction),
                scale: overshoot
            )

        case .bounce:
            let baseY = -26 * (1 - amount) * direction
            let bounce = amount > 0.55
                ? sin((amount - 0.55) / 0.45 * .pi) * -10 * clampedIntensity * direction
                : 0
            return TextAnimationTransform(
                opacity: amount,
                offset: CGSize(width: 0, height: baseY + bounce)
            )

        case .flipHorizontal:
            return TextAnimationTransform(
                opacity: amount,
                scale: 0.8 + 0.2 * amount,
                rotation: Angle(degrees: (1 - amount) * 24 * direction)
            )

        case .flipVertical:
            return TextAnimationTransform(
                opacity: amount,
                scale: 0.8 + 0.2 * amount,
                rotation: Angle(degrees: (1 - amount) * -24 * direction)
            )

        case .typewriter:
            return TextAnimationTransform(opacity: amount >= 0.02 ? 1 : 0)

        case .pulse:
            let scale = 0.82 + 0.18 * amount
            return TextAnimationTransform(opacity: amount, scale: scale)

        case .heartbeat:
            let beat = amount > 0.5 ? 1 + 0.14 * clampedIntensity * sin((amount - 0.5) / 0.5 * .pi * 2) : amount
            let scale = 0.78 + 0.22 * beat
            return TextAnimationTransform(opacity: amount, scale: scale)

        case .glowPulse:
            return TextAnimationTransform(
                opacity: 0.35 + 0.65 * amount,
                scale: 0.94 + 0.06 * amount,
                blur: CGFloat(4 * (1 - amount) * clampedIntensity)
            )

        case .spin:
            return TextAnimationTransform(
                opacity: amount,
                rotation: Angle(degrees: (1 - amount) * 120 * direction)
            )

        case .blink:
            let flicker: Double = {
                guard amount < 0.85 else { return 1 }
                if amount < 0.08 { return 0 }
                let phase = amount * 14
                return floor(phase).truncatingRemainder(dividingBy: 2) == 0 ? 1 : 0.12
            }()
            return TextAnimationTransform(opacity: flicker * amount)

        case .blinkSemiRotate:
            let flicker: Double = {
                guard amount < 0.85 else { return 1 }
                if amount < 0.08 { return 0 }
                let phase = amount * 14
                return floor(phase).truncatingRemainder(dividingBy: 2) == 0 ? 1 : 0.12
            }()
            let tilt = sin(amount * .pi * 3 + segmentPhase * 0.4) * 22 * (1 - amount) * clampedIntensity
            return TextAnimationTransform(
                opacity: flicker * amount,
                rotation: Angle(degrees: tilt)
            )

        case .wave:
            let wavePhase = segmentPhase * 0.75 + (1 - amount) * .pi
            let y = sin(wavePhase) * 24 * clampedIntensity * (1 - amount) * direction
            return TextAnimationTransform(
                opacity: amount,
                offset: CGSize(width: 0, height: y)
            )

        case .waveRotate:
            let wavePhase = segmentPhase * 0.75 + (1 - amount) * .pi
            let y = sin(wavePhase) * 20 * clampedIntensity * (1 - amount) * direction
            let tilt = sin(wavePhase + 0.6) * 16 * clampedIntensity * (1 - amount)
            return TextAnimationTransform(
                opacity: amount,
                offset: CGSize(width: 0, height: y),
                rotation: Angle(degrees: tilt)
            )

        case .shake:
            let x = sin(amount * .pi * 7 + segmentPhase) * 14 * (1 - amount) * clampedIntensity
            return TextAnimationTransform(
                opacity: amount,
                offset: CGSize(width: x, height: 0)
            )

        case .wiggle:
            let tilt = sin(amount * .pi * 6 + segmentPhase * 0.5) * 18 * (1 - amount) * clampedIntensity
            return TextAnimationTransform(
                opacity: amount,
                rotation: Angle(degrees: tilt)
            )

        case .float:
            let drift = sin(segmentPhase * 0.35) * 4 * (1 - amount)
            return TextAnimationTransform(
                opacity: amount,
                offset: CGSize(width: drift, height: 18 * (1 - amount) * direction),
                scale: 0.94 + 0.06 * amount
            )

        case .jitter:
            let x = sin(amount * 37 + segmentPhase * 1.7) * 10 * (1 - amount) * clampedIntensity
            let y = cos(amount * 29 + segmentPhase * 1.3) * 8 * (1 - amount) * clampedIntensity
            return TextAnimationTransform(
                opacity: amount,
                offset: CGSize(width: x, height: y)
            )

        case .neonGlow, .gradientNeon, .echoTrail, .vibrateEcho, .chromaticShift,
             .outlineStack, .kineticSlam, .glitchSlice, .hudGlitch, .none:
            return TextAnimationTransform()
        }
    }

    /// Sequential word-by-word reveal: returns -1 when the word must stay hidden,
    /// 0...1 while animating, and 1 when fully visible.
    static func sequentialWordLocalProgress(
        globalProgress: Double,
        wordIndex: Int,
        totalWords: Int,
        isExiting: Bool,
        speed: Double
    ) -> Double {
        guard totalWords > 1 else { return max(0, min(1, globalProgress)) }

        let slotSize = 1.0 / Double(totalWords)
        let clampedSpeed = min(max(speed, 0.25), 3)

        if isExiting {
            let exitOrder = totalWords - 1 - wordIndex
            let slotStart = Double(exitOrder) * slotSize
            let slotEnd = slotStart + slotSize

            if globalProgress >= slotEnd { return 1 }
            if globalProgress <= slotStart { return -1 }

            let local = (globalProgress - slotStart) / slotSize
            return shapeLocalProgress(local, speed: clampedSpeed)
        }

        let slotStart = Double(wordIndex) * slotSize
        let slotEnd = slotStart + slotSize

        if globalProgress < slotStart { return -1 }
        if globalProgress >= slotEnd { return 1 }

        let local = (globalProgress - slotStart) / slotSize
        return max(0, min(1, local))
    }

    private static func shapeLocalProgress(_ local: Double, speed: Double) -> Double {
        let clamped = max(0, min(1, local))
        return 1 - pow(1 - clamped, max(1.1, speed * 1.4))
    }

    private static func transitionStagger(segmentIndex: Int, totalWords: Int, speed: Double) -> Double {
        guard totalWords > 1 else { return 0 }
        let spread = min(0.96, 0.75 + (0.18 / speed))
        let step = spread / Double(totalWords - 1)
        return min(Double(segmentIndex) * step, spread)
    }

    private static func transitionProgress(progress: Double, stagger: Double, speed: Double) -> Double {
        let adjusted = max(0, min(1, (progress - stagger) / max(0.05, 1 - stagger)))
        // Wall-clock speed is driven by SlideTransitionTextContainer duration, not curve steepness.
        return adjusted
    }

    static func transform(
        kind: TextAnimationKind,
        time: TimeInterval,
        segmentIndex: Int,
        intensity: Double,
        speed: Double
    ) -> TextAnimationTransform {
        guard kind != .none else { return TextAnimationTransform() }

        let clampedIntensity = min(max(intensity, 0.2), 2)
        let clampedSpeed = min(max(speed, 0.25), 3)
        let phase = time * clampedSpeed
        let stagger = Double(segmentIndex) * 0.12

        switch kind {
        case .none:
            return TextAnimationTransform()

        case .fadeIn:
            let cycle = sin((phase + stagger) * .pi)
            return TextAnimationTransform(opacity: 0.35 + 0.65 * (0.5 + 0.5 * cycle))

        case .blink:
            let visible = sin((phase + stagger) * .pi * 2) > 0
            return TextAnimationTransform(opacity: visible ? 1 : 0.15)

        case .blinkSemiRotate:
            let visible = sin((phase + stagger) * .pi * 2) > 0
            let tilt = Angle(degrees: sin((phase + stagger) * .pi) * 18 * clampedIntensity)
            return TextAnimationTransform(
                opacity: visible ? 1 : 0.2,
                rotation: tilt
            )

        case .pulse:
            let scale = 1 + 0.12 * clampedIntensity * sin((phase + stagger) * .pi * 2)
            return TextAnimationTransform(scale: scale)

        case .bounce:
            let y = abs(sin((phase + stagger) * .pi * 2)) * -18 * clampedIntensity
            return TextAnimationTransform(offset: CGSize(width: 0, height: y))

        case .wave:
            let y = sin((phase * 2) + stagger * 4) * 10 * clampedIntensity
            return TextAnimationTransform(offset: CGSize(width: 0, height: y))

        case .waveRotate:
            let y = sin((phase * 2) + stagger * 4) * 8 * clampedIntensity
            let tilt = Angle(degrees: sin((phase * 2) + stagger * 3) * 14 * clampedIntensity)
            return TextAnimationTransform(
                offset: CGSize(width: 0, height: y),
                rotation: tilt
            )

        case .shake:
            let x = sin((phase + stagger) * .pi * 8) * 6 * clampedIntensity
            return TextAnimationTransform(offset: CGSize(width: x, height: 0))

        case .slideUp:
            let y = sin((phase + stagger) * .pi * 2) * -14 * clampedIntensity
            return TextAnimationTransform(offset: CGSize(width: 0, height: y))

        case .slideDown:
            let y = sin((phase + stagger) * .pi * 2) * 14 * clampedIntensity
            return TextAnimationTransform(offset: CGSize(width: 0, height: y))

        case .slideLeft:
            let x = sin((phase + stagger) * .pi * 2) * -16 * clampedIntensity
            return TextAnimationTransform(offset: CGSize(width: x, height: 0))

        case .slideRight:
            let x = sin((phase + stagger) * .pi * 2) * 16 * clampedIntensity
            return TextAnimationTransform(offset: CGSize(width: x, height: 0))

        case .wiggle:
            let tilt = Angle(degrees: sin((phase + stagger) * .pi * 6) * 12 * clampedIntensity)
            return TextAnimationTransform(rotation: tilt)

        case .popIn:
            let scale = 0.85 + 0.15 * (0.5 + 0.5 * sin((phase + stagger) * .pi * 2))
            return TextAnimationTransform(scale: scale)

        case .elastic:
            let scale = 1 + 0.18 * clampedIntensity * sin((phase + stagger) * .pi * 2)
            let y = sin((phase + stagger) * .pi * 4) * -8 * clampedIntensity
            return TextAnimationTransform(offset: CGSize(width: 0, height: y), scale: scale)

        case .float:
            let y = sin((phase + stagger) * .pi) * -12 * clampedIntensity
            return TextAnimationTransform(offset: CGSize(width: 0, height: y), scale: 1.02)

        case .heartbeat:
            let beat = abs(sin((phase + stagger) * .pi * 2))
            let scale = 1 + 0.2 * clampedIntensity * beat
            return TextAnimationTransform(scale: scale)

        case .jitter:
            let x = sin((phase + stagger) * 31) * 4 * clampedIntensity
            let y = cos((phase + stagger) * 27) * 4 * clampedIntensity
            return TextAnimationTransform(offset: CGSize(width: x, height: y))

        case .typewriter:
            let gate = sin((phase * 1.5) + stagger) > -0.2
            return TextAnimationTransform(opacity: gate ? 1 : 0.05)

        case .staggerFade:
            let wave = sin((phase * 1.4) - stagger * 2)
            return TextAnimationTransform(opacity: 0.25 + 0.75 * (0.5 + 0.5 * wave))

        case .flipHorizontal:
            let degrees = sin((phase + stagger) * .pi * 2) * 35 * clampedIntensity
            return TextAnimationTransform(
                scale: 1 - abs(sin((phase + stagger) * .pi)) * 0.15,
                rotation: Angle(degrees: degrees)
            )

        case .flipVertical:
            let degrees = sin((phase + stagger) * .pi * 2) * 35 * clampedIntensity
            return TextAnimationTransform(
                scale: 1 - abs(cos((phase + stagger) * .pi)) * 0.15,
                rotation: Angle(degrees: degrees)
            )

        case .glowPulse:
            let pulse = 0.5 + 0.5 * sin((phase + stagger) * .pi * 2)
            return TextAnimationTransform(
                opacity: 0.65 + 0.35 * pulse,
                scale: 1 + 0.06 * clampedIntensity * pulse,
                blur: CGFloat(2 * (1 - pulse) * clampedIntensity)
            )

        case .spin:
            return TextAnimationTransform(
                rotation: Angle(degrees: (phase + stagger) * 120 * clampedIntensity)
            )

        case .zoomPulse:
            let scale = 0.92 + 0.12 * (0.5 + 0.5 * sin((phase + stagger) * .pi * 2)) * clampedIntensity
            return TextAnimationTransform(scale: scale)

        case .neonGlow, .gradientNeon, .echoTrail, .vibrateEcho, .chromaticShift, .outlineStack, .kineticSlam:
            return TextAnimationTransform()

        case .glitchSlice, .hudGlitch:
            let x = sin((phase + stagger) * .pi * 12) * 5 * clampedIntensity
            let y = cos((phase + stagger) * .pi * 9) * 2 * clampedIntensity
            return TextAnimationTransform(offset: CGSize(width: x, height: y))
        }
    }
}

struct AnimatedTextSegmentModifier: ViewModifier {
    let transform: TextAnimationTransform

    func body(content: Content) -> some View {
        content
            .opacity(transform.opacity)
            .offset(transform.offset)
            .scaleEffect(transform.scale)
            .rotationEffect(transform.rotation)
            .blur(radius: transform.blur)
    }
}

struct SequentialWordTransitionModifier: AnimatableModifier {
    let kind: TextAnimationKind
    var globalProgress: Double
    let wordIndex: Int
    let totalWords: Int
    let isExiting: Bool
    let intensity: Double
    let speed: Double

    var animatableData: Double {
        get { globalProgress }
        set { globalProgress = newValue }
    }

    private var layoutSegmentIndex: Int {
        kind.usesSpatialTransitionLayout ? wordIndex : 0
    }

    private var layoutTotalWords: Int {
        kind.usesSpatialTransitionLayout ? totalWords : 1
    }

    func body(content: Content) -> some View {
        let localProgress = TextAnimationEffects.sequentialWordLocalProgress(
            globalProgress: globalProgress,
            wordIndex: wordIndex,
            totalWords: totalWords,
            isExiting: isExiting,
            speed: speed
        )

        if localProgress < 0 {
            content
                .fixedSize(horizontal: true, vertical: false)
                .opacity(0)
                .frame(maxWidth: 0)
                .clipped()
                .allowsHitTesting(false)
        } else {
            let transform = TextAnimationEffects.transitionTransform(
                kind: kind,
                progress: localProgress,
                isExiting: isExiting,
                segmentIndex: layoutSegmentIndex,
                totalWords: layoutTotalWords,
                intensity: intensity,
                speed: speed,
                applyTimingStagger: false
            )
            content
                .opacity(transform.opacity)
                .offset(transform.offset)
                .scaleEffect(transform.scale)
                .rotationEffect(transform.rotation)
                .blur(radius: transform.blur)
        }
    }
}

struct SlideTransitionModifier: AnimatableModifier {
    let kind: TextAnimationKind
    var progress: Double
    let isExiting: Bool
    let segmentIndex: Int
    let totalWords: Int
    let intensity: Double
    let speed: Double

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        let transform = TextAnimationEffects.transitionTransform(
            kind: kind,
            progress: progress,
            isExiting: isExiting,
            segmentIndex: segmentIndex,
            totalWords: totalWords,
            intensity: intensity,
            speed: speed,
            applyTimingStagger: false
        )

        content
            .opacity(transform.opacity)
            .offset(transform.offset)
            .scaleEffect(transform.scale)
            .rotationEffect(transform.rotation)
            .blur(radius: transform.blur)
    }
}

extension View {
    func animatedTextSegment(_ transform: TextAnimationTransform) -> some View {
        modifier(AnimatedTextSegmentModifier(transform: transform))
    }

    func slideTransitionEffect(
        kind: TextAnimationKind,
        progress: Double,
        isExiting: Bool,
        segmentIndex: Int = 0,
        totalWords: Int = 1,
        intensity: Double,
        speed: Double
    ) -> some View {
        modifier(
            SlideTransitionModifier(
                kind: kind,
                progress: progress,
                isExiting: isExiting,
                segmentIndex: segmentIndex,
                totalWords: totalWords,
                intensity: intensity,
                speed: speed
            )
        )
    }

    func sequentialWordTransition(
        kind: TextAnimationKind,
        globalProgress: Double,
        wordIndex: Int,
        totalWords: Int,
        isExiting: Bool,
        intensity: Double,
        speed: Double
    ) -> some View {
        modifier(
            SequentialWordTransitionModifier(
                kind: kind,
                globalProgress: globalProgress,
                wordIndex: wordIndex,
                totalWords: totalWords,
                isExiting: isExiting,
                intensity: intensity,
                speed: speed
            )
        )
    }
}
