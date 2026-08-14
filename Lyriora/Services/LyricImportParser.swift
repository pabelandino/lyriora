//
//  LyricImportParser.swift
//  Lyriora
//

import Foundation

struct LyricImportResult: Equatable, Sendable {
    var title: String?
    var sections: [LyricSectionSource]
    var slides: [LyricSlide]
    var language: LyricLanguage
    var warnings: [String]
}

struct LyricSectionParseResult: Equatable, Sendable {
    var title: String?
    var sections: [LyricSectionSource]
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
        let sectionResult = parseSections(rawText)
        let slides = LyricSlideLayoutEngine.makeSlides(
            from: sectionResult.sections,
            style: styleProfile.defaultStyle
        )

        return LyricImportResult(
            title: sectionResult.title,
            sections: sectionResult.sections,
            slides: slides,
            language: sectionResult.language,
            warnings: sectionResult.warnings.isEmpty && slides.isEmpty
                ? ["No slides could be generated"]
                : sectionResult.warnings
        )
    }

    static func parseSections(_ rawText: String) -> LyricSectionParseResult {
        let normalized = normalize(rawText)
        guard !normalized.isEmpty else {
            return LyricSectionParseResult(
                title: nil,
                sections: [],
                language: .unknown,
                warnings: ["Empty content"]
            )
        }

        let parsedSections = extractSections(from: normalized)
        let sections = parsedSections.sections.map { item in
            LyricSectionSource(tag: item.tag, lines: item.lines)
        }

        let language = detectLanguage(
            spanishScore: parsedSections.spanishScore,
            englishScore: parsedSections.englishScore,
            text: normalized
        )

        return LyricSectionParseResult(
            title: inferTitle(from: normalized),
            sections: sections,
            language: language,
            warnings: sections.isEmpty ? ["No slides could be generated"] : []
        )
    }

    static func makeSlides(
        from sections: [LyricSectionSource],
        style: SlideTextStyle,
        containerSize: CGSize = PresentationLayout.referenceCanvasSize
    ) -> [LyricSlide] {
        LyricSlideLayoutEngine.makeSlides(
            from: sections,
            style: style,
            containerSize: containerSize
        )
    }

    /// Legacy helper kept for callers that only know the configured max-lines value.
    static func makeSlides(from sections: [LyricSectionSource], maxLines: Int) -> [LyricSlide] {
        var style = SlideTextStyle.default
        style.maxLinesPerSlide = maxLines
        style.minFontSize = style.maxFontSize
        return makeSlides(from: sections, style: style)
    }

    static func rawText(from sections: [LyricSectionSource], language: LyricLanguage) -> String {
        sections.map { section in
            let header = section.tag.localizedName(for: language)
            return "\(header)\n\(section.lines.joined(separator: "\n"))"
        }
        .joined(separator: "\n\n")
    }

    /// Rebuilds canonical sections by merging consecutive slide chunks that share a section ID.
    static func sections(from slides: [LyricSlide]) -> [LyricSectionSource] {
        var sections: [LyricSectionSource] = []
        var sectionOrder: [UUID] = []
        var sectionLines: [UUID: [String]] = [:]
        var sectionTags: [UUID: LyricSlideTag] = [:]

        for slide in slides.sorted(by: { $0.order < $1.order }) {
            let sectionID = slide.sourceSectionID ?? slide.id
            let slideLines = lines(from: slide.text)

            if sectionLines[sectionID] == nil {
                sectionOrder.append(sectionID)
                sectionTags[sectionID] = slide.tag
                sectionLines[sectionID] = slideLines
            } else if sectionTags[sectionID] == slide.tag {
                sectionLines[sectionID, default: []].append(contentsOf: slideLines)
            } else {
                let newID = UUID()
                sectionOrder.append(newID)
                sectionTags[newID] = slide.tag
                sectionLines[newID] = slideLines
            }
        }

        return sectionOrder.compactMap { id in
            guard let tag = sectionTags[id], let lines = sectionLines[id], !lines.isEmpty else {
                return nil
            }
            return LyricSectionSource(id: id, tag: tag, lines: lines)
        }
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

    static func lines(from text: String) -> [String] {
        normalizedLineBreaks(text)
            .components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
    }

    /// Converts platform-specific and web clipboard line breaks into `\n`.
    static func normalizedLineBreaks(_ text: String) -> String {
        text
            .replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
            .replacingOccurrences(of: "\u{2028}", with: "\n")
            .replacingOccurrences(of: "\u{2029}", with: "\n\n")
            .replacingOccurrences(of: "\u{0085}", with: "\n")
            .replacingOccurrences(of: "\u{000B}", with: "\n")
            .replacingOccurrences(of: "\u{000C}", with: "\n")
    }

    private struct ParsedSections {
        var sections: [(tag: LyricSlideTag, lines: [String])]
        var spanishScore: Int
        var englishScore: Int
    }

    private static func extractSections(from normalized: String) -> ParsedSections {
        let lines = normalized.components(separatedBy: "\n")
        var sections: [(tag: LyricSlideTag, lines: [String])] = []
        var currentTag: LyricSlideTag = .verse
        var currentLines: [String] = []
        var detectedSpanish = 0
        var detectedEnglish = 0

        func flushSection() {
            let trimmed = Self.lines(from: currentLines.joined(separator: "\n"))
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

        return ParsedSections(
            sections: sections,
            spanishScore: detectedSpanish,
            englishScore: detectedEnglish
        )
    }

    private static func normalize(_ text: String) -> String {
        normalizedLineBreaks(text)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func parseSectionHeader(_ line: String) -> LyricSlideTag? {
        var cleaned = line
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .trimmingCharacters(in: CharacterSet(charactersIn: "[](){}"))
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if cleaned.hasSuffix(":") {
            cleaned.removeLast()
            cleaned = cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        let lowered = cleaned.lowercased()
        guard !lowered.isEmpty, lowered.count <= 40 else { return nil }

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
            if mapping.keys.contains(lowered) {
                return mapping.tag
            }
        }

        if lowered.allSatisfy({ $0.isNumber || $0.isWhitespace }) {
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
                let partLines = part.components(separatedBy: "\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
                let tag = parseSectionHeader(partLines.first ?? "") ?? .unknown
                let body = tag == .unknown ? partLines : Array(partLines.dropFirst())
                return (tag, body.isEmpty ? partLines : body)
            }
        }

        let paragraphs = text
            .components(separatedBy: "\n\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        if paragraphs.count > 1 {
            return paragraphs.map { paragraph in
                let partLines = paragraph.components(separatedBy: "\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
                let tag = parseSectionHeader(partLines.first ?? "") ?? .verse
                let body = parseSectionHeader(partLines.first ?? "") == nil ? partLines : Array(partLines.dropFirst())
                return (tag, body.isEmpty ? partLines : body)
            }
        }

        let allLines = text.components(separatedBy: "\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        return [(LyricSlideTag.verse, allLines)]
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
