//
//  LyricEditorView.swift
//  Lyriora
//

import SwiftUI

struct LyricEditorView: View {
    @Bindable var viewModel: AppViewModel
    let existingLyricID: UUID?

    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rawContent = ""
    @State private var sourceSections: [LyricSectionSource] = []
    @State private var slides: [LyricSlide] = []
    @State private var styleProfile = LyricStyleProfile.default
    @State private var language: LyricLanguage = .unknown
    @State private var importError: String?
    @State private var didLoadInitialState = false
    @State private var preferredColumn: NavigationSplitViewColumn = .detail
    @State private var selectedPage: LyricEditorNavigationOption = .lyrics
    @State private var path = NavigationPath()
    @State private var selectedThemeID: UUID?
    @State private var styleSnapshotAtLoad: SlideTextStyle = .default
    @State private var showSaveThemePrompt = false
    @State private var themeNameDraft = ""
    @State private var suppressMaxLinesReparse = true

    private let contentMaxWidth: CGFloat = 700

    private var isEditing: Bool { existingLyricID != nil }

    private var referenceStyle: SlideTextStyle {
        if let activeTheme {
            return activeTheme.style
        }
        return styleSnapshotAtLoad
    }

    private var hasStyleChanges: Bool {
        styleProfile.defaultStyle != referenceStyle
    }

    private var activeTheme: LyricTheme? {
        if let selectedThemeID,
           let theme = viewModel.themes.first(where: { $0.id == selectedThemeID }) {
            return theme
        }
        if let match = viewModel.themes.first(where: { $0.style == styleProfile.defaultStyle }) {
            return match
        }
        return viewModel.themes.first { $0.name == styleProfile.name }
    }

    private var activeThemeName: String {
        if let activeTheme {
            return activeTheme.name
        }

        let profileName = styleProfile.name.trimmingCharacters(in: .whitespacesAndNewlines)
        if profileName.isEmpty {
            return "Custom Style"
        }
        return profileName
    }

