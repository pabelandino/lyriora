//
//  SlideAnimationProfile.swift
//  Lyriora
//

import Foundation

enum TextAnimationTarget: Codable, Equatable, Hashable, Sendable {
    case all
    case paragraph(Int)
    case line(Int)
    case word(line: Int, word: Int)

    var label: String {
        switch self {
        case .all:
            "All text"
        case .paragraph(let index):
            "Paragraph \(index + 1)"
        case .line(let index):
            "Line \(index + 1)"
        case .word(let line, let word):
            "Word \(word + 1) · Line \(line + 1)"
        }
    }

    func specificityRank(comparedTo other: TextAnimationTarget) -> Int {
        rank(for: self) - rank(for: other)
    }

    private func rank(for target: TextAnimationTarget) -> Int {
        switch target {
        case .all: 0
        case .paragraph: 1
        case .line: 2
        case .word: 3
        }
    }
}

struct TextAnimationAssignment: Codable, Equatable, Identifiable, Sendable {
    let id: UUID
    var target: TextAnimationTarget
    var kind: TextAnimationKind
    var intensity: Double
    var speed: Double

    init(
        id: UUID = UUID(),
        target: TextAnimationTarget,
        kind: TextAnimationKind,
        intensity: Double = 1,
        speed: Double = 1
    ) {
        self.id = id
        self.target = target
        self.kind = kind
        self.intensity = min(max(intensity, 0.2), 2)
        self.speed = min(max(speed, 0.25), 3)
    }
}

enum AnimationApplyScope: String, CaseIterable, Identifiable, Sendable {
    case currentSlide
    case allSlides

    var id: String { rawValue }

    var label: String {
        switch self {
        case .currentSlide: "This slide"
        case .allSlides: "All slides"
        }
    }

    /// Picks the initial Text Style editor scope from persisted slide overrides.
    static func preferredEditorState(
        slides: [LyricSlide]
    ) -> (scope: AnimationApplyScope, slideIndex: Int) {
        let overrideIndices = slides.enumerated().compactMap { index, slide -> Int? in
            guard let profile = slide.animationProfile, profile.hasAnimations else { return nil }
            return index
        }

        if overrideIndices.count == 1, let onlyIndex = overrideIndices.first {
            return (.currentSlide, onlyIndex)
        }

        if let firstOverrideIndex = overrideIndices.first {
            return (.currentSlide, firstOverrideIndex)
        }

        return (.allSlides, 0)
    }
}

struct SlideAnimationProfile: Codable, Equatable, Sendable {
    /// Default enter/exit transition for the whole slide.
    var transitionKind: TextAnimationKind
    var transitionIntensity: Double
    var transitionSpeed: Double
    /// When true, words reveal one at a time in sequence.
    var transitionWordStagger: Bool

    /// Scoped enter/exit transitions (paragraph, line, or word).
    var transitionAssignments: [TextAnimationAssignment]

    /// Default persistent pro effect for the whole slide.
    var effectFallback: TextAnimationKind
    var effectIntensity: Double
    var effectSpeed: Double

    /// Scoped persistent pro effects.
    var effectAssignments: [TextAnimationAssignment]

    init(
        transitionKind: TextAnimationKind = .none,
        transitionIntensity: Double = 1,
        transitionSpeed: Double = 1,
        transitionWordStagger: Bool = false,
        transitionAssignments: [TextAnimationAssignment] = [],
        effectFallback: TextAnimationKind = .none,
        effectIntensity: Double = 1,
        effectSpeed: Double = 1,
        effectAssignments: [TextAnimationAssignment] = []
    ) {
        self.transitionKind = transitionKind
        self.transitionIntensity = min(max(transitionIntensity, 0.2), 2)
        self.transitionSpeed = min(max(transitionSpeed, 0.25), 3)
        self.transitionWordStagger = transitionWordStagger
        self.transitionAssignments = transitionAssignments
        self.effectFallback = effectFallback
        self.effectIntensity = min(max(effectIntensity, 0.2), 2)
        self.effectSpeed = min(max(effectSpeed, 0.25), 3)
        self.effectAssignments = effectAssignments
    }

