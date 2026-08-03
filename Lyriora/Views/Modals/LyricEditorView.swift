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
    @State private var slides: [LyricSlide] = []
    @State private var styleProfile = LyricStyleProfile.default
    @State private var language: LyricLanguage = .unknown
    @State private var importError: String?
    @State private var didLoadInitialState = false
    @State private var preferredColumn: NavigationSplitViewColumn = .detail
    @State private var path = NavigationPath()
    @State private var selectedThemeID: UUID?
    @State private var typographyStyleSnapshot: SlideTextStyle = .default

    private let contentMaxWidth: CGFloat = 700

    private var isEditing: Bool { existingLyricID != nil }

    private var activeTheme: LyricTheme? {
        if let selectedThemeID,
           let theme = viewModel.themes.first(where: { $0.id == selectedThemeID }) {
            return theme
        }
        return viewModel.themes.first { $0.name == styleProfile.name }
    }

    var body: some View {
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            sidebarList
        } detail: {
            detailNavigationStack(for: .lyrics)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { closeEditor() }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") { performSaveLyric() }
                            .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || slides.isEmpty)
                    }
                }
        }
        .background(editorBackground)
        .onAppear {
            guard !didLoadInitialState else { return }
            didLoadInitialState = true
            loadInitialState()
            typographyStyleSnapshot = styleProfile.defaultStyle
            syncSelectedThemeID()
        }
        .alert("Import Error", isPresented: importErrorBinding) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(importError ?? "")
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
                    NavigationLink(value: page) {
                        Label(page.title, systemImage: page.systemImage)
                    }
                }
            }

            Section {
                sidebarActiveTheme
                    .listRowInsets(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
        }
        .navigationDestination(for: LyricEditorNavigationOption.self) { page in
            detailNavigationStack(for: page)
        }
        .frame(minWidth: 200)
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
                    style: activeTheme?.style ?? styleProfile.defaultStyle,
                    height: 48
                )
                .frame(width: 56)

                VStack(alignment: .leading, spacing: 2) {
                    Text(activeTheme?.name ?? styleProfile.name)
                        .font(.subheadline.weight(.semibold))
                        .lineLimit(1)

                    Text("Active Theme")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer(minLength: 0)
            }

            NavigationLink(value: LyricEditorNavigationOption.typography) {
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
                    selectedThemeID: $selectedThemeID
                )
            }
        }
        .onAppear {
            if page == .typography {
                typographyStyleSnapshot = styleProfile.defaultStyle
            }
        }
    }

    @ViewBuilder
    private func slideDetailView(slideID: UUID) -> some View {
        if let index = slides.firstIndex(where: { $0.id == slideID }) {
            SlideDetailEditorView(
                slide: $slides[index],
                styleProfile: $styleProfile,
                language: language,
                onDelete: { deleteSlide(id: slideID) }
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
                language: language
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

                Text("Paste lyrics with section headers (Coro, Puente, Chorus, Verse 1). Slides are created automatically with up to 4 lines each.")
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
                        reparseSlides()
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
        rawContent = existingLyric.content
        slides = existingLyric.slides
        styleProfile = existingLyric.styleProfile
        language = existingLyric.language
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
        slides = result.slides
        language = result.language
        rawContent = rebuildRawContent(from: result.slides)
        if let warning = result.warnings.first, result.slides.isEmpty {
            importError = warning
        }
    }

    private func reparseSlides() {
        let result = LyricImportParser.parse(rawContent, styleProfile: styleProfile)
        slides = result.slides
        language = result.language
        if slides.isEmpty {
            importError = LyricImportError.empty.errorDescription
        }
    }

    private func deleteSlide(id: UUID) {
        slides.removeAll { $0.id == id }
        slides = slides.enumerated().map { index, slide in
            var updated = slide
            updated.order = index
            return updated
        }
        rawContent = rebuildRawContent(from: slides)
    }

    private func performSaveLyric() {
        viewModel.saveLyric(
            id: existingLyricID,
            title: title,
            slides: slides,
            styleProfile: styleProfile,
            language: language,
            rawContent: rawContent
        )
        closeEditor()
    }

    private func closeEditor() {
        #if !os(macOS)
        viewModel.dismissLyricEditor()
        #endif
        dismiss()
    }

    private func rebuildRawContent(from slides: [LyricSlide]) -> String {
        slides.map { slide in
            let header = slide.tag.localizedName(for: language)
            return "\(header)\n\(slide.text)"
        }
        .joined(separator: "\n\n")
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
