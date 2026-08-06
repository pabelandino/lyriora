//
//  MediaRepository.swift
//  Lyriora
//

import Foundation

protocol MediaRepositoryProtocol {
    func loadAll(kind: MediaAssetKind) throws -> [MediaAsset]
    func importData(_ data: Data, kind: MediaAssetKind, preferredExtension: String, displayName: String?) throws -> MediaAsset
    func importFile(from sourceURL: URL, kind: MediaAssetKind, displayName: String?) throws -> MediaAsset
    func updateDisplayName(for asset: MediaAsset, to displayName: String) throws -> MediaAsset
    func fileURL(for asset: MediaAsset) -> URL
    func delete(_ asset: MediaAsset) throws
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

            return MediaAsset(
                kind: kind,
                fileName: fileName,
                displayName: index[fileName],
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
        saveDisplayName(resolvedDisplayName, for: fileName)

        return MediaAsset(
            kind: kind,
            fileName: fileName,
            displayName: resolvedDisplayName
        )
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
        saveDisplayName(resolvedDisplayName, for: fileName)

        return MediaAsset(
            kind: kind,
            fileName: fileName,
            displayName: resolvedDisplayName
        )
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
        saveDisplayName(resolvedDisplayName, for: asset.fileName)

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

    private func loadIndex() -> [String: String] {
        guard fileManager.fileExists(atPath: indexURL.path),
              let data = try? Data(contentsOf: indexURL),
              let index = try? JSONDecoder().decode([String: String].self, from: data) else {
            return [:]
        }
        return index
    }

    private func saveDisplayName(_ displayName: String, for fileName: String) {
        var index = loadIndex()
        index[fileName] = displayName

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
