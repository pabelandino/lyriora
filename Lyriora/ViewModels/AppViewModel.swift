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
    var slidePresentationToken = 0
    var selectedBackgroundAssetID: UUID?

    var showBackground = true
    var showLyrics = true
    var settings = AppSettings.default

    var videoPlaybackMode: VideoPlaybackMode = .loop
    var isVideoPlaying = true
    let videoPlayback = VideoPlaybackController()
    let youtubePlayback = YouTubePlaybackController()
    private(set) var showsVideoPlaybackControls = false
    private(set) var videoStopToken = 0
    private var videoControlsRevealTask: Task<Void, Never>?
    private(set) var videoDurationByFileName: [String: TimeInterval] = [:]

    private(set) var themes: [LyricTheme] = []
    private(set) var playlists: [LibraryPlaylist] = []

    var selectedLyricPlaylistID: UUID?
    var selectedImagePlaylistID: UUID?
    var selectedVideoPlaylistID: UUID?

    var isPlaylistPickerPresented = false
    var isPlaylistEditorPresented = false
    var playlistPickerKind: LibraryPlaylistKind = .lyric
    var playlistEditorTargetID: UUID?

    var lyricEditorLaunch: LyricEditorLaunch?
    var isDisplayInfoSheetPresented = false
    var isSettingsSheetPresented = false
    var isSimplePlayConnectionInfoPresented = false

    private(set) var simplePlayConnectionRefreshToken = 0

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
    private let simplePlaySync = LyricPlaySyncServer()
    private var simplePlayConnectionMonitorTask: Task<Void, Never>?

    private let lyricRepository: LyricRepositoryProtocol
    private let mediaRepository: MediaRepositoryProtocol
    private let settingsRepository: SettingsRepositoryProtocol
    private let themeRepository: ThemeRepositoryProtocol
    private let playlistRepository: PlaylistRepositoryProtocol

    init(
        lyricRepository: LyricRepositoryProtocol? = nil,
        mediaRepository: MediaRepositoryProtocol? = nil,
        settingsRepository: SettingsRepositoryProtocol? = nil,
        themeRepository: ThemeRepositoryProtocol? = nil,
        playlistRepository: PlaylistRepositoryProtocol? = nil,
        externalDisplayManager: ExternalDisplayManager? = nil
    ) {
        self.lyricRepository = lyricRepository ?? LyricRepository()
        self.mediaRepository = mediaRepository ?? MediaRepository()
        self.settingsRepository = settingsRepository ?? SettingsRepository()
        self.themeRepository = themeRepository ?? ThemeRepository()
        self.playlistRepository = playlistRepository ?? PlaylistRepository()
        self.externalDisplayManager = externalDisplayManager ?? ExternalDisplayManager()
        self.videoPlayback.onDurationUpdate = { [weak self] duration in
            guard let self, let asset = selectedBackgroundAsset else { return }
            videoDurationByFileName[asset.fileName] = duration
        }
        self.youtubePlayback.onDurationUpdate = { [weak self] duration in
            guard let self, let asset = selectedBackgroundAsset, asset.isYouTubeLink else { return }
            videoDurationByFileName[asset.fileName] = duration
        }
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
            slideStyle: slideStyle,
            slideAnimationProfile: slide.flatMap { selectedSlide in
                selectedLyric.map { $0.styleProfile.resolvedAnimationProfile(for: selectedSlide) }
            },
            wordFontSizeOverrides: slide?.wordFontSizeOverrides ?? [],
            slideID: slide?.id,
            slidePresentationToken: slidePresentationToken,
            videoLoops: resolvedVideoLoops,
            isVideoPlaying: hasControllableVideoBackgroundSelected ? isVideoPlaying : true,
            videoStopToken: videoStopToken
        )
    }

    var activePresentationBackground: PresentationBackground? {
        guard let asset = selectedBackgroundAsset else { return nil }

        if asset.isYouTubeLink,
           let sourceURL = mediaRepository.youtubeLinkURL(for: asset),
           let videoID = YouTubeLinkParser.videoID(from: sourceURL) {
            return PresentationBackground(
                url: sourceURL,
                kind: .video,
                youtubeVideoID: videoID
            )
        }

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
        loadPlaylists()
        Task { await preloadVideoDurations() }
        Task { await refreshYouTubeTitlesIfNeeded() }
    }

    func loadPlaylists() {
        playlists = (try? playlistRepository.loadAll()) ?? []
    }

    func playlists(for kind: LibraryPlaylistKind) -> [LibraryPlaylist] {
        playlists.filter { $0.kind == kind }
    }

    func selectedPlaylistID(for kind: LibraryPlaylistKind) -> UUID? {
        switch kind {
        case .lyric: selectedLyricPlaylistID
        case .image: selectedImagePlaylistID
        case .video: selectedVideoPlaylistID
        }
    }

    func selectedPlaylist(for kind: LibraryPlaylistKind) -> LibraryPlaylist? {
        guard let id = selectedPlaylistID(for: kind) else { return nil }
        return playlists.first { $0.id == id }
    }

    func selectPlaylist(_ playlist: LibraryPlaylist) {
        selectPlaylist(for: playlist.kind, id: playlist.id)
    }

    func clearPlaylistSelection(for kind: LibraryPlaylistKind) {
        switch kind {
        case .lyric: selectedLyricPlaylistID = nil
        case .image: selectedImagePlaylistID = nil
        case .video: selectedVideoPlaylistID = nil
        }
    }

    func presentPlaylistPicker(for kind: LibraryPlaylistKind) {
        playlistPickerKind = kind
        isPlaylistPickerPresented = true
    }

    func presentPlaylistEditor(for playlist: LibraryPlaylist?) {
        if let playlist {
            playlistEditorTargetID = playlist.id
        } else {
            playlistEditorTargetID = nil
        }
        isPlaylistEditorPresented = true
    }

    @discardableResult
    func createPlaylist(name: String, kind: LibraryPlaylistKind) -> LibraryPlaylist? {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }

        let playlist = LibraryPlaylist(name: trimmed, kind: kind)
        try? playlistRepository.save(playlist)
        loadPlaylists()
        selectPlaylist(for: kind, id: playlist.id)
        return playlist
    }

    func renamePlaylist(_ playlist: LibraryPlaylist, to name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        var updated = playlist
        updated.name = trimmed
        updated.updatedAt = .now
        try? playlistRepository.save(updated)
        loadPlaylists()
    }

    func deletePlaylist(_ playlist: LibraryPlaylist) {
        try? playlistRepository.delete(playlist)
        loadPlaylists()

        if selectedPlaylistID(for: playlist.kind) == playlist.id {
            clearPlaylistSelection(for: playlist.kind)
        }
    }

    func addItems(to playlistID: UUID, itemIDs: [UUID]) {
        guard var playlist = playlists.first(where: { $0.id == playlistID }) else { return }

        for itemID in itemIDs where !playlist.itemIDs.contains(itemID) {
            playlist.itemIDs.append(itemID)
        }

        playlist.updatedAt = .now
        try? playlistRepository.save(playlist)
        loadPlaylists()
    }

    func removeItem(from playlistID: UUID, itemID: UUID) {
        guard var playlist = playlists.first(where: { $0.id == playlistID }) else { return }
        playlist.itemIDs.removeAll { $0 == itemID }
        playlist.updatedAt = .now
        try? playlistRepository.save(playlist)
        loadPlaylists()
    }

    func reorderPlaylistItems(in playlistID: UUID, itemIDs: [UUID]) {
        guard var playlist = playlists.first(where: { $0.id == playlistID }) else { return }
        playlist.itemIDs = itemIDs
        playlist.updatedAt = .now
        try? playlistRepository.save(playlist)
        loadPlaylists()
    }

    func savePlaylist(id: UUID?, name: String, kind: LibraryPlaylistKind, itemIDs: [UUID]) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        if let id, var playlist = playlists.first(where: { $0.id == id }) {
            playlist.name = trimmed
            playlist.itemIDs = itemIDs
            playlist.updatedAt = .now
            try? playlistRepository.save(playlist)
        } else {
            var playlist = LibraryPlaylist(name: trimmed, kind: kind, itemIDs: itemIDs)
            try? playlistRepository.save(playlist)
            selectPlaylist(for: kind, id: playlist.id)
        }

        loadPlaylists()
    }

    func removeItemFromAllPlaylists(itemID: UUID, kind: LibraryPlaylistKind) {
        for playlist in playlists where playlist.kind == kind && playlist.itemIDs.contains(itemID) {
            removeItem(from: playlist.id, itemID: itemID)
        }
    }

    func filteredLyrics(searchText: String, playlistID: UUID?) -> [LyricDocument] {
        var results = lyrics

        if let playlistID,
           let playlist = playlists.first(where: { $0.id == playlistID }) {
            let allowed = Set(playlist.itemIDs)
            results = results.filter { allowed.contains($0.id) }
        }

        guard !LibrarySearch.normalize(searchText).isEmpty else {
            return results
        }

        return results.filter { $0.matchesSearch(searchText) }
    }

    func filteredMediaAssets(kind: MediaAssetKind, searchText: String, playlistID: UUID?) -> [MediaAsset] {
        let source = kind == .image ? imageAssets : videoAssets
        var results = source

        if let playlistID,
           let playlist = playlists.first(where: { $0.id == playlistID }) {
            let allowed = Set(playlist.itemIDs)
            results = results.filter { allowed.contains($0.id) }
        }

        guard !LibrarySearch.normalize(searchText).isEmpty else {
            return results
        }

        return results.filter { $0.matchesSearch(searchText) }
    }

    func playlistItemLabel(for itemID: UUID, kind: LibraryPlaylistKind) -> String {
        switch kind {
        case .lyric:
            lyrics.first { $0.id == itemID }?.title ?? "Unknown lyric"
        case .image:
            imageAssets.first { $0.id == itemID }?.listLabel ?? "Unknown image"
        case .video:
            videoAssets.first { $0.id == itemID }?.listLabel ?? "Unknown video"
        }
    }

    func playlistItemMatchesSearch(_ itemID: UUID, kind: LibraryPlaylistKind, query: String) -> Bool {
        guard !LibrarySearch.normalize(query).isEmpty else { return true }

        switch kind {
        case .lyric:
            guard let lyric = lyrics.first(where: { $0.id == itemID }) else { return false }
            return lyric.matchesSearch(query)
        case .image:
            guard let asset = imageAssets.first(where: { $0.id == itemID }) else { return false }
            return asset.matchesSearch(query)
        case .video:
            guard let asset = videoAssets.first(where: { $0.id == itemID }) else { return false }
            return asset.matchesSearch(query)
        }
    }

    func mediaAsset(for itemID: UUID, kind: LibraryPlaylistKind) -> MediaAsset? {
        switch kind {
        case .lyric: nil
        case .image: imageAssets.first { $0.id == itemID }
        case .video: videoAssets.first { $0.id == itemID }
        }
    }

    func mediaFileURL(for itemID: UUID, kind: LibraryPlaylistKind) -> URL? {
        guard let asset = mediaAsset(for: itemID, kind: kind) else { return nil }
        return mediaRepository.fileURL(for: asset)
    }

    private func selectPlaylist(for kind: LibraryPlaylistKind, id: UUID) {
        switch kind {
        case .lyric: selectedLyricPlaylistID = id
        case .image: selectedImagePlaylistID = id
        case .video: selectedVideoPlaylistID = id
        }
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
        removeItemFromAllPlaylists(itemID: lyric.id, kind: .lyric)

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
        let isReselect = selectedSlideIndex == slide.index
        selectedSlideIndex = slide.index
        if isReselect {
            slidePresentationToken += 1
        }
        showLyrics = true
    }

    func selectBackgroundMedia(_ asset: MediaAsset) {
        selectBackgroundMedia(withID: asset.id)
    }

    func selectBackgroundMedia(withID id: UUID) {
        cancelVideoControlsReveal()
        showsVideoPlaybackControls = false

        selectedBackgroundAssetID = id
        showBackground = true
        resetVideoPlaybackState()

        guard let asset = selectedBackgroundAsset else {
            videoPlayback.teardown()
            return
        }

        if asset.kind == .video, !asset.isYouTubeLink {
            videoPlaybackMode = .loop
            isVideoPlaying = true

            Task { @MainActor in
                loadSelectedVideoBackground(asset)
                scheduleVideoControlsReveal()
            }
        } else if asset.isYouTubeLink {
            videoPlaybackMode = .loop
            isVideoPlaying = true
            videoPlayback.teardown()
            youtubePlayback.resetProgress()

            Task { @MainActor in
                scheduleVideoControlsReveal()
                await refreshYouTubeTitleIfNeeded(for: asset)
            }
        } else {
            videoPlayback.teardown()
        }
    }

    func addYouTubeBackground(from link: String) {
        let trimmed = link.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = YouTubeLinkParser.normalizedURL(from: trimmed),
              YouTubeLinkParser.videoID(from: url) != nil else { return }

        do {
            let asset = try mediaRepository.importYouTubeLink(url, displayName: nil)
            videoAssets.insert(asset, at: 0)
            selectBackgroundMedia(asset)

            Task {
                await refreshYouTubeTitleIfNeeded(for: asset)
            }
        } catch {
            return
        }
    }

    private func resetVideoPlaybackState() {
        videoPlayback.teardown()
        youtubePlayback.resetProgress()
    }

    private func cancelVideoControlsReveal() {
        videoControlsRevealTask?.cancel()
        videoControlsRevealTask = nil
    }

    private func scheduleVideoControlsReveal() {
        cancelVideoControlsReveal()

        videoControlsRevealTask = Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(VideoControlsReveal.delayMilliseconds))
            guard !Task.isCancelled else { return }
            guard hasControllableVideoBackgroundSelected, showBackground else { return }

            withAnimation(GlassMorphAnimation.standard) {
                showsVideoPlaybackControls = true
            }
        }
    }

    private func loadSelectedVideoBackground(_ asset: MediaAsset) {
        let url = videoURL(for: asset)
        videoPlayback.loops = videoPlaybackMode.loopsVideo
        videoPlayback.isPlaying = isVideoPlaying
        videoPlayback.isMuted = false
        videoPlayback.load(url: url)
    }

    private func syncVideoPlaybackSettings() {
        if hasVideoBackgroundSelected {
            videoPlayback.loops = videoPlaybackMode.loopsVideo
            videoPlayback.isPlaying = isVideoPlaying
            videoPlayback.applyPlaybackSettings()
        }
        refreshExternalPresentation()
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
            let preservedSlideIndex = id == selectedLyricID ? selectedSlideIndex : nil
            if let existingIndex = lyrics.firstIndex(where: { $0.id == lyric.id }) {
                lyrics[existingIndex] = lyric
            } else {
                lyrics.insert(lyric, at: 0)
            }

            selectedLyricID = lyric.id
            let resolved = resolvedSlides(for: lyric)
            if let preservedSlideIndex, resolved.indices.contains(preservedSlideIndex) {
                selectedSlideIndex = preservedSlideIndex
                showLyrics = true
                slidePresentationToken += 1
            } else if let first = resolved.first {
                selectedSlideIndex = first.index
                showLyrics = true
            } else {
                selectedSlideIndex = nil
                showLyrics = false
            }
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
        cancelVideoControlsReveal()
        withAnimation(GlassMorphAnimation.standard) {
            selectedBackgroundAssetID = nil
            showBackground = true
            showLyrics = false
            showsVideoPlaybackControls = false
            resetVideoPlaybackState()
        }
    }

    func clearBackground() {
        cancelVideoControlsReveal()
        withAnimation(GlassMorphAnimation.standard) {
            selectedBackgroundAssetID = nil
            showBackground = true
            showsVideoPlaybackControls = false
            resetVideoPlaybackState()
        }
    }

    func clearLyrics() {
        showLyrics = false
    }

    var hasCustomBackgroundSelected: Bool {
        selectedBackgroundAssetID != nil
    }

    var hasVideoBackgroundSelected: Bool {
        guard let asset = selectedBackgroundAsset else { return false }
        return asset.kind == .video && !asset.isYouTubeLink
    }

    var hasYouTubeBackgroundSelected: Bool {
        selectedBackgroundAsset?.isYouTubeLink == true
    }

    var hasControllableVideoBackgroundSelected: Bool {
        hasVideoBackgroundSelected || hasYouTubeBackgroundSelected
    }

    private var resolvedVideoLoops: Bool {
        if hasYouTubeBackgroundSelected {
            return false
        }
        return hasControllableVideoBackgroundSelected ? videoPlaybackMode.loopsVideo : true
    }

    func toggleVideoPlaybackMode() {
        guard !hasYouTubeBackgroundSelected else { return }
        videoPlaybackMode = videoPlaybackMode.toggled
        syncVideoPlaybackSettings()
    }

    func toggleVideoPlayback() {
        isVideoPlaying.toggle()
        syncVideoPlaybackSettings()
    }

    func stopVideo() {
        isVideoPlaying = false
        if hasVideoBackgroundSelected {
            videoPlayback.stop()
        }
        if hasYouTubeBackgroundSelected {
            videoStopToken += 1
        }
        syncVideoPlaybackSettings()
    }

    func seekVideo(to time: TimeInterval) {
        if hasYouTubeBackgroundSelected {
            youtubePlayback.requestSeek(to: time)
            return
        }

        let clamped = max(0, min(time, max(videoPlayback.duration, 0)))
        videoPlayback.seek(to: clamped)
    }

    func videoDuration(for asset: MediaAsset) -> TimeInterval? {
        videoDurationByFileName[asset.fileName]
    }

    func videoDurationLabel(for asset: MediaAsset) -> String? {
        guard let duration = videoDuration(for: asset) else { return nil }
        return VideoDurationFormatter.string(for: duration)
    }

    func ensureVideoDuration(for asset: MediaAsset) async {
        if asset.isYouTubeLink {
            await refreshYouTubeTitleIfNeeded(for: asset)
            return
        }

        guard asset.kind == .video, videoDuration(for: asset) == nil else { return }

        let url = videoURL(for: asset)
        if let duration = await VideoAssetMetadataLoader.loadDuration(from: url) {
            videoDurationByFileName[asset.fileName] = duration
        }
    }

    private func refreshYouTubeTitlesIfNeeded() async {
        for asset in videoAssets where asset.isYouTubeLink {
            await refreshYouTubeTitleIfNeeded(for: asset)
        }
    }

    private func refreshYouTubeTitleIfNeeded(for asset: MediaAsset) async {
        guard asset.isYouTubeLink, shouldRefreshYouTubeTitle(asset) else { return }
        guard let url = mediaRepository.youtubeLinkURL(for: asset) else { return }
        guard let title = await YouTubeMetadataLoader.fetchTitle(for: url) else { return }
        applyYouTubeTitle(title, to: asset)
    }

    private func shouldRefreshYouTubeTitle(_ asset: MediaAsset) -> Bool {
        guard asset.isYouTubeLink else { return false }

        let label = asset.listLabel
        if label == "YouTube" { return true }

        guard label.hasPrefix("YouTube ") else { return false }
        let suffix = String(label.dropFirst("YouTube ".count))
        return YouTubeLinkParser.videoID(from: suffix) != nil
    }

    private func applyYouTubeTitle(_ title: String, to asset: MediaAsset) {
        guard let index = videoAssets.firstIndex(where: { $0.id == asset.id }) else { return }

        do {
            let updated = try mediaRepository.updateDisplayName(for: videoAssets[index], to: title)
            videoAssets[index] = updated
        } catch {
            return
        }
    }

    private func preloadVideoDurations() async {
        for asset in videoAssets {
            await ensureVideoDuration(for: asset)
        }
    }

    func toggleExternalDisplay() {
        let newValue = !externalDisplayManager.isPresentationEnabled
        externalDisplayManager.setPresentationEnabled(newValue, viewModel: self)
    }

    func refreshExternalPresentation() {
        externalDisplayManager.refreshPresentation()
    }

    var isSimplePlayConnected: Bool {
        _ = simplePlayConnectionRefreshToken
        guard !settings.isSimplePlayManualMode else { return false }
        guard let lastActivity = simplePlaySync.lastClientActivityAt else { return false }
        return Date().timeIntervalSince(lastActivity) < 12
    }

    var simplePlaySyncDisplayState: SimplePlaySyncDisplayState {
        _ = simplePlayConnectionRefreshToken
        if settings.isSimplePlayManualMode {
            return .manual
        }
        if let lastActivity = simplePlaySync.lastClientActivityAt,
           Date().timeIntervalSince(lastActivity) < 12 {
            return .connected
        }
        return .disconnected
    }

    func setSimplePlayManualMode(_ enabled: Bool) {
        settings.isSimplePlayManualMode = enabled
        saveSettings()
        simplePlayConnectionRefreshToken &+= 1
    }

    func startSimplePlaySyncService() {
        simplePlaySync.start { [weak self] message in
            guard let self else {
                return LyricPlaySyncMessage(kind: .error, errorMessage: "Lyriora is unavailable.")
            }
            return handleSimplePlaySyncMessage(message)
        }
        startSimplePlayConnectionMonitor()
    }

    private func startSimplePlayConnectionMonitor() {
        simplePlayConnectionMonitorTask?.cancel()
        simplePlayConnectionMonitorTask = Task { @MainActor in
            while !Task.isCancelled {
                simplePlayConnectionRefreshToken &+= 1
                try? await Task.sleep(for: .seconds(1))
            }
        }
    }

    private func handleSimplePlaySyncMessage(_ message: LyricPlaySyncMessage) -> LyricPlaySyncMessage {
        switch message.kind {
        case .catalogRequest:
            if let catalog = buildSimplePlayCatalog() {
                return LyricPlaySyncMessage(kind: .catalogResponse, catalog: catalog)
            }
            return LyricPlaySyncMessage(
                kind: .error,
                errorMessage: "Open a lyric in Lyriora to share its slides."
            )
        case .showSlide:
            guard let command = message.showSlide else {
                return LyricPlaySyncMessage(kind: .error, errorMessage: "Missing show slide payload.")
            }
            if !settings.isSimplePlayManualMode {
                handleRemoteShowSlide(command)
            }
            return LyricPlaySyncMessage(kind: .linkSectionAck)
        case .linkSection:
            guard let command = message.linkSection else {
                return LyricPlaySyncMessage(kind: .error, errorMessage: "Missing link section payload.")
            }
            applySimplePlaySectionLink(command)
            return LyricPlaySyncMessage(kind: .linkSectionAck)
        case .presence:
            return LyricPlaySyncMessage(kind: .presenceAck)
        default:
            return LyricPlaySyncMessage(kind: .error, errorMessage: "Unsupported sync message.")
        }
    }

    func buildSimplePlayCatalog() -> LyricSlideCatalog? {
        guard let lyric = selectedLyric else { return nil }

        let slides = lyric.slides
            .sorted { $0.order < $1.order }
            .map { slide in
                let trimmedText = slide.text.trimmingCharacters(in: .whitespacesAndNewlines)
                let preview = trimmedText
                    .components(separatedBy: .newlines)
                    .first?
                    .trimmingCharacters(in: .whitespacesAndNewlines) ?? trimmedText

                return LyricSlideCatalogItem(
                    slideID: slide.id,
                    order: slide.order,
                    preview: preview,
                    text: trimmedText,
                    tag: slide.tag.rawValue,
                    linkedSectionID: slide.simplePlaySectionID
                )
            }

        return LyricSlideCatalog(
            lyricID: lyric.id,
            lyricTitle: lyric.title,
            slides: slides
        )
    }

    func handleRemoteShowSlide(_ command: ShowSlideCommand) {
        guard let lyric = lyrics.first(where: { $0.id == command.lyricID }) else { return }
        selectLyric(lyric)
        guard let slide = lyric.slides.first(where: { $0.id == command.slideID }) else { return }
        selectSlide(slide)
        refreshExternalPresentation()
    }

    func applySimplePlaySectionLink(_ command: LinkSectionCommand) {
        guard var lyric = lyrics.first(where: { $0.id == command.lyricID }) else { return }
        guard let slideIndex = lyric.storedSlides.firstIndex(where: { $0.id == command.slideID }) else { return }

        lyric.storedSlides[slideIndex].simplePlaySectionID = command.sectionID
        if let projectID = command.projectID {
            lyric.simplePlayProjectID = projectID
            lyric.simplePlayProjectName = command.projectName
        }
        lyric.updatedAt = .now

        do {
            try lyricRepository.save(lyric)
        } catch {
            return
        }

        if let existingIndex = lyrics.firstIndex(where: { $0.id == lyric.id }) {
            lyrics[existingIndex] = lyric
        }
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
            removeItemFromAllPlaylists(itemID: asset.id, kind: .image)
        case .video:
            videoAssets.removeAll { $0.id == asset.id }
            removeItemFromAllPlaylists(itemID: asset.id, kind: .video)
        }

        if selectedBackgroundAssetID == asset.id {
            selectedBackgroundAssetID = nil
            resetVideoPlaybackState()
        }

        videoDurationByFileName.removeValue(forKey: asset.fileName)
    }

    func renameMediaAsset(_ asset: MediaAsset, to newName: String) {
        let trimmed = newName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        do {
            let updatedAsset = try mediaRepository.updateDisplayName(for: asset, to: trimmed)
            switch updatedAsset.kind {
            case .image:
                guard let index = imageAssets.firstIndex(where: { $0.id == updatedAsset.id }) else { return }
                imageAssets[index] = updatedAsset
            case .video:
                guard let index = videoAssets.firstIndex(where: { $0.id == updatedAsset.id }) else { return }
                videoAssets[index] = updatedAsset
            }
        } catch {
            return
        }
    }

    func importImageFiles(from urls: [URL]) async {
        var reservedNames = Set(imageAssets.map(\.listLabel))

        for url in urls {
            let accessed = url.startAccessingSecurityScopedResource()
            defer {
                if accessed {
                    url.stopAccessingSecurityScopedResource()
                }
            }

            do {
                let proposed = (url.lastPathComponent as NSString).deletingPathExtension
                let displayName = MediaDisplayName.resolve(
                    proposed: proposed,
                    kind: .image,
                    existingNames: reservedNames
                )
                reservedNames.insert(displayName)

                let asset = try mediaRepository.importFile(
                    from: url,
                    kind: .image,
                    displayName: displayName
                )
                imageAssets.insert(asset, at: 0)
            } catch {
                continue
            }
        }
    }

    func importVideoFiles(from urls: [URL]) async {
        var reservedNames = Set(videoAssets.map(\.listLabel))

        for url in urls {
            let accessed = url.startAccessingSecurityScopedResource()
            defer {
                if accessed {
                    url.stopAccessingSecurityScopedResource()
                }
            }

            do {
                let proposed = (url.lastPathComponent as NSString).deletingPathExtension
                let displayName = MediaDisplayName.resolve(
                    proposed: proposed,
                    kind: .video,
                    existingNames: reservedNames
                )
                reservedNames.insert(displayName)

                let asset = try mediaRepository.importFile(
                    from: url,
                    kind: .video,
                    displayName: displayName
                )
                videoAssets.insert(asset, at: 0)
                await ensureVideoDuration(for: asset)
            } catch {
                continue
            }
        }
    }

    private func importSelectedPhotos() async {
        var reservedNames = Set(imageAssets.map(\.listLabel))

        for item in selectedPhotoItems {
            let photosLibraryName = PhotosPickerDisplayNameResolver.displayName(for: item)

            do {
                if let picked = try await item.loadTransferable(type: PickedImageFile.self) {
                    let displayName = MediaDisplayName.resolve(
                        proposed: photosLibraryName ?? picked.displayName,
                        kind: .image,
                        existingNames: reservedNames
                    )
                    reservedNames.insert(displayName)

                    let asset = try mediaRepository.importFile(
                        from: picked.url,
                        kind: .image,
                        displayName: displayName
                    )
                    imageAssets.insert(asset, at: 0)
                    continue
                }

                guard let data = try await item.loadTransferable(type: Data.self) else { continue }

                let displayName = MediaDisplayName.resolve(
                    proposed: photosLibraryName,
                    kind: .image,
                    existingNames: reservedNames
                )
                reservedNames.insert(displayName)

                let asset = try mediaRepository.importData(
                    data,
                    kind: .image,
                    preferredExtension: "jpg",
                    displayName: displayName
                )
                imageAssets.insert(asset, at: 0)
            } catch {
                continue
            }
        }

        selectedPhotoItems = []
    }

    private func importSelectedVideos() async {
        var reservedNames = Set(videoAssets.map(\.listLabel))

        for item in selectedVideoItems {
            let photosLibraryName = PhotosPickerDisplayNameResolver.displayName(for: item)

            do {
                if let picked = try await item.loadTransferable(type: PickedVideoFile.self) {
                    let displayName = MediaDisplayName.resolve(
                        proposed: photosLibraryName ?? picked.displayName,
                        kind: .video,
                        existingNames: reservedNames
                    )
                    reservedNames.insert(displayName)

                    let asset = try mediaRepository.importFile(
                        from: picked.url,
                        kind: .video,
                        displayName: displayName
                    )
                    videoAssets.insert(asset, at: 0)
                    await ensureVideoDuration(for: asset)
                    continue
                }

                guard let data = try await item.loadTransferable(type: Data.self) else { continue }

                let displayName = MediaDisplayName.resolve(
                    proposed: photosLibraryName,
                    kind: .video,
                    existingNames: reservedNames
                )
                reservedNames.insert(displayName)

                let asset = try mediaRepository.importData(
                    data,
                    kind: .video,
                    preferredExtension: "mp4",
                    displayName: displayName
                )
                videoAssets.insert(asset, at: 0)
                await ensureVideoDuration(for: asset)
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

private enum VideoControlsReveal {
    static let delayMilliseconds = 450
}

private struct PickedImageFile: Transferable {
    let url: URL
    let displayName: String

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .image) { file in
            SentTransferredFile(file.url)
        } importing: { received in
            PickedImageFile(
                url: received.file,
                displayName: (received.file.lastPathComponent as NSString).deletingPathExtension
            )
        }
    }
}

private struct PickedVideoFile: Transferable {
    let url: URL
    let displayName: String

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { file in
            SentTransferredFile(file.url)
        } importing: { received in
            PickedVideoFile(
                url: received.file,
                displayName: (received.file.lastPathComponent as NSString).deletingPathExtension
            )
        }
    }
}
