//
//  LyricRepository.swift
//  Lyriora
//

import Foundation

protocol LyricRepositoryProtocol {
    func loadAll() throws -> [LyricDocument]
    func save(_ lyric: LyricDocument) throws
    func delete(_ lyric: LyricDocument) throws
}

final class LyricRepository: LyricRepositoryProtocol {
    private let fileManager: FileManager
    private let lyricsDirectory: URL

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager

        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.lyricsDirectory = documents.appendingPathComponent("Lyrics", isDirectory: true)

        if !fileManager.fileExists(atPath: lyricsDirectory.path) {
            try? fileManager.createDirectory(at: lyricsDirectory, withIntermediateDirectories: true)
        }
    }

    func loadAll() throws -> [LyricDocument] {
        let urls = try fileManager.contentsOfDirectory(
            at: lyricsDirectory,
            includingPropertiesForKeys: [.contentModificationDateKey],
            options: [.skipsHiddenFiles]
        )
        .filter { $0.pathExtension == "lyric" }

        let lyrics = try urls.compactMap { url -> LyricDocument? in
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(LyricDocument.self, from: data)
        }

        return lyrics.sorted { $0.updatedAt > $1.updatedAt }
    }

    func save(_ lyric: LyricDocument) throws {
        let url = fileURL(for: lyric.id)
        let data = try JSONEncoder().encode(lyric)
        try data.write(to: url, options: .atomic)
    }

    func delete(_ lyric: LyricDocument) throws {
        let url = fileURL(for: lyric.id)
        if fileManager.fileExists(atPath: url.path) {
            try fileManager.removeItem(at: url)
        }
    }

    private func fileURL(for id: UUID) -> URL {
        lyricsDirectory.appendingPathComponent("\(id.uuidString).lyric")
    }
}
