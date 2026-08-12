//
//  SlideDetailEditorView.swift
//  Lyriora
//

import SwiftUI

struct SlideDetailEditorView: View {
    @Binding var slide: LyricSlide
    @Binding var styleProfile: LyricStyleProfile
    let language: LyricLanguage
    let defaultBackgroundSettings: DefaultBackgroundSettings
    let onDelete: () -> Void
    var onSlideContentChanged: (() -> Void)? = nil

    @Environment(\.dismiss) private var dismiss
    @State private var usesCustomStyle: Bool
    @State private var selectedTransitionTarget: TextAnimationTarget?
    @State private var selectedEffectTarget: TextAnimationTarget?
    @State private var isAnimationPreviewPlaying = true
    @State private var transitionReplayToken = 0
    @State private var transitionSettingsReplayTask: Task<Void, Never>?

    init(
        slide: Binding<LyricSlide>,
        styleProfile: Binding<LyricStyleProfile>,
        language: LyricLanguage,
        defaultBackgroundSettings: DefaultBackgroundSettings = .default,
        onDelete: @escaping () -> Void,
        onSlideContentChanged: (() -> Void)? = nil
    ) {
        _slide = slide
        _styleProfile = styleProfile
        self.language = language
        self.defaultBackgroundSettings = defaultBackgroundSettings
        self.onDelete = onDelete
        self.onSlideContentChanged = onSlideContentChanged
        _usesCustomStyle = State(initialValue: slide.wrappedValue.style != nil)
    }

    private var activeStyle: Binding<SlideTextStyle> {
        Binding(
            get: {
                slide.style ?? styleProfile.resolvedStyle(for: slide)
            },
            set: { newStyle in
                slide.style = newStyle
                usesCustomStyle = true
            }
        )
    }

    private var animationProfileBinding: Binding<SlideAnimationProfile> {
        Binding(
            get: {
                if let override = slide.animationProfile, override.hasAnimations {
                    return override
                }
                return styleProfile.defaultAnimationProfile
            },
            set: { newValue in
                if !newValue.hasAnimations || newValue == styleProfile.defaultAnimationProfile {
                    slide.animationProfile = nil
                } else {
                    slide.animationProfile = newValue
                }
            }
        )
    }

    private var previewAnimationProfile: SlideAnimationProfile {
        styleProfile.resolvedAnimationProfile(for: slide)
    }

    var body: some View {
        StickyPreviewEditorLayout {
            LyricSlideLivePreview(
                slide: slide,
                style: activeStyle.wrappedValue,
                language: language,
                scopeLabel: "Live Preview",
                compact: true,
                backgroundStyle: .settingsDefault(defaultBackgroundSettings),
                animationProfile: animationProfileBinding.wrappedValue,
                selectedTransitionTarget: selectedTransitionTarget,
                selectedEffectTarget: selectedEffectTarget,
                isAnimationPlaying: isAnimationPreviewPlaying,
                showsAnimations: isAnimationPreviewPlaying,
                isInteractive: true,
                transitionReplayToken: transitionReplayToken,
                skipsTransitionOnSlideChange: true,
                onWordTap: handleWordTap,
                onTransitionReplay: replayTransitionPreview
            )
        } content: {
            VStack(alignment: .leading, spacing: 24) {
                GroupBox("Slide Text") {
                    TextEditor(text: $slide.text)
                        .frame(minHeight: 120)
                        .scrollContentBackground(.hidden)
                        .padding(8)
                        .background(Color.primary.opacity(0.05), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }

                GroupBox("Tag") {
                    Picker("Section", selection: $slide.tag) {
                        ForEach(LyricSlideTag.allCases) { tag in
                            Text(tag.localizedName(for: language)).tag(tag)
                        }
                    }
                    .pickerStyle(.menu)
                }

                GroupBox("Typography") {
                    Toggle("Custom style for this slide", isOn: $usesCustomStyle)
                        .onChange(of: usesCustomStyle) { _, enabled in
                            if enabled {
                                if slide.style == nil {
                                    slide.style = styleProfile.resolvedStyle(for: slide)
                                }
                            } else {
                                slide.style = nil
                            }
                        }

                    if usesCustomStyle {
                        SlideStyleControlsView(style: activeStyle)
                    } else {
                        Text("Using global style from \"\(styleProfile.name)\".")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                GroupBox("Text Animations") {
                    TextAnimationEditorSection(
                        animationProfile: animationProfileBinding,
                        selectedTransitionTarget: $selectedTransitionTarget,
                        selectedEffectTarget: $selectedEffectTarget,
                        isPreviewPlaying: $isAnimationPreviewPlaying,
                        sampleText: slide.text,
                        showsPreviewAnimations: true,
                        onTransitionReplayRequested: replayTransitionPreview,
                        onTransitionSettingsChanged: { scheduleDebouncedTransitionReplay() }
                    )
                }

                Button("Delete Slide", role: .destructive) {
                    onDelete()
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationTitle("Slide \(slide.order + 1)")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .onAppear {
            restoreAnimationSelectionTargets()
            replayTransitionPreview()
        }
        .onDisappear {
            onSlideContentChanged?()
        }
        .onChange(of: selectedTransitionTarget) { _, _ in
            replayTransitionPreview()
        }
        .onChange(of: animationProfileBinding.wrappedValue.transitionKind) { _, _ in
            replayTransitionPreview()
        }
        .onChange(of: animationProfileBinding.wrappedValue.transitionIntensity) { _, _ in
            scheduleDebouncedTransitionReplay()
        }
        .onChange(of: animationProfileBinding.wrappedValue.transitionAssignments.map(\.speed)) { _, _ in
            scheduleDebouncedTransitionReplay()
        }
        .onChange(of: animationProfileBinding.wrappedValue.transitionWordStagger) { _, _ in
            replayTransitionPreview()
        }
        .onChange(of: isAnimationPreviewPlaying) { _, isPlaying in
            if isPlaying {
                replayTransitionPreview()
            }
        }
    }

    private func restoreAnimationSelectionTargets() {
        let profile = animationProfileBinding.wrappedValue
        selectedTransitionTarget = profile.preferredTransitionSelectionTarget
        selectedEffectTarget = profile.preferredEffectSelectionTarget
    }

    private func scheduleDebouncedTransitionReplay() {
        transitionSettingsReplayTask?.cancel()
        transitionSettingsReplayTask = Task {
            try? await Task.sleep(for: .milliseconds(160))
            guard !Task.isCancelled else { return }
            await MainActor.run {
                replayTransitionPreview()
            }
        }
    }

    private func replayTransitionPreview() {
        isAnimationPreviewPlaying = true
        transitionReplayToken += 1
    }

    private func handleWordTap(lineIndex: Int, wordIndex: Int) {
        let parsed = SlideTextTokenizer.parse(slide.text)
        selectedTransitionTarget = TextAnimationSelectionResolver.escalateSelection(
            current: selectedTransitionTarget,
            tappedLine: lineIndex,
            tappedWord: wordIndex,
            parsed: parsed
        )
        selectedEffectTarget = TextAnimationSelectionResolver.escalateSelection(
            current: selectedEffectTarget,
            tappedLine: lineIndex,
            tappedWord: wordIndex,
            parsed: parsed
        )
    }
}
