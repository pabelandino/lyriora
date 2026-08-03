//
//  LyricImportParser.swift
//  Lyriora
//

import Foundation

struct LyricImportResult: Equatable, Sendable {
    var title: String?
    var slides: [LyricSlide]
    var language: LyricLanguage
    var warnings: [String]
}

enum LyricImportError: LocalizedError, Equatable {
    case notText
    case empty
    case unsupportedContent

    var errorDescription: String? {
        switch self {
        case .notText:
            "Clipboard does not contain readable text."
        case .empty:
            "No lyrics were found in the imported content."
        case .unsupportedContent:
            "The imported content is not supported lyrics text."
        }
    }
}

enum LyricImportParser {
    static let defaultMaxLinesPerSlide = 4

    static func parse(
        _ rawText: String,
        styleProfile: LyricStyleProfile = .default,
        maxLinesPerSlide: Int? = nil
    ) -> LyricImportResult {
        let maxLines = maxLinesPerSlide ?? styleProfile.defaultStyle.maxLinesPerSlide
        let normalized = normalize(rawText)
        guard !normalized.isEmpty else {
            return LyricImportResult(title: nil, slides: [], language: .unknown, warnings: ["Empty content"])
        }

        let lines = normalized.components(separatedBy: "\n")
        var sections: [(tag: LyricSlideTag, lines: [String])] = []
        var currentTag: LyricSlideTag = .verse
        var currentLines: [String] = []
        var detectedSpanish = 0
        var detectedEnglish = 0

        func flushSection() {
            let trimmed = currentLines
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .filter { !$0.isEmpty }
            if !trimmed.isEmpty {
                sections.append((currentTag, trimmed))
            }
            currentLines = []
        }

        for line in lines {
            if let headerTag = parseSectionHeader(line) {
                flushSection()
                currentTag = headerTag
                countLanguage(headerTag, spanish: &detectedSpanish, english: &detectedEnglish)
                continue
            }

            if line.trimmingCharacters(in: .whitespaces).isEmpty {
                flushSection()
                continue
            }

            currentLines.append(line)
        }

        flushSection()

        if sections.isEmpty {
            sections = fallbackSections(from: normalized)
        }

        var slides: [LyricSlide] = []
        var order = 0

        for section in sections {
            let chunks = chunkLines(section.lines, maxLines: max(1, maxLines))
            for chunk in chunks {
                slides.append(
                    LyricSlide(
                        order: order,
                        text: chunk.joined(separator: "\n"),
                        tag: section.tag
                    )
                )
                order += 1
            }
        }

        let language = detectLanguage(
            spanishScore: detectedSpanish,
            englishScore: detectedEnglish,
            text: normalized
        )

        return LyricImportResult(
            title: inferTitle(from: normalized),
            slides: slides,
            language: language,
            warnings: slides.isEmpty ? ["No slides could be generated"] : []
        )
    }

    static func parseLegacyContent(_ content: String) -> [LyricSlide] {
        parse(content).slides
    }

    static func isLikelyText(_ text: String) -> Bool {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.count >= 2 else { return false }

        let letters = trimmed.unicodeScalars.filter { CharacterSet.letters.contains($0) }.count
        let ratio = Double(letters) / Double(trimmed.unicodeScalars.count)
        return ratio > 0.35
    }

    private static func normalize(_ text: String) -> String {
        text
            .replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func parseSectionHeader(_ line: String) -> LyricSlideTag? {
        var cleaned = line
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .trimmingCharacters(in: CharacterSet(charactersIn: "[](){}"))

        if cleaned.hasSuffix(":") {
            cleaned.removeLast()
        }

        cleaned = cleaned.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !cleaned.isEmpty, cleaned.count <= 40 else { return nil }

        let mappings: [(keys: [String], tag: LyricSlideTag)] = [
            (["intro", "introducción", "introduccion", "introduction"], .intro),
            (["verso 1", "verse 1", "v1"], .verse1),
            (["verso 2", "verse 2", "v2"], .verse2),
            (["verso 3", "verse 3", "v3"], .verse3),
            (["verso", "verse", "stanza"], .verse),
            (["pre-coro", "precoro", "pre coro", "pre-chorus", "pre chorus", "prechorus"], .preChorus),
            (["coro", "estribillo", "chorus", "refrain", "hook"], .chorus),
            (["puente", "bridge"], .bridge),
            (["tag", "coda"], .tag),
            (["outro", "final", "ending"], .outro),
            (["instrumental", "interludio", "interlude"], .instrumental)
        ]

        for mapping in mappings {
            if mapping.keys.contains(cleaned) {
                return mapping.tag
            }
        }

        if cleaned.allSatisfy({ $0.isNumber || $0.isWhitespace }) {
            return nil
        }

        return nil
    }

    private static func chunkLines(_ lines: [String], maxLines: Int) -> [[String]] {
        guard !lines.isEmpty else { return [] }

        var chunks: [[String]] = []
        var index = 0

        while index < lines.count {
            let end = min(index + maxLines, lines.count)
            chunks.append(Array(lines[index..<end]))
            index = end
        }

        return chunks
    }

    private static func fallbackSections(from text: String) -> [(tag: LyricSlideTag, lines: [String])] {
        let separatorParts = text
            .components(separatedBy: "\n---\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        if separatorParts.count > 1 {
            return separatorParts.map { part in
                let lines = part.components(separatedBy: "\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
                let tag = parseSectionHeader(lines.first ?? "") ?? .unknown
                let body = tag == .unknown ? lines : Array(lines.dropFirst())
                return (tag, body.isEmpty ? lines : body)
            }
        }

        let paragraphs = text
            .components(separatedBy: "\n\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        if paragraphs.count > 1 {
            return paragraphs.map { paragraph in
                let lines = paragraph.components(separatedBy: "\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
                let tag = parseSectionHeader(lines.first ?? "") ?? .verse
                let body = parseSectionHeader(lines.first ?? "") == nil ? lines : Array(lines.dropFirst())
                return (tag, body.isEmpty ? lines : body)
            }
        }

        let lines = text.components(separatedBy: "\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        return [(LyricSlideTag.verse, lines)]
    }

    private static func inferTitle(from text: String) -> String? {
        let firstLine = text
            .components(separatedBy: "\n")
            .first?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard !firstLine.isEmpty else { return nil }
        if parseSectionHeader(firstLine) != nil { return nil }
        if firstLine.count <= 60, !firstLine.contains(".") {
            return firstLine
        }
        return nil
    }

    private static func countLanguage(_ tag: LyricSlideTag, spanish: inout Int, english: inout Int) {
        switch tag.spanishName.lowercased() {
        case "coro", "puente", "verso", "pre-coro", "interludio":
            spanish += 1
        default:
            english += 1
        }
    }

    private static func detectLanguage(spanishScore: Int, englishScore: Int, text: String) -> LyricLanguage {
        if spanishScore > englishScore { return .spanish }
        if englishScore > spanishScore { return .english }

        let lower = text.lowercased()
        let spanishHints = [" coro", " puente", " verso", " estribillo", " precoro", " introducción"]
        let englishHints = [" chorus", " bridge", " verse", " refrain", " pre-chorus", " introduction"]

        let spanishCount = spanishHints.reduce(0) { $0 + (lower.contains($1) ? 1 : 0) }
        let englishCount = englishHints.reduce(0) { $0 + (lower.contains($1) ? 1 : 0) }

        if spanishCount > englishCount { return .spanish }
        if englishCount > spanishCount { return .english }
        return .unknown
    }
}
