//
//  SlideTextTokenizer.swift
//  Lyriora
//

import Foundation

struct ParsedSlideText: Equatable, Sendable {
    let lines: [[String]]
    let paragraphLineRanges: [Range<Int>]

    var isEmpty: Bool {
        lines.allSatisfy(\.isEmpty)
    }

    func paragraphIndex(forLine lineIndex: Int) -> Int {
        paragraphLineRanges.firstIndex { $0.contains(lineIndex) } ?? 0
    }

    var totalWordCount: Int {
        lines.reduce(0) { $0 + $1.count }
    }

    func globalWordIndex(lineIndex: Int, wordIndex: Int) -> Int {
        guard lines.indices.contains(lineIndex) else { return wordIndex }
        let preceding = lines.prefix(lineIndex).reduce(0) { $0 + $1.count }
        return preceding + wordIndex
    }

    func paragraphWordIndex(lineIndex: Int, wordIndex: Int, paragraphIndex: Int) -> Int {
        guard paragraphLineRanges.indices.contains(paragraphIndex) else { return wordIndex }
        let range = paragraphLineRanges[paragraphIndex]
        var count = 0
        for line in range {
            if line == lineIndex {
                return count + wordIndex
            }
            count += lines[line].count
        }
        return count + wordIndex
    }

    func wordCount(inParagraph paragraphIndex: Int) -> Int {
        guard paragraphLineRanges.indices.contains(paragraphIndex) else { return totalWordCount }
        return paragraphLineRanges[paragraphIndex].reduce(0) { $0 + lines[$1].count }
    }

    func words(inLine lineIndex: Int) -> [String] {
        guard lines.indices.contains(lineIndex) else { return [] }
        return lines[lineIndex]
    }
}

enum SlideTextTokenizer {
    static func parse(_ text: String) -> ParsedSlideText {
        let rawLines = PresentationTextMeasurer.explicitLines(from: text)
        let lines = rawLines.map(tokenizeLine)

        var paragraphLineRanges: [Range<Int>] = []
        var paragraphStart = 0

        for (index, line) in rawLines.enumerated() {
            let isBlank = line.trimmingCharacters(in: .whitespaces).isEmpty
            if isBlank {
                if index > paragraphStart {
                    paragraphLineRanges.append(paragraphStart..<index)
                }
                paragraphStart = index + 1
            }
        }

        if paragraphStart < rawLines.count {
            paragraphLineRanges.append(paragraphStart..<rawLines.count)
        }

        if paragraphLineRanges.isEmpty, !rawLines.isEmpty {
            paragraphLineRanges = [0..<rawLines.count]
        }

        return ParsedSlideText(lines: lines, paragraphLineRanges: paragraphLineRanges)
    }

    static func tokenizeLine(_ line: String) -> [String] {
        let trimmed = line.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return [] }

        return trimmed
            .split(whereSeparator: \.isWhitespace)
            .map(String.init)
    }
}

enum TextAnimationSelectionResolver {
    static func escalateSelection(
        current: TextAnimationTarget?,
        tappedLine: Int,
        tappedWord: Int,
        parsed: ParsedSlideText
    ) -> TextAnimationTarget {
        let wordTarget = TextAnimationTarget.word(line: tappedLine, word: tappedWord)
        let lineTarget = TextAnimationTarget.line(tappedLine)
        let paragraphTarget = TextAnimationTarget.paragraph(parsed.paragraphIndex(forLine: tappedLine))

        guard let current else { return wordTarget }

        switch current {
        case .word(let line, let word) where line == tappedLine && word == tappedWord:
            return lineTarget
        case .line(let line) where line == tappedLine:
            return paragraphTarget
        case .paragraph(let index) where parsed.paragraphIndex(forLine: tappedLine) == index:
            return .all
        case .all:
            return wordTarget
        default:
            return wordTarget
        }
    }

    static func matches(
        target: TextAnimationTarget,
        lineIndex: Int,
        wordIndex: Int,
        parsed: ParsedSlideText
    ) -> Bool {
        switch target {
        case .all:
            true
        case .paragraph(let index):
            parsed.paragraphIndex(forLine: lineIndex) == index
        case .line(let index):
            index == lineIndex
        case .word(let line, let word):
            line == lineIndex && word == wordIndex
        }
    }
}