    private enum CodingKeys: String, CodingKey {
        case transitionKind
        case transitionIntensity
        case transitionSpeed
        case transitionWordStagger
        case transitionAssignments
        case effectFallback
        case effectIntensity
        case effectSpeed
        case effectAssignments
        case fallbackAnimation
        case assignments
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        transitionKind = try container.decodeIfPresent(TextAnimationKind.self, forKey: .transitionKind) ?? .none
        transitionIntensity = try container.decodeIfPresent(Double.self, forKey: .transitionIntensity) ?? 1
        transitionSpeed = try container.decodeIfPresent(Double.self, forKey: .transitionSpeed) ?? 1
        transitionWordStagger = try container.decodeIfPresent(Bool.self, forKey: .transitionWordStagger) ?? false
        transitionAssignments = try container.decodeIfPresent(
            [TextAnimationAssignment].self,
            forKey: .transitionAssignments
        ) ?? []
        effectFallback = try container.decodeIfPresent(TextAnimationKind.self, forKey: .effectFallback) ?? .none
        effectIntensity = try container.decodeIfPresent(Double.self, forKey: .effectIntensity) ?? 1
        effectSpeed = try container.decodeIfPresent(Double.self, forKey: .effectSpeed) ?? 1
        effectAssignments = try container.decodeIfPresent([TextAnimationAssignment].self, forKey: .effectAssignments)
            ?? container.decodeIfPresent([TextAnimationAssignment].self, forKey: .assignments)
            ?? []

        guard transitionKind == .none,
              transitionAssignments.isEmpty,
              effectFallback == .none,
              effectAssignments.isEmpty else { return }

        let legacyFallback = try container.decodeIfPresent(TextAnimationKind.self, forKey: .fallbackAnimation) ?? .none
        let legacyAssignments = try container.decodeIfPresent([TextAnimationAssignment].self, forKey: .assignments) ?? []

        Self.applyLegacyMigration(
            fallback: legacyFallback,
            assignments: legacyAssignments,
            to: &transitionKind,
            transitionIntensity: &transitionIntensity,
            transitionSpeed: &transitionSpeed,
            transitionAssignments: &transitionAssignments,
            effectFallback: &effectFallback,
            effectIntensity: &effectIntensity,
            effectSpeed: &effectSpeed,
            effectAssignments: &effectAssignments
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(transitionKind, forKey: .transitionKind)
        try container.encode(transitionIntensity, forKey: .transitionIntensity)
        try container.encode(transitionSpeed, forKey: .transitionSpeed)
        try container.encode(transitionWordStagger, forKey: .transitionWordStagger)
        try container.encode(transitionAssignments, forKey: .transitionAssignments)
        try container.encode(effectFallback, forKey: .effectFallback)
        try container.encode(effectIntensity, forKey: .effectIntensity)
        try container.encode(effectSpeed, forKey: .effectSpeed)
        try container.encode(effectAssignments, forKey: .effectAssignments)
    }

    var hasTransition: Bool {
        transitionKind != .none
            || transitionAssignments.contains { $0.kind != .none && !$0.kind.isProEffect }
    }

    var hasPersistentEffects: Bool {
        effectFallback != .none || effectAssignments.contains { $0.kind != .none }
    }

    /// Pro effects that require a continuous animation timeline.
    var hasProPersistentEffects: Bool {
        (effectFallback.isProEffect && effectFallback != .none)
            || effectAssignments.contains { $0.kind.isProEffect && $0.kind != .none }
    }

    var hasAnimations: Bool {
        hasTransition || hasPersistentEffects
    }

    mutating func resetTransitions() {
        transitionKind = .none
        transitionIntensity = 1
        transitionSpeed = 1
        transitionWordStagger = false
        transitionAssignments.removeAll()
    }

    mutating func resetEffects() {
        effectFallback = .none
        effectIntensity = 1
        effectSpeed = 1
        effectAssignments.removeAll()
    }

    mutating func resetAllAnimations() {
        resetTransitions()
        resetEffects()
    }

    /// Best target to select in the editor when restoring saved scoped transitions.
    var preferredTransitionSelectionTarget: TextAnimationTarget? {
        let scoped = Self.preferredSelectionTarget(
            from: transitionAssignments.filter { $0.kind != .none && !$0.kind.isProEffect }
        )
        if let scoped { return scoped }
        if transitionKind != .none { return .all }
        return nil
    }

    /// Best target to select in the editor when restoring saved scoped pro effects.
    var preferredEffectSelectionTarget: TextAnimationTarget? {
        let scoped = Self.preferredSelectionTarget(
            from: effectAssignments.filter { $0.kind != .none }
        )
        if let scoped { return scoped }
        if effectFallback != .none { return .all }
        return nil
    }

    func hasTransitionAssignment(for target: TextAnimationTarget) -> Bool {
        switch target {
        case .all:
            transitionKind != .none
        default:
            transitionAssignments.contains { $0.target == target && $0.kind != .none && !$0.kind.isProEffect }
        }
    }