    var body: some View {
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            sidebarList
        } detail: {
            detailNavigationStack(for: selectedPage)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { closeEditor() }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") { handleSaveTapped() }
                            .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || slides.isEmpty)
                    }
                }
        }
        .background(editorBackground)
        .onAppear {
            guard !didLoadInitialState else { return }
            didLoadInitialState = true
            loadInitialState()
            styleSnapshotAtLoad = styleProfile.defaultStyle
            syncSelectedThemeID()
            suppressMaxLinesReparse = false
        }
        .alert("Import Error", isPresented: importErrorBinding) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(importError ?? "")
        }
        .alert("Save as Theme?", isPresented: $showSaveThemePrompt) {
            TextField("Theme name", text: $themeNameDraft)
            Button("Save Theme") {
                saveThemeAndLyric()
            }
            Button("Save Lyric Only") {
                performSaveLyric()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("You changed the text style. Save it as a theme to reuse with other lyrics?")
        }
        .onChange(of: styleProfile.defaultStyle.maxLinesPerSlide) { _, _ in
            guard !suppressMaxLinesReparse else { return }
            rechunkSlides()
        }
        .onChange(of: styleProfile.defaultStyle.maxFontSize) { _, _ in
            guard !suppressMaxLinesReparse else { return }
            rechunkSlides()
        }
    }

    @ViewBuilder
    private var sidebarList: some View {
        List {
            Section {
                sidebarHeader
                    .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }

            Section {
                ForEach(LyricEditorNavigationOption.mainPages) { page in
                    Button {
                        selectPage(page)
                    } label: {
                        Label(page.title, systemImage: page.systemImage)
                            .font(.body.weight(selectedPage == page ? .semibold : .regular))
                            .foregroundStyle(selectedPage == page ? Color.accentColor : .primary)
                    }
                    .listRowBackground(
                        selectedPage == page
                            ? Color.accentColor.opacity(0.12)
                            : Color.clear
                    )
                }
            }

            Section {
                sidebarActiveTheme
                    .listRowInsets(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
        }
        .frame(minWidth: 200)
    }

    private func selectPage(_ page: LyricEditorNavigationOption) {
        guard selectedPage != page else {
            preferredColumn = .detail
            return
        }

        path = NavigationPath()
        selectedPage = page
        preferredColumn = .detail
    }

    @ViewBuilder
    private func detailNavigationStack(for page: LyricEditorNavigationOption) -> some View {
        NavigationStack(path: $path) {
            detailContent(for: page)
                .navigationDestination(for: UUID.self) { slideID in
                    slideDetailView(slideID: slideID)
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(editorBackground)
    }

    @ViewBuilder
    private var sidebarHeader: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(isEditing ? "Edit Lyric" : "New Lyric")
                .font(.title2.weight(.bold))
                .foregroundStyle(.primary)

            Text("Create and customize your lyrics")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 4)
    }

    @ViewBuilder
    private var sidebarActiveTheme: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                ThemeMiniPreview(
                    style: styleProfile.defaultStyle,
                    height: 48,
                    defaultBackgroundSettings: viewModel.settings.defaultBackground
                )
                .frame(width: 56)

                VStack(alignment: .leading, spacing: 2) {
                    Text(activeThemeName)
                        .font(.subheadline.weight(.semibold))
                        .lineLimit(1)

                    Text(styleProfile.defaultStyle.fontFamily.label)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer(minLength: 0)
            }

            Button {
                selectPage(.typography)
            } label: {
                Label("Preview", systemImage: "eye")
                    .font(.caption.weight(.semibold))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.small)
        }
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.primary.opacity(0.04))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.08), lineWidth: 1)
        }
    }

    @ViewBuilder
    private func detailContent(for page: LyricEditorNavigationOption) -> some View {
        Group {
            switch page {
            case .lyrics:
                lyricsSectionContent
            case .typography:
                GlobalStyleEditorContent(
                    viewModel: viewModel,
                    style: $styleProfile.defaultStyle,
                    profileName: $styleProfile.name,
                    selectedThemeID: $selectedThemeID,
                    onLayoutStyleChange: rechunkSlides
                )
            }
        }
        .onChange(of: styleProfile.defaultStyle) { _, _ in
            syncSelectedThemeID()
        }
    }

    @ViewBuilder
    private func slideDetailView(slideID: UUID) -> some View {
        if let index = slides.firstIndex(where: { $0.id == slideID }) {
            SlideDetailEditorView(
                slide: $slides[index],
                styleProfile: $styleProfile,
                language: language,
                defaultBackgroundSettings: viewModel.settings.defaultBackground,
                onDelete: { deleteSlide(id: slideID) },
                onSlideContentChanged: { syncSectionFromEditedSlide(slideID) }
            )
        }
    }

    @ViewBuilder
    private var lyricsSectionContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                importSection
                lyricsInfoSection
                slidesSection
                rawLyricsSection
            }
            .padding(24)
            .frame(maxWidth: contentMaxWidth)
            .frame(maxWidth: .infinity)
        }
    }

    @ViewBuilder
    private var editorBackground: some View {
        #if os(macOS)
        Color(nsColor: .windowBackgroundColor)
        #else
        Color(uiColor: .systemGroupedBackground)
        #endif
    }

    @ViewBuilder
    private var slidesSection: some View {
        EditorCard(title: "Slides (\(slides.count))", systemImage: "rectangle.on.rectangle") {
            LyricEditorSlideHorizontalListView(
                slides: slides,
                styleProfile: styleProfile,
                language: language,
                defaultBackgroundSettings: viewModel.settings.defaultBackground
            )
        }
    }

    @ViewBuilder
    private var importSection: some View {
        EditorCard(title: "Import Lyrics", systemImage: "square.and.arrow.down") {
            VStack(spacing: 16) {
                Button {
                    importFromClipboard()
                } label: {
                    VStack(spacing: 10) {
                        Image(systemName: "doc.on.clipboard")
                            .font(.title2)
                            .foregroundStyle(Color.accentColor)

                        Text("Import from Clipboard")
                            .font(.headline)
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .background {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [8, 6]))
                            .foregroundStyle(Color.primary.opacity(0.15))
                    }
                }
                .buttonStyle(.plain)

                Text("Paste lyrics with section headers (Coro, Puente, Chorus, Verse 1). Slides are created automatically with up to \(styleProfile.defaultStyle.maxLinesPerSlide) lines each.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    @ViewBuilder
    private var lyricsInfoSection: some View {
        EditorCard(title: "Lyrics Information", systemImage: "info.circle") {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Title")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)

                    TextField("Song title", text: $title)
                        .textFieldStyle(.roundedBorder)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Author / Artist")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)

                    TextField("Unknown", text: $author)
                        .textFieldStyle(.roundedBorder)
                }
            }
        }
    }

    @ViewBuilder
    private var rawLyricsSection: some View {
        EditorCard(title: "Raw Lyrics", systemImage: "doc.text") {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Spacer()
                    Button {
                        reparseFromRawContent()
                    } label: {
                        Label("Re-parse Slides", systemImage: "arrow.clockwise")
                            .font(.subheadline.weight(.medium))
                    }
                    .disabled(rawContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                ZStack(alignment: .topLeading) {
                    TextEditor(text: $rawContent)
                        .frame(minHeight: 280)
                        .scrollContentBackground(.hidden)
                        .padding(10)
                        .background(Color.primary.opacity(0.04), in: RoundedRectangle(cornerRadius: 10, style: .continuous))

                    if rawContent.isEmpty {
                        Text("Paste lyrics here with section tags like [Verse 1] or Coro.")
                            .foregroundStyle(.secondary)
                            .padding(.top, 18)
                            .padding(.leading, 14)
                            .allowsHitTesting(false)
                    }
                }
            }
        }
    }

    private var importErrorBinding: Binding<Bool> {
        Binding(
            get: { importError != nil },
            set: { if !$0 { importError = nil } }
        )
    }

    private func syncSelectedThemeID() {
        if let match = viewModel.themes.first(where: { $0.style == styleProfile.defaultStyle }) {
            selectedThemeID = match.id
        } else if let match = viewModel.themes.first(where: { $0.name == styleProfile.name }) {
            selectedThemeID = match.id
        }
    }

    private func loadInitialState() {
        guard let existingLyricID,
              let existingLyric = viewModel.lyrics.first(where: { $0.id == existingLyricID }) else {
            return
        }
        title = existingLyric.title
        styleProfile = existingLyric.styleProfile
        language = existingLyric.language

        if !existingLyric.sourceSections.isEmpty {
            sourceSections = existingLyric.sourceSections
        } else if !existingLyric.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            sourceSections = LyricImportParser.parseSections(existingLyric.content).sections
        } else {
            sourceSections = LyricImportParser.sections(from: existingLyric.slides)
        }

        slides = existingLyric.slides
        if slides.isEmpty, !sourceSections.isEmpty {
            rechunkSlides()
        }

        syncRawContentFromSections()
    }

    private func importFromClipboard() {
        do {
            let result = try viewModel.importLyricsFromClipboard(styleProfile: styleProfile)
            applyImportResult(result)
        } catch {
            importError = error.localizedDescription
        }
    }

    private func applyImportResult(_ result: LyricImportResult) {
        if let inferredTitle = result.title, title.isEmpty {
            title = inferredTitle
        }
        sourceSections = result.sections
        language = result.language
        rechunkSlides()
        syncRawContentFromSections()
        if let warning = result.warnings.first, result.slides.isEmpty {
            importError = warning
        }
    }

    private func rechunkSlides() {
        guard !sourceSections.isEmpty else {
            slides = []
            return
        }

        slides = LyricImportParser.makeSlides(
            from: sourceSections,
            style: styleProfile.defaultStyle
        )
    }

    private func reparseFromRawContent() {
        let result = LyricImportParser.parseSections(rawContent)
        sourceSections = result.sections
        language = result.language
        rechunkSlides()
        syncRawContentFromSections()
        if sourceSections.isEmpty {
            importError = LyricImportError.empty.errorDescription
        }
    }

    private func syncRawContentFromSections() {
        rawContent = LyricImportParser.rawText(from: sourceSections, language: language)
    }

    private func syncSectionFromEditedSlide(_ slideID: UUID) {
        guard let slide = slides.first(where: { $0.id == slideID }),
              let sectionID = slide.sourceSectionID,
              let sectionIndex = sourceSections.firstIndex(where: { $0.id == sectionID }) else {
            sourceSections = LyricImportParser.sections(from: slides)
            syncRawContentFromSections()
            return
        }

        let sectionSlides = slides
            .filter { $0.sourceSectionID == sectionID }
            .sorted { $0.order < $1.order }

        sourceSections[sectionIndex].lines = sectionSlides.flatMap { LyricImportParser.lines(from: $0.text) }
        sourceSections[sectionIndex].tag = sectionSlides.first?.tag ?? sourceSections[sectionIndex].tag

        rechunkSlides()
        syncRawContentFromSections()
    }

    private func deleteSlide(id: UUID) {
        if let slide = slides.first(where: { $0.id == id }),
           let sectionID = slide.sourceSectionID,
           let sectionIndex = sourceSections.firstIndex(where: { $0.id == sectionID }) {
            let sectionSlides = slides
                .filter { $0.sourceSectionID == sectionID }
                .sorted { $0.order < $1.order }

            var lineOffset = 0
            for sectionSlide in sectionSlides {
                let slideLines = LyricImportParser.lines(from: sectionSlide.text)
                if sectionSlide.id == id {
                    let end = lineOffset + slideLines.count
                    if lineOffset < end, end <= sourceSections[sectionIndex].lines.count {
                        sourceSections[sectionIndex].lines.removeSubrange(lineOffset..<end)
                    }
                    if sourceSections[sectionIndex].lines.isEmpty {
                        sourceSections.remove(at: sectionIndex)
                    }
                    break
                }
                lineOffset += slideLines.count
            }
        } else {
            slides.removeAll { $0.id == id }
            sourceSections = LyricImportParser.sections(from: slides)
        }

        rechunkSlides()
        syncRawContentFromSections()
    }

    private func handleSaveTapped() {
        if hasStyleChanges {
            themeNameDraft = styleProfile.name.isEmpty ? "My Theme" : styleProfile.name
            showSaveThemePrompt = true
        } else {
            performSaveLyric()
        }
    }

    private func saveThemeAndLyric() {
        let trimmed = themeNameDraft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        viewModel.saveTheme(name: trimmed, style: styleProfile.defaultStyle)
        styleProfile.name = trimmed
        if let saved = viewModel.themes.first(where: { $0.name == trimmed }) {
            selectedThemeID = saved.id
        }
        performSaveLyric()
    }

    private func performSaveLyric() {
        viewModel.saveLyric(
            id: existingLyricID,
            title: title,
            slides: slides,
            styleProfile: styleProfile,
            language: language,
            rawContent: rawContent,
            sourceSections: sourceSections
        )
        closeEditor()
    }

    private func closeEditor() {
        #if !os(macOS)
        viewModel.dismissLyricEditor()
        #endif
        dismiss()
    }
}

private struct EditorCard<Content: View>: View {
    let title: String
    var systemImage: String?
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label(title, systemImage: systemImage ?? "square")
                .font(.headline)
                .foregroundStyle(.primary)

            content()
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(cardBackground)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.06), lineWidth: 1)
        }
    }

    private var cardBackground: Color {
        #if os(macOS)
        Color(nsColor: .controlBackgroundColor)
        #else
        Color(uiColor: .systemBackground)
        #endif
    }
}
