//
//  LibraryPlaylist.swift
//  Lyriora
//

import Foundation

enum LibraryPlaylistKind: String, Codable, CaseIterable, Sendable {
    case lyric
    case image
    case video

    var title: String {
        switch self {
        case .lyric: "Lyrics"
        case .image: "Images"
        case .video: "Videos"
        }
    }

    var systemImage: String {
        switch self {
        case .lyric: "append.page"
        case .image: "photo.on.rectangle.angled"
        case .video: "film.stack"
        }
    }
}

struct LibraryPlaylist: Identifiable, Codable, Equatable, Sendable {
    let id: UUID
    var name: String
    let kind: LibraryPlaylistKind
    var itemIDs: [UUID]
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        kind: LibraryPlaylistKind,
        itemIDs: [UUID] = [],
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.kind = kind
        self.itemIDs = itemIDs
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    func matchesSearch(_ query: String) -> Bool {
        LibrarySearch.matches(query, in: name)
    }
}
