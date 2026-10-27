//
//  GlobalStyleEditorView.swift
//  Lyriora
//

import SwiftUI

struct GlobalStyleEditorContent: View {
    @Bindable var viewModel: AppViewModel
    @Binding var style: SlideTextStyle
    @Binding var profileName: String
    @Binding var selectedThemeID: UUID?
    var styleProfile: Binding<LyricStyleProfile>? = nil
    var defaultAnimationProfile: Binding<SlideAnimationProfile>? = nil
    var slides: Binding<[LyricSlide]>?
    var language: LyricLanguage = .english
    var defaultBackgroundSettings: DefaultBackgroundSettings = .default
    var onLayoutStyleChange: (() -> Void)? = nil

    @State private var previewSlideIndex = 0
    @State private var animationApplyScope: AnimationApplyScope = .allSlides
    @State private var didConfigureInitialAnimationScope = false
    @State private var fallbackAnimationProfile = SlideAnimationProfile()
    @State private var selectedTransitionTarget: TextAnimationTarget?
    @State private var selectedEffectTarget: TextAnimationTarget?
    @State private var selectedFontSizeTarget: TextAnimationTarget?
    @State private var isAnimationPreviewPlaying = true
    @State private var transitionReplayToken = 0
    @State private var transitionSettingsReplayTask: Task<Void, Never>?

    private var lyricSlides: [LyricSlide] {
        slides?.wrappedValue ?? []
    }

    private var usesLyricSlides: Bool {
        !lyricSlides.isEmpty
    }

    private var currentSlide: LyricSlide? {
        guard usesLyricSlides, lyricSlides.indices.contains(previewSlideIndex) else { return nil }
        return lyricSlides[previewSlideIndex]
    }

    private var lyricDefaultAnimationBinding: Binding<SlideAnimationProfile> {
        defaultAnimationProfile ?? $fallbackAnimationProfile
    }

    private var previewStyle: SlideTextStyle {
        if let currentSlide, let styleProfile {
            return styleProfile.wrappedValue.resolvedStyle(for: currentSlide)
        }
        return style
    }

    private var previewAnimationProfile: SlideAnimationProfile {
        if let currentSlide,
           let override = currentSlide.animationProfile,
           override.hasAnimations {
            return override
        }
        return lyricDefaultAnimationBinding.wrappedValue
    }

    private var previewText: String {
        if let currentSlide {
            return currentSlide.text
        }
        return LyricTheme.previewSampleText(maxLines: style.maxLinesPerSlide)
    }

    private var previewSlideForDisplay: LyricSlide? {
        if let currentSlide {
            return currentSlide
        }
        return LyricSlide(
            order: 0,
            text: previewText,
            tag: .chorus
        )
    }

    private var previewWordFontSizeOverrides: [WordFontSizeOverride] {
        currentSlide?.wordFontSizeOverrides ?? []
    }

    private var wordFontSizeOverridesBinding: Binding<[WordFontSizeOverride]>? {
        guard let slides, slides.wrappedValue.indices.contains(previewSlideIndex) else { return nil }
        return Binding(
            get: { slides.wrappedValue[previewSlideIndex].wordFontSizeOverrides },
            set: { newValue in
                slides.wrappedValue[previewSlideIndex].wordFontSizeOverrides = newValue
            }
        )
    }

    private var animationProfileBinding: Binding<SlideAnimationProfile> {
        switch animationApplyScope {
        case .allSlides:
            return lyricDefaultAnimationBinding
        case .currentSlide:
            return Binding(
                get: {
                    guard let slides, slides.wrappedValue.indices.contains(previewSlideIndex) else {
                        return SlideAnimationProfile()
                    }
                    let slide = slides.wrappedValue[previewSlideIndex]
                    if let override = slide.animationProfile, override.hasAnimations {
                        return override
                    }
                    return lyricDefaultAnimationBinding.wrappedValue
                },
                set: { newValue in
                    guard var slides, slides.wrappedValue.indices.contains(previewSlideIndex) else { return }
                    let defaultProfile = lyricDefaultAnimationBinding.wrappedValue
                    if !newValue.hasAnimations || newValue == defaultProfile {
                        slides.wrappedValue[previewSlideIndex].animationProfile = nil
                    } else {
                        slides.wrappedValue[previewSlideIndex].animationProfile = newValue
                    }
                }
            )
        }
    }

