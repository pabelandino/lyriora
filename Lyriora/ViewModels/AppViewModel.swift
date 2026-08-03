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

    var isNewLyricSheetPresented = false
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

    init(
        lyricRepository: LyricRepositoryProtocol? = nil,
        mediaRepository: MediaRepositoryProtocol? = nil,
        settingsRepository: SettingsRepositoryProtocol? = nil,
        externalDisplayManager: ExternalDisplayManager? = nil
    ) {
        self.lyricRepository = lyricRepository ?? LyricRepository()
        self.mediaRepository = mediaRepository ?? MediaRepository()
        self.settingsRepository = settingsRepository ?? SettingsRepository()
        self.externalDisplayManager = externalDisplayManager ?? ExternalDisplayManager()
    }

    var selectedLyric: LyricDocument? {
        guard let selectedLyricID else { return nil }
        return lyrics.first { $0.id == selectedLyricID }
    }

    var selectedSlide: LyricSlide? {
        guard let selectedSlideIndex, let lyric = selectedLyric else { return nil }
        let slides = lyric.slides
        guard slides.indices.contains(selectedSlideIndex) else { return nil }
        return slides[selectedSlideIndex]
    }

    var selectedBackgroundAsset: MediaAsset? {
        guard let selectedBackgroundAssetID else { return nil }
        return imageAssets.first { $0.id == selectedBackgroundAssetID }
            ?? videoAssets.first { $0.id == selectedBackgroundAssetID }
    }

    var presentationState: PresentationState {
        PresentationState(
            showBackground: showBackground,
            showLyrics: showLyrics,
            slideText: selectedSlide?.text,
            lyricTitle: selectedLyric?.title,
            background: activePresentationBackground
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
        selectedSlideIndex = lyric.slides.first?.index
        showLyrics = true
    }

    func selectSlide(_ slide: LyricSlide) {
        selectedSlideIndex = slide.index
        showLyrics = true
    }

    func selectBackgroundMedia(_ asset: MediaAsset) {
        selectedBackgroundAssetID = asset.id
        showBackground = true
    }

    func createLyric(title: String, content: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty, !trimmedContent.isEmpty else { return }

        let lyric = LyricDocument(title: trimmedTitle, content: trimmedContent)

        do {
            try lyricRepository.save(lyric)
            lyrics.insert(lyric, at: 0)
            selectLyric(lyric)
        } catch {
            return
        }
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
                content: """
                Amazing grace, how sweet the sound
                That saved a wretch like me
                I once was lost, but now am found
                Was blind, but now I see

                ---

                Through many dangers, toils and snares
                I have already come
                'Tis grace hath brought me safe thus far
                And grace will lead me home
                """
            ),
            LyricDocument(
                title: "How Great Thou Art",
                content: """
                O Lord my God, when I in awesome wonder
                Consider all the worlds Thy hands have made
                I see the stars, I hear the rolling thunder
                Thy power throughout the universe displayed

                ---

                Then sings my soul, my Savior God, to Thee
                How great Thou art, how great Thou art
                Then sings my soul, my Savior God, to Thee
                How great Thou art, how great Thou art
                """
            )
        ]

        for sample in samples {
            try? lyricRepository.save(sample)
        }

        lyrics = samples
        if let first = samples.first {
            selectLyric(first)
        }
    }
}
