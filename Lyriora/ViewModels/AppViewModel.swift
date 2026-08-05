//
//  AppViewModel.swift
//  Lyriora
//

import Foundation
import Observation
import PhotosUI
import SwiftUI
import UniformTypeIdentifiers

@MainActor
@Observable
final class AppViewModel {
    private(set) var lyrics: [LyricDocument] = []
    private(set) var imageAssets: [MediaAsset] = []
    private(set) var videoAssets: [MediaAsset] = []

    var selectedLyricID: UUID?
    var selectedSlideIndex: Int?
    var selectedBackgroundAssetID: UUID?

    var showBackground = true
    var showLyrics = true
    var settings = AppSettings.default

    private(set) var themes: [LyricTheme] = []

    var lyricEditorLaunch: LyricEditorLaunch?
    var isDisplayInfoSheetPresented = false
    var isSettingsSheetPresented = false

    var selectedPhotoItems: [PhotosPickerItem] = [] {
        didSet {
            Task { await importSelectedPhotos() }
        }
    }

    var selectedVideoItems: [PhotosPickerItem] = [] {
        didSet {
            Task { await importSelectedVideos() }
        }
    }

    let externalDisplayManager: ExternalDisplayManager

    private let lyricRepository: LyricRepositoryProtocol
    private let mediaRepository: MediaRepositoryProtocol
    private let settingsRepository: SettingsRepositoryProtocol
    private let themeRepository: ThemeRepositoryProtocol

    init(
        lyricRepository: LyricRepositoryProtocol? = nil,
        mediaRepository: MediaRepositoryProtocol? = nil,
        settingsRepository: SettingsRepositoryProtocol? = nil,
        themeRepository: ThemeRepositoryProtocol? = nil,
        externalDisplayManager: ExternalDisplayManager? = nil
    ) {
        self.lyricRepository = lyricRepository ?? LyricRepository()
        self.mediaRepository = mediaRepository ?? MediaRepository()
        self.settingsRepository = settingsRepository ?? SettingsRepository()
        self.themeRepository = themeRepository ?? ThemeRepository()
        self.externalDisplayManager = externalDisplayManager ?? ExternalDisplayManager()
    }

    var selectedLyric: LyricDocument? {
        guard let selectedLyricID else { return nil }
        return lyrics.first { $0.id == selectedLyricID }
    }

    var selectedSlide: LyricSlide? {
        guard let selectedSlideIndex, let lyric = selectedLyric else { return nil }
        let slides = resolvedSlides(for: lyric)
        guard slides.indices.contains(selectedSlideIndex) else { return nil }
        return slides[selectedSlideIndex]
    }

    var selectedLyricSlides: [LyricSlide] {
        guard let lyric = selectedLyric else { return [] }
        return resolvedSlides(for: lyric)
    }

    private var presentationLayoutCanvasSize: CGSize {
        PresentationLayout.resolvedCanvasSize(externalDisplayManager.presentationCanvasSize)
    }

    func resolvedSlides(for lyric: LyricDocument) -> [LyricSlide] {
        lyric.resolvedSlides(containerSize: presentationLayoutCanvasSize)
    }

    var selectedBackgroundAsset: MediaAsset? {
        guard let selectedBackgroundAssetID else { return nil }
        return imageAssets.first { $0.id == selectedBackgroundAssetID }
            ?? videoAssets.first { $0.id == selectedBackgroundAssetID }
    }

    var presentationState: PresentationState {
        let slide = selectedSlide
        let slideStyle = slide.flatMap { slide in
            selectedLyric.map { $0.styleProfile.resolvedStyle(for: slide) }
        }

        return PresentationState(
            showBackground: showBackground,
            showLyrics: showLyrics,
            slideText: slide?.text,
            lyricTitle: selectedLyric?.title,
            background: activePresentationBackground,
            slideStyle: slideStyle
        )
    }

    var activePresentationBackground: PresentationBackground? {
        guard let asset = selectedBackgroundAsset else { return nil }
        return PresentationBackground(
            url: mediaRepository.fileURL(for: asset),
            kind: asset.kind
        )
    }