    func hasEffectAssignment(for target: TextAnimationTarget) -> Bool {
        switch target {
        case .all:
            effectFallback != .none
        default:
            effectAssignments.contains { $0.target == target && $0.kind != .none }
        }
    }

    private static func preferredSelectionTarget(
        from assignments: [TextAnimationAssignment]
    ) -> TextAnimationTarget? {
        guard !assignments.isEmpty else { return nil }
        if assignments.count == 1 {
            return assignments[0].target
        }
        return assignments
            .sorted { sortOrder(for: $0.target) < sortOrder(for: $1.target) }
            .first?
            .target
    }

    private static func sortOrder(for target: TextAnimationTarget) -> (Int, Int, Int) {
        switch target {
        case .all: (0, 0, 0)
        case .paragraph(let index): (1, index, 0)
        case .line(let index): (2, index, 0)
        case .word(let line, let word): (3, line, word)
        }
    }

    func resolvedTransitionAnimation(
        lineIndex: Int,
        wordIndex: Int,
        paragraphIndex: Int,
        parsed: ParsedSlideText
    ) -> TextAnimationAssignment? {
        let candidates = transitionAssignments.filter { assignment in
            guard assignment.kind != .none, !assignment.kind.isProEffect else { return false }
            switch assignment.target {
            case .all:
                return true
            case .paragraph(let index):
                return parsed.paragraphIndex(forLine: lineIndex) == index
            case .line(let index):
                return index == lineIndex
            case .word(let line, let word):
                return line == lineIndex && word == wordIndex
            }
        }

        if let match = candidates.max(by: { lhs, rhs in
            lhs.target.specificityRank(comparedTo: rhs.target) < 0
        }) {
            return match
        }

        guard transitionKind != .none, !transitionKind.isProEffect else { return nil }

        return TextAnimationAssignment(
            target: .all,
            kind: transitionKind,
            intensity: transitionIntensity,
            speed: transitionSpeed
        )
    }

    func resolvedTransitionKind(
        lineIndex: Int,
        wordIndex: Int,
        paragraphIndex: Int,
        parsed: ParsedSlideText
    ) -> TextAnimationKind {
        resolvedTransitionAnimation(
            lineIndex: lineIndex,
            wordIndex: wordIndex,
            paragraphIndex: paragraphIndex,
            parsed: parsed
        )?.kind ?? .none
    }

    func previewTransitionSpeed(selectedTarget: TextAnimationTarget?) -> Double {
        if let selectedTarget,
           let assignment = transitionAssignments.first(where: { $0.target == selectedTarget }) {
            return assignment.speed
        }
        return transitionSpeed
    }

    func transitionSegmentIndex(
        lineIndex: Int,
        wordIndex: Int,
        paragraphIndex: Int,
        parsed: ParsedSlideText
    ) -> Int {
        guard let assignment = resolvedTransitionAnimation(
            lineIndex: lineIndex,
            wordIndex: wordIndex,
            paragraphIndex: paragraphIndex,
            parsed: parsed
        ) else {
            return parsed.globalWordIndex(lineIndex: lineIndex, wordIndex: wordIndex)
        }

        switch assignment.target {
        case .all:
            return parsed.globalWordIndex(lineIndex: lineIndex, wordIndex: wordIndex)
        case .paragraph:
            return parsed.paragraphWordIndex(
                lineIndex: lineIndex,
                wordIndex: wordIndex,
                paragraphIndex: paragraphIndex
            )
        case .line:
            return wordIndex
        case .word:
            return 0
        }
    }

    func transitionWordCount(
        lineIndex: Int,
        wordIndex: Int,
        paragraphIndex: Int,
        parsed: ParsedSlideText
    ) -> Int {
        guard let assignment = resolvedTransitionAnimation(
            lineIndex: lineIndex,
            wordIndex: wordIndex,
            paragraphIndex: paragraphIndex,
            parsed: parsed
        ) else {
            return max(1, parsed.totalWordCount)
        }

        switch assignment.target {
        case .all:
            return max(1, parsed.totalWordCount)
        case .paragraph:
            return max(1, parsed.wordCount(inParagraph: paragraphIndex))
        case .line(let index):
            return max(1, parsed.lines[index].count)
        case .word:
            return 1
        }
    }

