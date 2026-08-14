//
//  LyricPlaySyncProtocol.swift
//  Lyriora
//
//  Shared wire format with SimplePlay (keep both copies in sync).
//

import Foundation

enum LyricPlaySync {
    static let bonjourType = "_lyriora-sync._tcp"
    static let bonjourDomain = "local."
    static let serviceName = "Lyriora"
}

enum LyricPlaySyncMessageKind: String, Codable, Sendable {
    case catalogRequest
    case catalogResponse
    case showSlide
    case linkSection
    case linkSectionAck
    case presence
    case presenceAck
    case error
}

struct LyricPlaySyncMessage: Codable, Sendable {
    var kind: LyricPlaySyncMessageKind
    var catalog: LyricSlideCatalog?
    var showSlide: ShowSlideCommand?
    var linkSection: LinkSectionCommand?
    var errorMessage: String?
}

struct LyricSlideCatalog: Codable, Sendable {
    var lyricID: UUID
    var lyricTitle: String
    var slides: [LyricSlideCatalogItem]
}

struct LyricSlideCatalogItem: Codable, Sendable, Identifiable, Hashable {
    var id: UUID { slideID }
    let slideID: UUID
    let order: Int
    let preview: String
    let tag: String
    var linkedSectionID: UUID?
}

struct ShowSlideCommand: Codable, Sendable {
    let lyricID: UUID
    let slideID: UUID
    let sectionID: UUID?
    let projectID: UUID?
}

struct LinkSectionCommand: Codable, Sendable {
    let lyricID: UUID
    let slideID: UUID
    let sectionID: UUID
    let projectID: UUID?
    let projectName: String?
}

enum LyricPlaySyncCodec {
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        return encoder
    }()

    private static let decoder = JSONDecoder()

    static func encode(_ message: LyricPlaySyncMessage) throws -> Data {
        var payload = try encoder.encode(message)
        payload.append(0x0A)
        return payload
    }

    static func decode(_ data: Data) throws -> LyricPlaySyncMessage {
        guard var string = String(data: data, encoding: .utf8) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid UTF-8 payload."))
        }
        string = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return try decoder.decode(LyricPlaySyncMessage.self, from: Data(string.utf8))
    }
}