    func loadInitialData() {
        settings = (try? settingsRepository.load()) ?? .default

        do {
            lyrics = try lyricRepository.loadAll()
            imageAssets = try mediaRepository.loadAll(kind: .image)
            videoAssets = try mediaRepository.loadAll(kind: .video)
        } catch {
            lyrics = []
            imageAssets = []
            videoAssets = []
        }

        if lyrics.isEmpty {
            seedSampleLyricsIfNeeded()
        }

        loadThemes()
    }

    func loadThemes() {
        themes = (try? themeRepository.loadAll()) ?? []
    }

    func saveTheme(name: String, style: SlideTextStyle) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        if let existingIndex = themes.firstIndex(where: { $0.name == trimmed }) {
            var existing = themes[existingIndex]
            existing.style = style
            existing.updatedAt = .now
            try? themeRepository.save(existing)
        } else {
            let theme = LyricTheme(name: trimmed, style: style)
            try? themeRepository.save(theme)
        }

        loadThemes()
    }

    func deleteTheme(_ theme: LyricTheme) {
        try? themeRepository.delete(theme)
        loadThemes()
    }

    func saveSettings() {
        try? settingsRepository.save(settings)
    }

    func resetSettings() {
        settings = .default
        saveSettings()
    }

    func selectLyric(_ lyric: LyricDocument) {
        selectedLyricID = lyric.id
        selectedSlideIndex = nil
        showLyrics = false
    }

    func deleteLyric(_ lyric: LyricDocument) {
        do {
            try lyricRepository.delete(lyric)
        } catch {
            return
        }

        lyrics.removeAll { $0.id == lyric.id }

        if selectedLyricID == lyric.id {
            if let next = lyrics.first {
                selectLyric(next)
            } else {
                selectedLyricID = nil
                selectedSlideIndex = nil
                showLyrics = false
            }
        }
    }

    func selectSlide(_ slide: LyricSlide) {
        selectedSlideIndex = slide.index
        showLyrics = true
    }

    func selectBackgroundMedia(_ asset: MediaAsset) {
        selectBackgroundMedia(withID: asset.id)
    }

    func selectBackgroundMedia(withID id: UUID) {
        selectedBackgroundAssetID = id
        showBackground = true
    }

    func presentNewLyricEditor() {
        lyricEditorLaunch = LyricEditorLaunch(existingLyricID: nil)
    }

    func presentLyricEditor(for lyric: LyricDocument) {
        lyricEditorLaunch = LyricEditorLaunch(existingLyricID: lyric.id)
    }

    func dismissLyricEditor() {
        lyricEditorLaunch = nil
    }

    func saveLyric(
        id: UUID?,
        title: String,
        slides: [LyricSlide],
        styleProfile: LyricStyleProfile,
        language: LyricLanguage,
        rawContent: String,
        sourceSections: [LyricSectionSource] = []
    ) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty, !slides.isEmpty else { return }

        let canonicalSections = sourceSections.isEmpty
            ? LyricImportParser.parseSections(rawContent).sections
            : sourceSections
        let canonicalContent = canonicalSections.isEmpty
            ? rawContent
            : LyricImportParser.rawText(from: canonicalSections, language: language)

        var lyric = LyricDocument(
            id: id ?? UUID(),
            title: trimmedTitle,
            content: canonicalContent,
            storedSlides: slides.enumerated().map { index, slide in
                var normalized = slide
                normalized.order = index
                return normalized
            },
            sourceSections: canonicalSections,
            styleProfile: styleProfile,
            language: language
        )

        do {
            try lyricRepository.save(lyric)
            if let existingIndex = lyrics.firstIndex(where: { $0.id == lyric.id }) {
                lyrics[existingIndex] = lyric
            } else {
                lyrics.insert(lyric, at: 0)
            }
            selectLyric(lyric)
        } catch {
            return
        }
    }

    func importLyricsFromClipboard(styleProfile: LyricStyleProfile = .default) throws -> LyricImportResult {
        let text = try LyricClipboardImporter.readText()
        return LyricImportParser.parse(text, styleProfile: styleProfile)
    }

    func createLyric(title: String, content: String) {
        let parsed = LyricImportParser.parse(content)
        saveLyric(
            id: nil,
            title: parsed.title ?? title,
            slides: parsed.slides,
            styleProfile: .default,
            language: parsed.language,
            rawContent: LyricImportParser.rawText(from: parsed.sections, language: parsed.language),
            sourceSections: parsed.sections
        )
    }

    func clearAll() {
        selectedBackgroundAssetID = nil
        showBackground = true
        showLyrics = false
    }

    func clearBackground() {
        selectedBackgroundAssetID = nil
        showBackground = true
    }

    func clearLyrics() {
        showLyrics = false
    }

    var hasCustomBackgroundSelected: Bool {
        selectedBackgroundAssetID != nil
    }

    func toggleExternalDisplay() {
        let newValue = !externalDisplayManager.isPresentationEnabled
        externalDisplayManager.setPresentationEnabled(newValue, viewModel: self)
    }

    func refreshExternalPresentation() {
        externalDisplayManager.refreshPresentation()
    }

    func imageURL(for asset: MediaAsset) -> URL {
        mediaRepository.fileURL(for: asset)
    }

    func videoURL(for asset: MediaAsset) -> URL {
        mediaRepository.fileURL(for: asset)
    }

    func isBackgroundSelected(_ asset: MediaAsset) -> Bool {
        selectedBackgroundAssetID == asset.id
    }

    func deleteMediaAsset(_ asset: MediaAsset) {
        do {
            try mediaRepository.delete(asset)
        } catch {
            return
        }

        switch asset.kind {
        case .image:
            imageAssets.removeAll { $0.id == asset.id }
        case .video:
            videoAssets.removeAll { $0.id == asset.id }
        }

        if selectedBackgroundAssetID == asset.id {
            selectedBackgroundAssetID = nil
        }
    }

    private func importSelectedPhotos() async {
        for item in selectedPhotoItems {
            guard let data = try? await item.loadTransferable(type: Data.self) else { continue }

            do {
                let asset = try mediaRepository.importData(data, kind: .image, preferredExtension: "jpg")
                imageAssets.insert(asset, at: 0)
            } catch {
                continue
            }
        }

        selectedPhotoItems = []
    }

    private func importSelectedVideos() async {
        for item in selectedVideoItems {
            guard let data = try? await item.loadTransferable(type: Data.self) else { continue }

            do {
                let asset = try mediaRepository.importData(data, kind: .video, preferredExtension: "mp4")
                videoAssets.insert(asset, at: 0)
            } catch {
                continue
            }
        }

        selectedVideoItems = []
    }

    private func seedSampleLyricsIfNeeded() {
        let samples = [
            LyricDocument(
                title: "Amazing Grace",
                content: "",
                storedSlides: LyricImportParser.parse(
                    """
                    Verse 1
                    Amazing grace, how sweet the sound
                    That saved a wretch like me
                    I once was lost, but now am found
                    Was blind, but now I see

                    Verse 2
                    Through many dangers, toils and snares
                    I have already come
                    'Tis grace hath brought me safe thus far
                    And grace will lead me home
                    """
                ).slides,
                language: .english
            ),
            LyricDocument(
                title: "How Great Thou Art",
                content: "",
                storedSlides: LyricImportParser.parse(
                    """
                    Verse
                    O Lord my God, when I in awesome wonder
                    Consider all the worlds Thy hands have made
                    I see the stars, I hear the rolling thunder
                    Thy power throughout the universe displayed

                    Chorus
                    Then sings my soul, my Savior God, to Thee
                    How great Thou art, how great Thou art
                    Then sings my soul, my Savior God, to Thee
                    How great Thou art, how great Thou art
                    """
                ).slides,
                language: .english
            )
        ]

        for var sample in samples {
            sample.syncContentFromSlides()
            try? lyricRepository.save(sample)
        }

        lyrics = samples
        if let first = samples.first {
            selectLyric(first)
        }
    }
}
