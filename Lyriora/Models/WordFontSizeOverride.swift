//
//  WordFontSizeOverride.swift
//  Lyriora
//

import CoreGraphics
import Foundation

struct WordFontSizeOverride: Codable, Equatable, Identifiable, Sendable {
    let id: UUID
    var line: Int
    var word: Int
    var fontSize: Double

    init(
        id: UUID = UUID(),
        line: Int,
        word: Int,
        fontSize: Double
    ) {
        self.id = id
        self.line = line
        self.word = word
        self.fontSize = min(max(fontSize, 8), 240)
    }
}

enum WordFontSizeResolver {
    static func fontSize(
        for line: Int,
        word: Int,
        base: CGFloat,
        overrides: [WordFontSizeOverride]
    ) -> CGFloat {
        if let override = overrides.first(where: { $0.line == line && $0.word == word }) {
            return CGFloat(override.fontSize)
        }
        return base
    }

    static func override(
        for line: Int,
        word: Int,
        in overrides: [WordFontSizeOverride]
    ) -> WordFontSizeOverride? {
        overrides.first { $0.line == line && $0.word == word }
    }

    static func upsert(
        line: Int,
        word: Int,
        fontSize: Double,
        in overrides: inout [WordFontSizeOverride]
    ) {
        if let index = overrides.firstIndex(where: { $0.line == line && $0.word == word }) {
            overrides[index].fontSize = fontSize
        } else {
            overrides.append(WordFontSizeOverride(line: line, word: word, fontSize: fontSize))
        }
    }

    static func remove(line: Int, word: Int, from overrides: inout [WordFontSizeOverride]) {
        overrides.removeAll { $0.line == line && $0.word == word }
    }
}
