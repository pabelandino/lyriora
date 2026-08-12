//
//  TextAnimationEditorSection.swift
//  Lyriora
//

import SwiftUI

struct TextAnimationEditorSection: View {
    @Binding var animationProfile: SlideAnimationProfile
    @Binding var selectedTransitionTarget: TextAnimationTarget?
    @Binding var selectedEffectTarget: TextAnimationTarget?
    @Binding var isPreviewPlaying: Bool

    let sampleText: String
    var animationApplyScope: Binding<AnimationApplyScope>? = nil
    var showsPreviewAnimations: Bool = false
    var onTransitionReplayRequested: (() -> Void)? = nil
    var onTransitionSettingsChanged: (() -> Void)? = nil

    @State private var showsResetAllConfirmation = false

    private var parsedSampleText: ParsedSlideText {
        SlideTextTokenizer.parse(sampleText)
    }

    private var previewWordCount: Int {
        max(1, parsedSampleText.totalWordCount)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let animationApplyScope {
                applyScopePicker(scope: animationApplyScope)
            }

            if animationProfile.hasAnimations {
                animationResetToolbar
            }

            transitionSection

            proEffectSection

            if showsPreviewAnimations {
                Toggle("Play animation in preview", isOn: $isPreviewPlaying)
            }
        }
        .confirmationDialog(
            "Reset all animations?",
            isPresented: $showsResetAllConfirmation,
            titleVisibility: .visible
        ) {
            Button("Reset All", role: .destructive) {
                resetAllAnimations()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Removes every transition and pro effect for the current scope.")
        }
    }

    private var animationResetToolbar: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Active animations")
                    .font(.caption.weight(.semibold))

                Text(animationStatusSummary)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer(minLength: 8)

