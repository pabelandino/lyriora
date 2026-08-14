//
//  PlaylistRepository.swift
//  Lyriora
//

import Foundation

protocol PlaylistRepositoryProtocol {
    func loadAll() throws -> [LibraryPlaylist]
    func save(_ playlist: LibraryPlaylist) throws
    func delete(_ playlist: LibraryPlaylist) throws
}

final class PlaylistRepository: PlaylistRepositoryProtocol {
    private let fileManager: FileManager
    private let playlistsURL: URL

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager

        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directory = documents.appendingPathComponent("Playlists", isDirectory: true)

        if !fileManager.fileExists(atPath: directory.path) {
            try? fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
        }

        self.playlistsURL = directory.appendingPathComponent("playlists.json")
    }

    func loadAll() throws -> [LibraryPlaylist] {
        guard fileManager.fileExists(atPath: playlistsURL.path) else {
            return []
        }

        let data = try Data(contentsOf: playlistsURL)
        let playlists = try JSONDecoder().decode([LibraryPlaylist].self, from: data)
        return playlists.sorted { $0.updatedAt > $1.updatedAt }
    }

    func save(_ playlist: LibraryPlaylist) throws {
        var playlists = (try? loadAll()) ?? []

        if let index = playlists.firstIndex(where: { $0.id == playlist.id }) {
            playlists[index] = playlist
        } else {
            playlists.insert(playlist, at: 0)
        }

        let data = try JSONEncoder().encode(playlists)
        try data.write(to: playlistsURL, options: .atomic)
    }

    func delete(_ playlist: LibraryPlaylist) throws {
        var playlists = try loadAll()
        playlists.removeAll { $0.id == playlist.id }
        let data = try JSONEncoder().encode(playlists)
        try data.write(to: playlistsURL, options: .atomic)
    }
}
