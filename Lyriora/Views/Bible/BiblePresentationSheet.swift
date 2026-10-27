//
//  BiblePresentationSheet.swift
//  Lyriora
//

import SwiftUI

struct BiblePresentationSheet: View {
    @Bindable var viewModel: AppViewModel
    @Environment(\.dismiss) private var dismiss

    private let hintsListHeight: CGFloat = 280

    @State private var showsStyleControls = true
    @State private var manualBookNumber = 43
    @State private var manualChapter = 3
    @State private var manualVerse = 16

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    versionHeader
                    searchCard
                    hintsSection
                    manualPassageCard
                    styleSection

                    if let error = viewModel.bibleImportErrorMessage {
                        Text(error)
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }
                }
                .padding(20)
            }
            .navigationTitle("Bible")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
        .onAppear {
            syncManualSelection()
        }
        .onChange(of: viewModel.loadedBibleIndex?.books.count) { _, _ in
            syncManualSelection()
        }
    }

    private var versionHeader: some View {
        HStack(spacing: 12) {
            if viewModel.bibleVersions.isEmpty {
                Label("Import a Bible XML to begin", systemImage: "book.closed")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                Menu {
                    ForEach(viewModel.bibleVersions) { version in
                        Button {
                            viewModel.selectBibleVersion(version)
                        } label: {
                            if version.id == viewModel.selectedBibleVersionID {
                                Label(version.prettyDisplayName, systemImage: "checkmark")
                            } else {
                                Text(version.prettyDisplayName)
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "book.closed.fill")
                        Text(viewModel.selectedBibleVersion?.prettyDisplayName ?? "Select version")
                            .font(.headline)
                        Image(systemName: "chevron.up.chevron.down")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background {
                        Capsule(style: .continuous)
                            .fill(.primary.opacity(0.06))
                    }
                }
                .menuStyle(.button)

                if viewModel.isLoadingBibleIndex {
                    ProgressView()
                        .controlSize(.small)
                }
            }

            Spacer(minLength: 0)

            Button {
                viewModel.isBibleVersionImportPresented = true
            } label: {
                Label("Import", systemImage: "square.and.arrow.down")
            }

            if let selected = viewModel.selectedBibleVersion {
                Button(role: .destructive) {
                    viewModel.deleteBibleVersion(selected)
                } label: {
                    Image(systemName: "trash")
                }
                .accessibilityLabel("Remove version")
            }
        }
    }

    private var searchCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField("Juan 3:16 or verse text…", text: searchBinding)
                    #if os(iOS)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    #endif
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(.primary.opacity(0.05))
            }

            Text("Reference or phrase — e.g. Juan 3:16, Juan 3, or \"porque de tal manera\"")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private var hintsSection: some View {
        if !viewModel.bibleSearchHints.isEmpty || viewModel.isSearchingBible {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text("Suggestions")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)

                    Spacer(minLength: 0)

                    if viewModel.isSearchingBible {
                        ProgressView()
                            .controlSize(.small)
                    }
                }

                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.bibleSearchHints) { hint in
                            hintRow(hint)
                        }
                    }
                }
                .frame(height: hintsListHeight)
            }
        } else if !viewModel.bibleSearchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                  viewModel.loadedBibleIndex != nil,
                  !viewModel.isLoadingBibleIndex,
                  !viewModel.isSearchingBible {
            VStack(alignment: .leading, spacing: 8) {
                Text("Suggestions")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)

                ContentUnavailableView(
                    "No matches",
                    systemImage: "text.magnifyingglass",
                    description: Text("Try another reference or phrase.")
                )
                .frame(height: hintsListHeight)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private func hintRow(_ hint: BibleSearchHint) -> some View {
        Button {
            viewModel.presentBibleHint(hint)
            dismiss()
        } label: {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(hint.title)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.primary)
                    if let subtitle = hint.subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }
                }
                Spacer(minLength: 0)
                Image(systemName: "arrow.up.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.tertiary)
            }
            .padding(14)
            .background {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(.primary.opacity(0.05))
            }
        }
        .buttonStyle(.plain)
    }

    private var manualPassageCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Go to passage")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            VStack(spacing: 12) {
                HStack(spacing: 10) {
                    passagePicker(title: "Book", selection: $manualBookNumber) {
                        ForEach(filteredBooks) { book in
                            Text(book.spanishName).tag(book.number)
                        }
                    }
                    .onChange(of: manualBookNumber) { _, _ in
                        clampManualChapterAndVerse()
                    }

                    if let book = BibleBookCatalog.book(number: manualBookNumber) {
                        passagePicker(title: "Chapter", selection: $manualChapter) {
                            ForEach(1...book.chapterCount, id: \.self) { chapter in
                                Text("\(chapter)").tag(chapter)
                            }
                        }
                        .onChange(of: manualChapter) { _, _ in
                            clampManualVerse()
                        }

                        passagePicker(title: "Verse", selection: $manualVerse) {
                            ForEach(1...max(1, availableVerseCount), id: \.self) { verse in
                                Text("\(verse)").tag(verse)
                            }
                        }
                    }
                }

                Text(manualReferencePreview)
                    .font(.title3.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 2)

                Button {
                    viewModel.presentBibleSelection(
                        bookNumber: manualBookNumber,
                        chapter: manualChapter,
                        verse: manualVerse
                    )
                    dismiss()
                } label: {
                    Label("Present \(manualReferencePreview)", systemImage: "play.rectangle.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.loadedBibleIndex == nil || availableVerseCount == 0)
            }
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.primary.opacity(0.05))
            }
        }
    }

    private var styleSection: some View {
        DisclosureGroup(isExpanded: $showsStyleControls) {
            VStack(alignment: .leading, spacing: 18) {
                BibleThemeQuickPicker(
                    themes: viewModel.recentBibleThemes,
                    selectedThemeID: viewModel.settings.biblePresentation.selectedThemeID,
                    defaultBackgroundSettings: viewModel.settings.defaultBackground,
                    onSelect: { theme in
                        viewModel.applyBibleTheme(theme)
                    }
                )

                SlideStyleControlsView(
                    style: bibleStyleBinding,
                    showsMaxLinesStepper: true,
                    onMaxLinesPerSlideChange: {
                        viewModel.refreshBibleSlidesIfNeeded()
                    }
                )

                BibleTransitionStyleSection(
                    animationProfile: bibleAnimationBinding
                )
            }
            .padding(.top, 8)
        } label: {
            Text("Text style")
                .font(.subheadline.weight(.semibold))
        }
    }

    private func passagePicker<Content: View>(
        title: String,
        selection: Binding<Int>,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            Picker(title, selection: selection, content: content)
                .labelsHidden()
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.background.opacity(0.55))
                }
        }
        .frame(maxWidth: .infinity)
    }

    private var filteredBooks: [BibleBookInfo] {
        BibleBookCatalog.books
    }

    private var manualReferencePreview: String {
        guard let book = BibleBookCatalog.book(number: manualBookNumber) else {
            return "—"
        }
        return book.formattedReference(chapter: manualChapter, verse: manualVerse, preferSpanish: true)
    }

    private var searchBinding: Binding<String> {
        Binding(
            get: { viewModel.bibleSearchQuery },
            set: { viewModel.updateBibleSearchQuery($0) }
        )
    }

    private var bibleStyleBinding: Binding<SlideTextStyle> {
        Binding(
            get: { viewModel.settings.biblePresentation.style },
            set: { newValue in
                viewModel.settings.biblePresentation.style = newValue
                viewModel.settings.biblePresentation.selectedThemeID = nil
                viewModel.saveSettings()
            }
        )
    }

    private var bibleAnimationBinding: Binding<SlideAnimationProfile> {
        Binding(
            get: { viewModel.settings.biblePresentation.animationProfile },
            set: { newValue in
                var profile = newValue
                profile.resetEffects()
                viewModel.settings.biblePresentation.animationProfile = profile
                viewModel.saveSettings()
            }
        )
    }

    private var availableVerseCount: Int {
        viewModel.loadedBibleIndex?
            .book(manualBookNumber)?
            .chapter(manualChapter)?
            .verseCount ?? 0
    }

    private func syncManualSelection() {
        clampManualChapterAndVerse()
    }

    private func clampManualChapterAndVerse() {
        if let book = BibleBookCatalog.book(number: manualBookNumber) {
            manualChapter = min(max(1, manualChapter), book.chapterCount)
        }
        clampManualVerse()
    }

    private func clampManualVerse() {
        let count = max(1, availableVerseCount)
        manualVerse = min(max(1, manualVerse), count)
    }
}