    var body: some View {
        StickyPreviewEditorLayout {
            LyricSlideLivePreview(
                slide: previewSlideForDisplay,
                style: previewStyle,
                language: language,
                scopeLabel: usesLyricSlides ? "Lyric Preview" : "Sample Preview",
                compact: true,
                backgroundStyle: .settingsDefault(defaultBackgroundSettings),
                animationProfile: animationProfileBinding.wrappedValue,
                selectedTransitionTarget: selectedTransitionTarget,
                selectedEffectTarget: selectedEffectTarget,
                selectedFontSizeTarget: selectedFontSizeTarget,
                wordFontSizeOverrides: previewWordFontSizeOverrides,
                isAnimationPlaying: isAnimationPreviewPlaying,
                showsAnimations: isAnimationPreviewPlaying,
                isInteractive: true,
                transitionReplayToken: transitionReplayToken,
                skipsTransitionOnSlideChange: usesLyricSlides,
                onWordTap: handleWordTap,
                onTransitionReplay: replayTransitionPreview
            )
        } content: {
            VStack(alignment: .leading, spacing: 24) {
                if usesLyricSlides {
                    TextStyleSlidePreviewNavigator(
                        slides: lyricSlides,
                        language: language,
                        selectedIndex: $previewSlideIndex
                    )

                    if let currentSlide, currentSlide.style != nil {
                        Label(
                            "This slide uses a custom style. Typography controls below edit the global default.",
                            systemImage: "textformat.size"
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                }

                ThemePickerMenu(
                    themes: viewModel.themes,
                    selectedThemeID: $selectedThemeID,
                    defaultBackgroundSettings: viewModel.settings.defaultBackground,
                    onSelect: applyTheme
                )

                SlideStyleControlsView(
                    style: $style,
                    showsMaxLinesStepper: true,
                    selectedWordTarget: selectedFontSizeTarget,
                    wordFontSizeOverrides: wordFontSizeOverridesBinding,
                    onMaxLinesPerSlideChange: onLayoutStyleChange,
                    onFontSizeChange: onLayoutStyleChange,
                    onLayoutStyleChange: onLayoutStyleChange
                )

                GroupBox("Text Animations") {
                    TextAnimationEditorSection(
                        animationProfile: animationProfileBinding,
                        selectedTransitionTarget: $selectedTransitionTarget,
                        selectedEffectTarget: $selectedEffectTarget,
                        isPreviewPlaying: $isAnimationPreviewPlaying,
                        sampleText: previewText,
                        animationApplyScope: usesLyricSlides ? $animationApplyScope : nil,
                        showsPreviewAnimations: true,
                        onTransitionReplayRequested: replayTransitionPreview,
                        onTransitionSettingsChanged: { scheduleDebouncedTransitionReplay() }
                    )
                }
            }
        }
        .onAppear {
            configureInitialAnimationEditorStateIfNeeded()
        }
        .onChange(of: lyricSlides.count) { oldCount, count in
            guard count > 0 else {
                previewSlideIndex = 0
                return
            }
            previewSlideIndex = min(previewSlideIndex, count - 1)
            if oldCount == 0 {
                configureInitialAnimationEditorStateIfNeeded()
            }
        }
        .onChange(of: previewSlideIndex) { _, _ in
            restoreAnimationSelectionTargets()
        }
        .onChange(of: animationApplyScope) { _, _ in
            restoreAnimationSelectionTargets()
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

    private func configureInitialAnimationEditorStateIfNeeded() {
        guard usesLyricSlides, !didConfigureInitialAnimationScope, !lyricSlides.isEmpty else { return }

        didConfigureInitialAnimationScope = true
        let initial = AnimationApplyScope.preferredEditorState(slides: lyricSlides)
        animationApplyScope = initial.scope
        previewSlideIndex = min(initial.slideIndex, lyricSlides.count - 1)
        restoreAnimationSelectionTargets()
        replayTransitionPreview()
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
        let parsed = SlideTextTokenizer.parse(previewText)
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
        selectedFontSizeTarget = TextAnimationSelectionResolver.escalateSelection(
            current: selectedFontSizeTarget,
            tappedLine: lineIndex,
            tappedWord: wordIndex,
            parsed: parsed
        )
    }

    private func applyTheme(_ theme: LyricTheme) {
        style = theme.style
        profileName = theme.name
        selectedThemeID = theme.id
    }
}

struct GlobalStyleEditorView: View {
    @Bindable var viewModel: AppViewModel
    @Binding var style: SlideTextStyle
    @Binding var profileName: String

    @Environment(\.dismiss) private var dismiss

    @State private var styleSnapshot: SlideTextStyle = .default
    @State private var selectedThemeID: UUID?
    @State private var showExitThemePrompt = false
    @State private var themeNameDraft = ""

    private var hasStyleChanges: Bool {
        style != styleSnapshot
    }

    var body: some View {
        GlobalStyleEditorContent(
            viewModel: viewModel,
            style: $style,
            profileName: $profileName,
            selectedThemeID: $selectedThemeID
        )
        .navigationTitle("Text Style")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Back") {
                    handleBack()
                }
            }
        }
        .onAppear {
            styleSnapshot = style
            themeNameDraft = profileName.isEmpty ? "My Theme" : profileName
            syncSelectedThemeID()
        }
        .onChange(of: style) { _, _ in
            syncSelectedThemeID()
        }
        .sheet(isPresented: $showExitThemePrompt) {
            ThemeSavePromptSheet(
                isPresented: $showExitThemePrompt,
                themeName: $themeNameDraft,
                message: "Save this typography as a Theme to reuse with other lyrics?",
                secondaryButtonTitle: "Don't Save",
                onSaveTheme: {
                    saveTheme(named: themeNameDraft)
                    dismiss()
                },
                onSecondary: {
                    dismiss()
                }
            )
        }
    }

    private func handleBack() {
        if hasStyleChanges {
            themeNameDraft = profileName.isEmpty ? "My Theme" : profileName
            KeyboardDismissal.dismissIfNeeded()
            showExitThemePrompt = true
        } else {
            dismiss()
        }
    }

    private func syncSelectedThemeID() {
        if let match = viewModel.themes.first(where: { $0.style == style }) {
            selectedThemeID = match.id
        }
    }

    private func saveTheme(named name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        viewModel.saveTheme(name: trimmed, style: style)
        profileName = trimmed
        if let saved = viewModel.themes.first(where: { $0.name == trimmed }) {
            selectedThemeID = saved.id
        }
        styleSnapshot = style
    }
}
