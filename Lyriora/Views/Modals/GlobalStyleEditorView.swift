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
    var onLayoutStyleChange: (() -> Void)? = nil

    private let sampleSlide = LyricSlide(
        order: 0,
        text: LyricTheme.previewSampleText,
        tag: .chorus
    )

    private var stylePreviewText: String {
        LyricTheme.previewSampleText(maxLines: style.maxLinesPerSlide)
    }

    var body: some View {
        StickyPreviewEditorLayout {
            LyricSlideLivePreview(
                slide: sampleSlide,
                style: style,
                language: .english,
                scopeLabel: "Live Preview",
                compact: true,
                previewText: stylePreviewText,
                backgroundStyle: .borderOnly
            )
        } content: {
            VStack(alignment: .leading, spacing: 24) {
                ThemePickerMenu(
                    themes: viewModel.themes,
                    selectedThemeID: $selectedThemeID,
                    defaultBackgroundSettings: viewModel.settings.defaultBackground,
                    onSelect: applyTheme
                )

                SlideStyleControlsView(
                    style: $style,
                    showsMaxLinesStepper: true,
                    onMaxLinesPerSlideChange: onLayoutStyleChange,
                    onFontSizeChange: onLayoutStyleChange,
                    onLayoutStyleChange: onLayoutStyleChange
                )
            }
        }
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
        .alert("Save as Theme?", isPresented: $showExitThemePrompt) {
            TextField("Theme name", text: $themeNameDraft)
            Button("Save Theme") {
                saveTheme(named: themeNameDraft)
                dismiss()
            }
            Button("Don't Save") {
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Save this typography as a Theme to reuse with other lyrics?")
        }
    }

    private func handleBack() {
        if hasStyleChanges {
            themeNameDraft = profileName.isEmpty ? "My Theme" : profileName
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
