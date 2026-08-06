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
    var displayName: String?
    var createdAt: Date

    init(
        id: UUID = UUID(),
        kind: MediaAssetKind,
        fileName: String,
        displayName: String? = nil,
        createdAt: Date = .now
    ) {
        self.id = id
        self.kind = kind
        self.fileName = fileName
        self.displayName = displayName
        self.createdAt = createdAt
    }

    var listLabel: String {
        let trimmedDisplayName = displayName?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let trimmedDisplayName, !trimmedDisplayName.isEmpty {
            return trimmedDisplayName
        }

        return (fileName as NSString).deletingPathExtension
    }
}
