//
//  LyricDocument.swift
//  Lyriora
//

import Foundation

struct LyricDocument: Identifiable, Codable, Equatable, Sendable {
    let id: UUID
    var title: String
    var content: String
    var colorSeed: UInt64
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        colorSeed: UInt64 = UInt64.random(in: 0...UInt64.max),
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.colorSeed = colorSeed
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    var slides: [LyricSlide] {
        LyricDocument.parseSlides(from: content)
    }

    var previewSnippet: String {
        let firstSlide = slides.first?.text ?? content
        return firstSlide
            .components(separatedBy: .newlines)
            .first?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    static func parseSlides(from content: String) -> [LyricSlide] {
        let normalized = content
            .replacingOccurrences(of: "\r\n", with: "\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !normalized.isEmpty else { return [] }

        let parts = normalized
            .components(separatedBy: "\n---\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        if parts.count > 1 {
            return parts.enumerated().map { index, text in
                LyricSlide(index: index, text: text)
            }
        }

        let paragraphs = normalized
            .components(separatedBy: "\n\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        return paragraphs.enumerated().map { index, text in
            LyricSlide(index: index, text: text)
        }
    }
}