            Menu {
                Button("Reset Transitions", role: .destructive) {
                    resetTransitions()
                }
                .disabled(!animationProfile.hasTransition)

                Button("Reset Pro Effects", role: .destructive) {
                    resetEffects()
                }
                .disabled(!animationProfile.hasPersistentEffects)

                Divider()

                Button("Reset All Animations", role: .destructive) {
                    showsResetAllConfirmation = true
                }
            } label: {
                Label("Reset", systemImage: "arrow.uturn.backward.circle")
                    .font(.caption.weight(.semibold))
            }
            .buttonStyle(.bordered)
            .tint(.red)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.primary.opacity(0.04), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.08), lineWidth: 1)
        }
    }

    private var animationStatusSummary: String {
        var parts: [String] = []

        if animationProfile.hasTransition {
            if animationProfile.transitionAssignments.isEmpty {
                parts.append("Transition: \(animationProfile.transitionKind.displayName)")
            } else {
                parts.append("\(animationProfile.transitionAssignments.count) transition override(s)")
            }
            if animationProfile.transitionWordStagger {
                parts.append("word-by-word")
            }
        }

        if animationProfile.hasPersistentEffects {
            if animationProfile.effectAssignments.isEmpty {
                parts.append("Effect: \(animationProfile.effectFallback.displayName)")
            } else {
                parts.append("\(animationProfile.effectAssignments.count) effect override(s)")
            }
        }

        return parts.isEmpty ? "Custom animation settings" : parts.joined(separator: " · ")
    }

    private func resetTransitions() {
        animationProfile.resetTransitions()
        selectedTransitionTarget = nil
        onTransitionReplayRequested?()
    }

    private func resetEffects() {
        animationProfile.resetEffects()
        selectedEffectTarget = nil
    }

    private func resetAllAnimations() {
        animationProfile.resetAllAnimations()
        selectedTransitionTarget = nil
        selectedEffectTarget = nil
        onTransitionReplayRequested?()
    }

    private func applyScopePicker(scope: Binding<AnimationApplyScope>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Apply to")
                .font(.subheadline.weight(.semibold))

            Picker("Apply to", selection: scope) {
                ForEach(AnimationApplyScope.allCases) { option in
                    Text(option.label).tag(option)
                }
            }
            .pickerStyle(.segmented)

            Text(scope.wrappedValue == .currentSlide
                ? "Style and transitions apply only to the selected slide."
                : "Style and transitions apply to every slide in this lyric.")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Transitions

    private var transitionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Transitions · enter/exit")
                        .font(.subheadline.weight(.semibold))

                    Text("Pick a scope, then choose a transition. Tap words in the preview to assign a different transition per word.")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                Spacer(minLength: 8)

                Button {
                    onTransitionReplayRequested?()
                } label: {
                    Label("Replay", systemImage: "arrow.clockwise")
                        .font(.caption.weight(.semibold))
                }
                .buttonStyle(.bordered)
                .disabled(!animationProfile.hasTransition)
            }

            transitionScopeShortcutRow

            if let selectedTransitionTarget {
                selectedTargetBanner(
                    label: "Transition target: \(scopeLabel(for: selectedTransitionTarget))",
                    showsReset: animationProfile.hasTransitionAssignment(for: selectedTransitionTarget),
                    onClear: { self.selectedTransitionTarget = nil },
                    onReset: { applyTransition(.none) }
                )
            } else {
                Text("Default: whole slide")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.primary.opacity(0.05), in: Capsule())
            }

            if !animationProfile.transitionAssignments.isEmpty {
                scopedOverridesSummary(
                    count: animationProfile.transitionAssignments.count,
                    label: "line or word transition override(s)"
                )
            }

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 108), spacing: 8)],
                spacing: 8
            ) {
                ForEach(TextAnimationKind.basicCases) { kind in
                    animationChip(
                        kind,
                        isActive: activeTransitionKind == kind,
                        apply: { applyTransition(kind) }
                    )
                }
            }
            .layoutPriority(-1)

            if selectedTransitionTarget != nil {
                transitionAssignmentControls
            } else {
                defaultTransitionControls
            }

            transitionTimingControls
        }
    }

    private var transitionScopeShortcutRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                scopeButton(
                    title: "Whole slide",
                    target: .all,
                    selection: $selectedTransitionTarget,
                    hasAssignment: animationProfile.hasTransitionAssignment(for: .all)
                )
                ForEach(scopeTargets, id: \.self) { target in
                    scopeButton(
                        title: scopeLabel(for: target),
                        target: target,
                        selection: $selectedTransitionTarget,
                        hasAssignment: animationProfile.hasTransitionAssignment(for: target)
                    )
                }
            }
        }
    }

    private var transitionTimingControls: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Word by word reveal", isOn: $animationProfile.transitionWordStagger)
                .disabled(!animationProfile.hasTransition)

            if animationProfile.hasTransition {
                Text(animationProfile.transitionWordStagger
                    ? "Words appear one at a time. Each word keeps its own transition style."
                    : "All words in the scope animate together. Wave and Stagger Fade use a smooth curve across the text.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.top, 4)
    }

    @ViewBuilder
    private var transitionAssignmentControls: some View {
        if let selectedTransitionTarget {
            if let index = animationProfile.transitionAssignments.firstIndex(where: { $0.target == selectedTransitionTarget }) {
                let binding = $animationProfile.transitionAssignments[index]

                VStack(alignment: .leading, spacing: 10) {
                    Text("Transition settings for \(scopeLabel(for: selectedTransitionTarget))")
                        .font(.subheadline.weight(.semibold))

                    LabeledContent("Intensity") {
                        Slider(value: binding.intensity, in: 0.2...2)
                    }

                    TransitionSpeedControl(
                        speed: binding.speed,
                        wordCount: previewWordCount,
                        wordStagger: animationProfile.transitionWordStagger,
                        onEditingEnded: onTransitionSettingsChanged
                    )
                }
            } else if activeTransitionKind != .none {
                Text("Transition applied to \(scopeLabel(for: selectedTransitionTarget)). Adjust defaults below or pick another effect.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Text("Pick a transition above to apply it to \(scopeLabel(for: selectedTransitionTarget)).")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var defaultTransitionControls: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Default transition")
                .font(.subheadline.weight(.semibold))

            LabeledContent("Intensity") {
                Slider(value: $animationProfile.transitionIntensity, in: 0.2...2)
            }
            .disabled(animationProfile.transitionKind == .none)

            TransitionSpeedControl(
                speed: $animationProfile.transitionSpeed,
                wordCount: previewWordCount,
                wordStagger: animationProfile.transitionWordStagger,
                isEnabled: animationProfile.transitionKind != .none,
                onEditingEnded: onTransitionSettingsChanged
            )
        }
    }

    // MARK: - Pro effects

    private var proEffectSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Pro · while visible")
                    .font(.subheadline.weight(.semibold))

                Text("Persistent effects while the slide is on screen. Use the same scope picker as transitions.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            proScopeShortcutRow

            if let selectedEffectTarget {
                selectedTargetBanner(
                    label: "Pro effect target: \(scopeLabel(for: selectedEffectTarget))",
                    showsReset: animationProfile.hasEffectAssignment(for: selectedEffectTarget),
                    onClear: { self.selectedEffectTarget = nil },
                    onReset: { applyEffect(.none) }
                )
            } else {
                Text("Default: whole slide")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.primary.opacity(0.05), in: Capsule())
            }

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 108), spacing: 8)],
                spacing: 8
            ) {
                ForEach(TextAnimationKind.proCases) { kind in
                    animationChip(
                        kind,
                        isActive: activeEffectKind == kind,
                        apply: { applyEffect(kind) }
                    )
                }
            }

            if selectedEffectTarget != nil {
                effectAssignmentControls
            } else {
                slideDefaultsControls
            }
        }
    }

    private var proScopeShortcutRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                scopeButton(
                    title: "Whole slide",
                    target: .all,
                    selection: $selectedEffectTarget,
                    hasAssignment: animationProfile.hasEffectAssignment(for: .all)
                )
                ForEach(scopeTargets, id: \.self) { target in
                    scopeButton(
                        title: scopeLabel(for: target),
                        target: target,
                        selection: $selectedEffectTarget,
                        hasAssignment: animationProfile.hasEffectAssignment(for: target)
                    )
                }
            }
        }
    }

    private var scopeTargets: [TextAnimationTarget] {
        let parsed = SlideTextTokenizer.parse(sampleText)
        var targets: [TextAnimationTarget] = parsed.paragraphLineRanges.indices.map { .paragraph($0) }
        for lineIndex in parsed.lines.indices where !parsed.lines[lineIndex].isEmpty {
            targets.append(.line(lineIndex))
        }
        return targets
    }

    private func scopeLabel(for target: TextAnimationTarget) -> String {
        switch target {
        case .all:
            "Whole slide"
        case .paragraph(let index):
            "Block \(index + 1)"
        case .line(let index):
            "Line \(index + 1)"
        case .word(let line, let word):
            "Word \(word + 1) · Line \(line + 1)"
        }
    }

    private func selectedTargetBanner(
        label: String,
        showsReset: Bool,
        onClear: @escaping () -> Void,
        onReset: @escaping () -> Void
    ) -> some View {
        HStack(spacing: 8) {
            Label(label, systemImage: "scope")
                .font(.subheadline.weight(.semibold))
                .lineLimit(2)

            Spacer(minLength: 0)

            if showsReset {
                Button("Reset scope", role: .destructive, action: onReset)
                    .font(.caption.weight(.semibold))
                    .buttonStyle(.bordered)
                    .controlSize(.small)
            }

            Button("Clear target", action: onClear)
                .font(.caption.weight(.semibold))
                .buttonStyle(.bordered)
                .controlSize(.small)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color.accentColor.opacity(0.08), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }

    private func scopedOverridesSummary(count: Int, label: String) -> some View {
        Label("\(count) custom \(label)", systemImage: "line.3.horizontal.decrease.circle")
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.orange.opacity(0.08), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    @ViewBuilder
    private func scopeButton(
        title: String,
        target: TextAnimationTarget,
        selection: Binding<TextAnimationTarget?>,
        hasAssignment: Bool = false
    ) -> some View {
        let isSelected = selection.wrappedValue == target

        Button {
            selection.wrappedValue = target
        } label: {
            HStack(spacing: 4) {
                Text(title)
                    .font(.caption.weight(.semibold))

                if hasAssignment && !isSelected {
                    Circle()
                        .fill(Color.accentColor)
                        .frame(width: 5, height: 5)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                isSelected
                    ? Color.accentColor.opacity(0.18)
                    : hasAssignment
                        ? Color.accentColor.opacity(0.08)
                        : Color.primary.opacity(0.06),
                in: Capsule()
            )
            .overlay {
                if hasAssignment && !isSelected {
                    Capsule()
                        .strokeBorder(Color.accentColor.opacity(0.35), lineWidth: 1)
                }
            }
        }
        .buttonStyle(.plain)
    }

    private func animationChip(
        _ kind: TextAnimationKind,
        isActive: Bool,
        apply: @escaping () -> Void
    ) -> some View {
        Button(action: apply) {
            VStack(spacing: 6) {
                Image(systemName: kind.systemImage)
                    .font(.body.weight(.semibold))
                Text(kind.displayName)
                    .font(.caption2.weight(.medium))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)
            }
            .frame(maxWidth: .infinity, minHeight: 64)
            .padding(8)
            .foregroundStyle(isActive ? Color.accentColor : Color.primary)
            .background(
                isActive ? Color.accentColor.opacity(0.14) : Color.primary.opacity(0.05),
                in: RoundedRectangle(cornerRadius: 12, style: .continuous)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(
                        isActive ? Color.accentColor.opacity(0.45) : Color.primary.opacity(0.08),
                        lineWidth: 1
                    )
            }
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var effectAssignmentControls: some View {
        if let selectedEffectTarget {
            if let index = animationProfile.effectAssignments.firstIndex(where: { $0.target == selectedEffectTarget }) {
                let binding = $animationProfile.effectAssignments[index]

                VStack(alignment: .leading, spacing: 10) {
                    Text("Pro effect settings for \(scopeLabel(for: selectedEffectTarget))")
                        .font(.subheadline.weight(.semibold))

                    LabeledContent("Intensity") {
                        Slider(value: binding.intensity, in: 0.2...2)
                    }

                    LabeledContent("Speed") {
                        Slider(value: binding.speed, in: 0.25...3)
                    }
                }
            } else {
                Text("Pick a Pro effect above to apply it to \(scopeLabel(for: selectedEffectTarget)).")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var slideDefaultsControls: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Default pro effect")
                .font(.subheadline.weight(.semibold))

            LabeledContent("Intensity") {
                Slider(value: $animationProfile.effectIntensity, in: 0.2...2)
            }

            LabeledContent("Speed") {
                Slider(value: $animationProfile.effectSpeed, in: 0.25...3)
            }
        }
    }

    private var activeTransitionKind: TextAnimationKind {
        if let selectedTransitionTarget,
           let assignment = animationProfile.transitionAssignments.first(where: { $0.target == selectedTransitionTarget }) {
            return assignment.kind
        }
        return animationProfile.transitionKind
    }

    private var activeEffectKind: TextAnimationKind {
        if let selectedEffectTarget,
           let assignment = animationProfile.effectAssignments.first(where: { $0.target == selectedEffectTarget }) {
            return assignment.kind
        }
        return animationProfile.effectFallback
    }

    private func applyTransition(_ kind: TextAnimationKind) {
        let parsed = SlideTextTokenizer.parse(sampleText)

        if kind == .none || kind.isProEffect {
            if let selectedTransitionTarget {
                switch selectedTransitionTarget {
                case .all:
                    animationProfile.transitionKind = .none
                    animationProfile.transitionAssignments.removeAll()
                case .paragraph(let index):
                    removeTransitionAssignments(inParagraph: index, parsed: parsed)
                    animationProfile.transitionAssignments.removeAll { $0.target == selectedTransitionTarget }
                case .line(let lineIndex):
                    removeTransitionAssignments(inLine: lineIndex)
                    animationProfile.transitionAssignments.removeAll { $0.target == selectedTransitionTarget }
                case .word:
                    animationProfile.transitionAssignments.removeAll { $0.target == selectedTransitionTarget }
                }
            } else {
                animationProfile.transitionKind = .none
                animationProfile.transitionAssignments.removeAll()
            }
            onTransitionReplayRequested?()
            return
        }

        if let selectedTransitionTarget {
            switch selectedTransitionTarget {
            case .all:
                animationProfile.transitionAssignments.removeAll()
                animationProfile.transitionKind = kind
            case .paragraph(let index):
                removeTransitionAssignments(inParagraph: index, parsed: parsed)
                upsertTransitionAssignment(target: selectedTransitionTarget, kind: kind)
            case .line(let lineIndex):
                removeTransitionAssignments(inLine: lineIndex)
                upsertTransitionAssignment(target: selectedTransitionTarget, kind: kind)
            case .word:
                upsertTransitionAssignment(target: selectedTransitionTarget, kind: kind)
            }
        } else {
            animationProfile.transitionAssignments.removeAll()
            animationProfile.transitionKind = kind
        }
        onTransitionReplayRequested?()
    }

    private func removeTransitionAssignments(inParagraph paragraphIndex: Int, parsed: ParsedSlideText) {
        guard parsed.paragraphLineRanges.indices.contains(paragraphIndex) else { return }
        let lineRange = parsed.paragraphLineRanges[paragraphIndex]

        animationProfile.transitionAssignments.removeAll { assignment in
            switch assignment.target {
            case .word(let line, _):
                lineRange.contains(line)
            case .line(let line):
                lineRange.contains(line)
            case .paragraph(let index):
                index == paragraphIndex
            case .all:
                false
            }
        }
    }

    private func removeTransitionAssignments(inLine lineIndex: Int) {
        animationProfile.transitionAssignments.removeAll { assignment in
            switch assignment.target {
            case .word(let line, _):
                line == lineIndex
            case .line(let line):
                line == lineIndex
            case .paragraph, .all:
                false
            }
        }
    }

    private func applyEffect(_ kind: TextAnimationKind) {
        guard kind.isProEffect || kind == .none else { return }
        let parsed = SlideTextTokenizer.parse(sampleText)

        if kind == .none {
            if let selectedEffectTarget {
                switch selectedEffectTarget {
                case .all:
                    animationProfile.effectFallback = .none
                    animationProfile.effectAssignments.removeAll()
                case .paragraph(let index):
                    removeEffectAssignments(inParagraph: index, parsed: parsed)
                    animationProfile.effectAssignments.removeAll { $0.target == selectedEffectTarget }
                case .line(let lineIndex):
                    removeEffectAssignments(inLine: lineIndex)
                    animationProfile.effectAssignments.removeAll { $0.target == selectedEffectTarget }
                case .word:
                    animationProfile.effectAssignments.removeAll { $0.target == selectedEffectTarget }
                }
            } else {
                animationProfile.effectFallback = .none
                animationProfile.effectAssignments.removeAll()
            }
            return
        }

        if let selectedEffectTarget {
            switch selectedEffectTarget {
            case .all:
                animationProfile.effectAssignments.removeAll()
                animationProfile.effectFallback = kind
            case .paragraph(let index):
                removeEffectAssignments(inParagraph: index, parsed: parsed)
                upsertEffectAssignment(target: selectedEffectTarget, kind: kind)
            case .line(let lineIndex):
                removeEffectAssignments(inLine: lineIndex)
                upsertEffectAssignment(target: selectedEffectTarget, kind: kind)
            case .word:
                upsertEffectAssignment(target: selectedEffectTarget, kind: kind)
            }
        } else {
            animationProfile.effectAssignments.removeAll()
            animationProfile.effectFallback = kind
        }
    }

    private func removeEffectAssignments(inParagraph paragraphIndex: Int, parsed: ParsedSlideText) {
        guard parsed.paragraphLineRanges.indices.contains(paragraphIndex) else { return }
        let lineRange = parsed.paragraphLineRanges[paragraphIndex]

        animationProfile.effectAssignments.removeAll { assignment in
            switch assignment.target {
            case .word(let line, _):
                lineRange.contains(line)
            case .line(let line):
                lineRange.contains(line)
            case .paragraph(let index):
                index == paragraphIndex
            case .all:
                false
            }
        }
    }

    private func removeEffectAssignments(inLine lineIndex: Int) {
        animationProfile.effectAssignments.removeAll { assignment in
            switch assignment.target {
            case .word(let line, _):
                line == lineIndex
            case .line(let line):
                line == lineIndex
            case .paragraph, .all:
                false
            }
        }
    }

    private func upsertTransitionAssignment(target: TextAnimationTarget, kind: TextAnimationKind) {
        if let index = animationProfile.transitionAssignments.firstIndex(where: { $0.target == target }) {
            animationProfile.transitionAssignments[index].kind = kind
        } else {
            animationProfile.transitionAssignments.append(
                TextAnimationAssignment(target: target, kind: kind)
            )
        }
    }

    private func upsertEffectAssignment(target: TextAnimationTarget, kind: TextAnimationKind) {
        if let index = animationProfile.effectAssignments.firstIndex(where: { $0.target == target }) {
            animationProfile.effectAssignments[index].kind = kind
        } else {
            animationProfile.effectAssignments.append(
                TextAnimationAssignment(target: target, kind: kind)
            )
        }
    }
}
