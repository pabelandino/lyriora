//
//  MediaRepository.swift
//  Lyriora
//

import Foundation

protocol MediaRepositoryProtocol {
    func loadAll(kind: MediaAssetKind) throws -> [MediaAsset]
    func importData(_ data: Data, kind: MediaAssetKind, preferredExtension: String) throws -> MediaAsset
    func fileURL(for asset: MediaAsset) -> URL
    func delete(_ asset: MediaAsset) throws
}

final class MediaRepository: MediaRepositoryProtocol {
    private let fileManager: FileManager
    private let mediaDirectory: URL

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager

        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.mediaDirectory = documents.appendingPathComponent("Media", isDirectory: true)

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

        return urls.map { url in
            MediaAsset(kind: kind, fileName: url.lastPathComponent, createdAt: .now)
        }
        .sorted { $0.createdAt > $1.createdAt }
    }

    func importData(_ data: Data, kind: MediaAssetKind, preferredExtension: String) throws -> MediaAsset {
        let fileName = "\(UUID().uuidString).\(preferredExtension)"
        let destination = mediaDirectory
            .appendingPathComponent(kind.rawValue, isDirectory: true)
            .appendingPathComponent(fileName)

        try data.write(to: destination, options: .atomic)

        return MediaAsset(kind: kind, fileName: fileName)
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
    }
}
