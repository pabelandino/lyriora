//
//  BibleSearchEngine.swift
//  Lyriora
//

import Foundation

enum BibleSearchEngine {
    static func hints(
        for query: String,
        in index: BibleVersionIndex,
        searchIndex: BibleSearchIndex? = nil,
        limit: Int = 12
    ) -> [BibleSearchHint] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return [] }

        if let referenceHints = referenceHints(for: trimmed, in: index, limit: limit), !referenceHints.isEmpty {
            return referenceHints
        }

        if let searchIndex {
            return searchIndex.textHints(for: trimmed, limit: limit)
        }

        return textHints(for: trimmed, in: index, limit: limit)
    }

    static func referenceHints(
        for query: String,
        in index: BibleVersionIndex,
        limit: Int
    ) -> [BibleSearchHint]? {
        guard let parsed = parseReference(query) else { return nil }

        var hints: [BibleSearchHint] = []

        if let verse = parsed.verse {
            if let text = verseText(
                bookNumber: parsed.bookNumber,
                chapter: parsed.chapter,
                verse: verse,
                in: index
            ) {
                let label = parsed.book.formattedReference(
                    chapter: parsed.chapter,
                    verse: verse,
                    preferSpanish: true
                )
                hints.append(
                    BibleSearchHint(
                        title: label,
                        subtitle: preview(text),
                        kind: .reference(bookNumber: parsed.bookNumber, chapter: parsed.chapter, verse: verse)
                    )
                )
            }

            let chapterLabel = parsed.book.formattedReference(chapter: parsed.chapter, preferSpanish: true)
            hints.append(
                BibleSearchHint(
                    title: chapterLabel,
                    subtitle: "Whole chapter",
                    kind: .reference(bookNumber: parsed.bookNumber, chapter: parsed.chapter, verse: nil)
                )
            )
        } else {
            let chapterLabel = parsed.book.formattedReference(chapter: parsed.chapter, preferSpanish: true)
            let verseCount = index.book(parsed.bookNumber)?.chapter(parsed.chapter)?.verseCount ?? 0
            hints.append(
                BibleSearchHint(
                    title: chapterLabel,
                    subtitle: verseCount > 0 ? "\(verseCount) verses" : nil,
                    kind: .reference(bookNumber: parsed.bookNumber, chapter: parsed.chapter, verse: nil)
                )
            )

            if let firstVerse = index.book(parsed.bookNumber)?.chapter(parsed.chapter)?.verses.first {
                hints.append(
                    BibleSearchHint(
                        title: parsed.book.formattedReference(
                            chapter: parsed.chapter,
                            verse: firstVerse.number,
                            preferSpanish: true
                        ),
                        subtitle: preview(firstVerse.text),
                        kind: .reference(
                            bookNumber: parsed.bookNumber,
                            chapter: parsed.chapter,
                            verse: firstVerse.number
                        )
                    )
                )
            }
        }

        return Array(hints.prefix(limit))
    }

    private static func textHints(for query: String, in index: BibleVersionIndex, limit: Int) -> [BibleSearchHint] {
        let normalizedQuery = BibleBookCatalog.normalize(query)
        guard normalizedQuery.count >= 3 else { return [] }

        var matches: [(score: Int, hint: BibleSearchHint)] = []

        for book in index.books {
            guard let bookInfo = BibleBookCatalog.book(number: book.number) else { continue }
            for chapter in book.chapters {
                for verse in chapter.verses {
                    let normalizedText = BibleBookCatalog.normalize(verse.text)
                    guard normalizedText.contains(normalizedQuery) else { continue }

                    let location = BibleVerseLocation(
                        bookNumber: book.number,
                        chapter: chapter.number,
                        verse: verse.number
                    )
                    let title = bookInfo.formattedReference(
                        chapter: chapter.number,
                        verse: verse.number,
                        preferSpanish: true
                    )
                    let snippet = highlightedSnippet(in: verse.text, matching: query)
                    let score = snippetScore(normalizedText: normalizedText, query: normalizedQuery)

                    matches.append(
                        (
                            score,
                            BibleSearchHint(
                                title: title,
                                subtitle: snippet,
                                kind: .textMatch(location: location, snippet: snippet)
                            )
                        )
                    )
                }
            }
        }

        return matches
            .sorted { lhs, rhs in
                if lhs.score != rhs.score { return lhs.score > rhs.score }
                return lhs.hint.title < rhs.hint.title
            }
            .prefix(limit)
            .map(\.hint)
    }

    static func parseReference(_ query: String) -> (book: BibleBookInfo, bookNumber: Int, chapter: Int, verse: Int?)? {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }

        let pattern = #"^(\d?\s*[\p{L}\.'\s]+?)\s+(\d+)\s*(?::\s*(\d+))?\s*$"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) else {
            return nil
        }

        let range = NSRange(trimmed.startIndex..<trimmed.endIndex, in: trimmed)
        guard let match = regex.firstMatch(in: trimmed, options: [], range: range),
              match.numberOfRanges >= 3,
              let bookRange = Range(match.range(at: 1), in: trimmed),
              let chapterRange = Range(match.range(at: 2), in: trimmed) else {
            return nil
        }

        let bookPart = String(trimmed[bookRange]).trimmingCharacters(in: .whitespacesAndNewlines)
        guard let book = BibleBookCatalog.matchBook(in: bookPart) else { return nil }

        guard let chapter = Int(trimmed[chapterRange]), chapter >= 1, chapter <= book.chapterCount else {
            return nil
        }

        var verse: Int?
        if match.numberOfRanges >= 4,
           match.range(at: 3).location != NSNotFound,
           let verseRange = Range(match.range(at: 3), in: trimmed) {
            verse = Int(trimmed[verseRange])
        }

        return (book, book.number, chapter, verse)
    }

    static func verseText(
        bookNumber: Int,
        chapter: Int,
        verse: Int,
        in index: BibleVersionIndex
    ) -> String? {
        index.book(bookNumber)?
            .chapter(chapter)?
            .verses
            .first(where: { $0.number == verse })?
            .text
    }

    static func verses(
        bookNumber: Int,
        chapter: Int,
        startingAt verse: Int?,
        in index: BibleVersionIndex
    ) -> [BibleVerseIndex] {
        guard let chapterIndex = index.book(bookNumber)?.chapter(chapter) else { return [] }
        let sorted = chapterIndex.verses.sorted { $0.number < $1.number }
        guard let verse else { return sorted }
        return sorted.filter { $0.number >= verse }
    }

    private static func preview(_ text: String, maxLength: Int = 96) -> String {
        let collapsed = text
            .replacingOccurrences(of: "\n", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        guard collapsed.count > maxLength else { return collapsed }
        return String(collapsed.prefix(maxLength - 1)) + "…"
    }

    private static func highlightedSnippet(in text: String, matching query: String) -> String {
        snippet(in: text, matching: query)
    }

    static func snippet(in text: String, matching query: String) -> String {
        let normalizedText = BibleBookCatalog.normalize(text)
        let normalizedQuery = BibleBookCatalog.normalize(query)
        guard let range = normalizedText.range(of: normalizedQuery) else {
            return preview(text)
        }

        let startOffset = normalizedText.distance(from: normalizedText.startIndex, to: range.lowerBound)
        let start = text.index(text.startIndex, offsetBy: min(startOffset, text.count))
        let prefixLength = 40
        let snippetStart = text.index(
            start,
            offsetBy: -min(prefixLength, text.distance(from: text.startIndex, to: start)),
            limitedBy: text.startIndex
        ) ?? text.startIndex

        var snippet = String(text[snippetStart...]).trimmingCharacters(in: .whitespacesAndNewlines)
        if snippetStart != text.startIndex {
            snippet = "…" + snippet
        }
        return preview(snippet, maxLength: 120)
    }

    static func snippetScore(normalizedText: String, query: String) -> Int {
        if normalizedText.hasPrefix(query) { return 100 }
        if normalizedText.contains(" \(query)") { return 80 }
        return 60
    }
}
