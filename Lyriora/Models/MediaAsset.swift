//
//  MediaAsset.swift
//  Lyriora
//

import Foundation

enum MediaAssetKind: String, Codable, Sendable {
    case image
    case video
}

struct MediaAsset: Identifiable, Codable, Equatable, Sendable {
    let id: UUID
    let kind: MediaAssetKind
    var fileName: String
    var createdAt: Date

    init(
        id: UUID = UUID(),
        kind: MediaAssetKind,
        fileName: String,
        createdAt: Date = .now
    ) {
        self.id = id
        self.kind = kind
        self.fileName = fileName
        self.createdAt = createdAt
    }
}