    func resolvedEffectAnimation(
        lineIndex: Int,
        wordIndex: Int,
        paragraphIndex: Int,
        parsed: ParsedSlideText
    ) -> TextAnimationAssignment? {
        let candidates = effectAssignments.filter { assignment in
            guard assignment.kind != .none else { return false }
            switch assignment.target {
            case .all:
                return true
            case .paragraph(let index):
                return parsed.paragraphIndex(forLine: lineIndex) == index
            case .line(let index):
                return index == lineIndex
            case .word(let line, let word):
                return line == lineIndex && word == wordIndex
            }
        }

        if let match = candidates.max(by: { lhs, rhs in
            lhs.target.specificityRank(comparedTo: rhs.target) < 0
        }) {
            return match
        }

        guard effectFallback != .none else { return nil }

        return TextAnimationAssignment(
            target: .all,
            kind: effectFallback,
            intensity: effectIntensity,
            speed: effectSpeed
        )
    }

    func resolvedEffectKind(
        lineIndex: Int,
        wordIndex: Int,
        paragraphIndex: Int,
        parsed: ParsedSlideText
    ) -> TextAnimationKind {
        resolvedEffectAnimation(
            lineIndex: lineIndex,
            wordIndex: wordIndex,
            paragraphIndex: paragraphIndex,
            parsed: parsed
        )?.kind ?? .none
    }

    func effectSegmentIndex(
        lineIndex: Int,
        wordIndex: Int,
        paragraphIndex: Int,
        parsed: ParsedSlideText
    ) -> Int {
        if let assignment = resolvedEffectAnimation(
            lineIndex: lineIndex,
            wordIndex: wordIndex,
            paragraphIndex: paragraphIndex,
            parsed: parsed
        ) {
            return assignment.groupSegmentIndex(
                lineIndex: lineIndex,
                wordIndex: wordIndex,
                paragraphIndex: paragraphIndex
            )
        }

        return lineIndex * 100 + wordIndex
    }

    private static func applyLegacyMigration(
        fallback: TextAnimationKind,
        assignments: [TextAnimationAssignment],
        to transitionKind: inout TextAnimationKind,
        transitionIntensity: inout Double,
        transitionSpeed: inout Double,
        transitionAssignments: inout [TextAnimationAssignment],
        effectFallback: inout TextAnimationKind,
        effectIntensity: inout Double,
        effectSpeed: inout Double,
        effectAssignments: inout [TextAnimationAssignment]
    ) {
        if fallback.isProEffect {
            effectFallback = fallback
        } else if fallback != .none {
            transitionKind = fallback
        }

        for assignment in assignments where assignment.kind != .none {
            if assignment.kind.isProEffect {
                effectAssignments.append(assignment)
            } else if assignment.target == .all, transitionKind == .none {
                transitionKind = assignment.kind
                transitionIntensity = assignment.intensity
                transitionSpeed = assignment.speed
            } else if !assignment.kind.isProEffect {
                transitionAssignments.append(assignment)
            }
        }
    }
}

extension TextAnimationAssignment {
    var appliesToGroup: Bool {
        switch target {
        case .all, .paragraph, .line:
            true
        case .word:
            false
        }
    }

    func groupSegmentIndex(
        lineIndex: Int,
        wordIndex: Int,
        paragraphIndex: Int
    ) -> Int {
        switch target {
        case .all:
            0
        case .paragraph(let index):
            10_000 + index
        case .line(let index):
            1_000 + index
        case .word:
            lineIndex * 100 + wordIndex
        }
    }
}

enum SlideTransitionTiming {
    static let enterDuration: TimeInterval = 0.42
    static let exitDuration: TimeInterval = 0.28

    static func enterDuration(wordCount: Int, speed: Double, wordStagger: Bool) -> TimeInterval {
        let clampedSpeed = min(max(speed, 0.25), 3)
        let words = max(1, wordCount)
        if wordStagger && words > 1 {
            let perWord = 0.55 / clampedSpeed
            return min(perWord * Double(words), 14)
        }
        return 0.6 / clampedSpeed
    }

    static func exitDuration(wordCount: Int, speed: Double, wordStagger: Bool) -> TimeInterval {
        enterDuration(wordCount: wordCount, speed: speed, wordStagger: wordStagger) * 0.65
    }

    static func formattedEnterDuration(wordCount: Int, speed: Double, wordStagger: Bool) -> String {
        let seconds = enterDuration(wordCount: wordCount, speed: speed, wordStagger: wordStagger)
        if seconds >= 1 {
            return String(format: "%.1fs", seconds)
        }
        return String(format: "%.2fs", seconds)
    }
}

struct SlideTransitionState: Equatable {
    var enterProgress: Double = 1
    var isExiting: Bool = false

    var showsPersistentEffects: Bool {
        !isExiting
    }
}
