//
//  MediaRepository.swift
//  Lyriora
//

import Foundation

protocol MediaRepositoryProtocol {
    func loadAll(kind: MediaAssetKind) throws -> [MediaAsset]
    func importData(_ data: Data, kind: MediaAssetKind, preferredExtension: String, displayName: String?) throws -> MediaAsset
    func importFile(from sourceURL: URL, kind: MediaAssetKind, displayName: String?) throws -> MediaAsset
    func importYouTubeLink(_ url: URL, displayName: String?) throws -> MediaAsset
    func youtubeLinkURL(for asset: MediaAsset) -> URL?
    func updateDisplayName(for asset: MediaAsset, to displayName: String) throws -> MediaAsset
    func fileURL(for asset: MediaAsset) -> URL
    func delete(_ asset: MediaAsset) throws
}

private struct MediaIndexEntry: Codable {
    var displayName: String?
    var assetID: UUID?
}

final class MediaRepository: MediaRepositoryProtocol {
    private let fileManager: FileManager
    private let mediaDirectory: URL
    private let indexURL: URL

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager

        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.mediaDirectory = documents.appendingPathComponent("Media", isDirectory: true)
        self.indexURL = mediaDirectory.appendingPathComponent("index.json")

        for kind in [MediaAssetKind.image, .video] {
            let folder = mediaDirectory.appendingPathComponent(kind.rawValue, isDirectory: true)
            if !fileManager.fileExists(atPath: folder.path) {
                try? fileManager.createDirectory(at: folder, withIntermediateDirectories: true)
            }
        }
    }

    func loadAll(kind: MediaAssetKind) throws -> [MediaAsset] {
        let folder = mediaDirectory.appendingPathComponent(kind.rawValue, isDirectory: true)
        let urls = try fileManager.contentsOfDirectory(
            at: folder,
            includingPropertiesForKeys: [.creationDateKey],
            options: [.skipsHiddenFiles]
        )
        let index = loadIndex()

        return urls.map { url in
            let fileName = url.lastPathComponent
            let createdAt = (try? url.resourceValues(forKeys: [.creationDateKey]).creationDate) ?? .now
            let entry = index[fileName]
            let assetID = entry?.assetID ?? UUID()

            if entry?.assetID == nil {
                saveIndexEntry(
                    MediaIndexEntry(displayName: entry?.displayName, assetID: assetID),
                    for: fileName
                )
            }

            return MediaAsset(
                id: assetID,
                kind: kind,
                fileName: fileName,
                displayName: entry?.displayName,
                createdAt: createdAt
            )
        }
        .sorted { $0.createdAt > $1.createdAt }
    }

    func importData(
        _ data: Data,
        kind: MediaAssetKind,
        preferredExtension: String,
        displayName: String? = nil
    ) throws -> MediaAsset {
        let fileName = "\(UUID().uuidString).\(preferredExtension)"
        let destination = mediaDirectory
            .appendingPathComponent(kind.rawValue, isDirectory: true)
            .appendingPathComponent(fileName)

        try data.write(to: destination, options: .atomic)

        let resolvedDisplayName = sanitizedDisplayName(displayName, fallbackFileName: fileName)
        let asset = MediaAsset(
            kind: kind,
            fileName: fileName,
            displayName: resolvedDisplayName
        )
        saveIndexEntry(
            MediaIndexEntry(displayName: resolvedDisplayName, assetID: asset.id),
            for: fileName
        )

        return asset
    }

    func importFile(from sourceURL: URL, kind: MediaAssetKind, displayName: String? = nil) throws -> MediaAsset {
        let preferredExtension = sourceURL.pathExtension.isEmpty
            ? defaultExtension(for: kind)
            : sourceURL.pathExtension
        let fileName = "\(UUID().uuidString).\(preferredExtension)"
        let destination = mediaDirectory
            .appendingPathComponent(kind.rawValue, isDirectory: true)
            .appendingPathComponent(fileName)

        if fileManager.fileExists(atPath: destination.path) {
            try fileManager.removeItem(at: destination)
        }

        try fileManager.copyItem(at: sourceURL, to: destination)

        let fallbackName = (sourceURL.lastPathComponent as NSString).deletingPathExtension
        let resolvedDisplayName = sanitizedDisplayName(displayName ?? fallbackName, fallbackFileName: fileName)
        let asset = MediaAsset(
            kind: kind,
            fileName: fileName,
            displayName: resolvedDisplayName
        )
        saveIndexEntry(
            MediaIndexEntry(displayName: resolvedDisplayName, assetID: asset.id),
            for: fileName
        )

        return asset
    }

    func importYouTubeLink(_ url: URL, displayName: String? = nil) throws -> MediaAsset {
        guard YouTubeLinkParser.videoID(from: url) != nil else {
            throw MediaRepositoryError.invalidYouTubeLink
        }

        let fileName = "\(UUID().uuidString).ytlink"
        let destination = mediaDirectory
            .appendingPathComponent(MediaAssetKind.video.rawValue, isDirectory: true)
            .appendingPathComponent(fileName)

        try url.absoluteString.write(to: destination, atomically: true, encoding: .utf8)

        let resolvedDisplayName = sanitizedDisplayName(displayName, fallbackFileName: "YouTube")
        let asset = MediaAsset(
            kind: .video,
            fileName: fileName,
            displayName: resolvedDisplayName
        )
        saveIndexEntry(
            MediaIndexEntry(displayName: resolvedDisplayName, assetID: asset.id),
            for: fileName
        )

        return asset
    }

    func youtubeLinkURL(for asset: MediaAsset) -> URL? {
        guard asset.isYouTubeLink else { return nil }
        let fileURL = fileURL(for: asset)
        guard let raw = try? String(contentsOf: fileURL, encoding: .utf8) else { return nil }
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        return YouTubeLinkParser.normalizedURL(from: trimmed)
    }

    func fileURL(for asset: MediaAsset) -> URL {
        mediaDirectory
            .appendingPathComponent(asset.kind.rawValue, isDirectory: true)
            .appendingPathComponent(asset.fileName)
    }

    func delete(_ asset: MediaAsset) throws {
        let url = fileURL(for: asset)
        if fileManager.fileExists(atPath: url.path) {
            try fileManager.removeItem(at: url)
        }
        removeDisplayName(for: asset.fileName)
    }

    func updateDisplayName(for asset: MediaAsset, to displayName: String) throws -> MediaAsset {
        let resolvedDisplayName = sanitizedDisplayName(displayName, fallbackFileName: asset.fileName)
        var entry = loadIndex()[asset.fileName] ?? MediaIndexEntry(assetID: asset.id)
        entry.displayName = resolvedDisplayName
        entry.assetID = asset.id
        saveIndexEntry(entry, for: asset.fileName)

        var updatedAsset = asset
        updatedAsset.displayName = resolvedDisplayName
        return updatedAsset
    }

    private func defaultExtension(for kind: MediaAssetKind) -> String {
        switch kind {
        case .image: "jpg"
        case .video: "mp4"
        }
    }

    private func sanitizedDisplayName(_ displayName: String?, fallbackFileName: String) -> String {
        let trimmed = displayName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !trimmed.isEmpty, !MediaDisplayName.looksLikeGeneratedIdentifier(trimmed) {
            return trimmed
        }

        let fallback = (fallbackFileName as NSString).deletingPathExtension
        if !MediaDisplayName.looksLikeGeneratedIdentifier(fallback) {
            return fallback
        }

        return trimmed.isEmpty ? fallback : trimmed
    }

    private func loadIndex() -> [String: MediaIndexEntry] {
        guard fileManager.fileExists(atPath: indexURL.path),
              let data = try? Data(contentsOf: indexURL) else {
            return [:]
        }

        if let index = try? JSONDecoder().decode([String: MediaIndexEntry].self, from: data) {
            return index
        }

        if let legacyIndex = try? JSONDecoder().decode([String: String].self, from: data) {
            return legacyIndex.mapValues { MediaIndexEntry(displayName: $0, assetID: nil) }
        }

        return [:]
    }

    private func saveIndexEntry(_ entry: MediaIndexEntry, for fileName: String) {
        var index = loadIndex()
        index[fileName] = entry

        guard let data = try? JSONEncoder().encode(index) else { return }
        try? data.write(to: indexURL, options: .atomic)
    }

    private func removeDisplayName(for fileName: String) {
        var index = loadIndex()
        index.removeValue(forKey: fileName)

        guard let data = try? JSONEncoder().encode(index) else { return }
        try? data.write(to: indexURL, options: .atomic)
    }
}

enum MediaRepositoryError: Error {
    case invalidYouTubeLink
}
