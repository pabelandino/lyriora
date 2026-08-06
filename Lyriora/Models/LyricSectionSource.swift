//
//  LyricSectionSource.swift
//  Lyriora
//

import Foundation

/// Canonical lyric section before slide line-chunking (Coro, Verso, Puente, etc.).
struct LyricSectionSource: Identifiable, Codable, Equatable, Sendable {
    let id: UUID
    var tag: LyricSlideTag
    var lines: [String]

    init(id: UUID = UUID(), tag: LyricSlideTag, lines: [String]) {
        self.id = id
        self.tag = tag
        self.lines = lines
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
    }
}
