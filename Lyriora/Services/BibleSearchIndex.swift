//
//  BibleSearchIndex.swift
//  Lyriora
//

import Foundation

struct BibleSearchIndexEntry: Sendable {
    let location: BibleVerseLocation
    let referenceTitle: String
    let normalizedText: String
    let originalText: String
}

struct BibleSearchIndex: Sendable {
    let entries: [BibleSearchIndexEntry]

    static func build(from index: BibleVersionIndex) -> BibleSearchIndex {
        var entries: [BibleSearchIndexEntry] = []
        entries.reserveCapacity(estimatedVerseCount(in: index))

        for book in index.books {
            guard let bookInfo = BibleBookCatalog.book(number: book.number) else { continue }
            for chapter in book.chapters {
                for verse in chapter.verses {
                    entries.append(
                        BibleSearchIndexEntry(
                            location: BibleVerseLocation(
                                bookNumber: book.number,
                                chapter: chapter.number,
                                verse: verse.number
                            ),
                            referenceTitle: bookInfo.formattedReference(
                                chapter: chapter.number,
                                verse: verse.number,
                                preferSpanish: true
                            ),
                            normalizedText: BibleBookCatalog.normalize(verse.text),
                            originalText: verse.text
                        )
                    )
                }
            }
        }

        return BibleSearchIndex(entries: entries)
    }

    func textHints(for query: String, limit: Int = 12) -> [BibleSearchHint] {
        let normalizedQuery = BibleBookCatalog.normalize(query)
        guard normalizedQuery.count >= 3 else { return [] }

        var matches: [(score: Int, hint: BibleSearchHint)] = []
        matches.reserveCapacity(limit)

        for entry in entries {
            guard entry.normalizedText.contains(normalizedQuery) else { continue }

            let snippet = BibleSearchEngine.snippet(in: entry.originalText, matching: query)
            let score = BibleSearchEngine.snippetScore(
                normalizedText: entry.normalizedText,
                query: normalizedQuery
            )

            matches.append(
                (
                    score,
                    BibleSearchHint(
                        title: entry.referenceTitle,
                        subtitle: snippet,
                        kind: .textMatch(location: entry.location, snippet: snippet)
                    )
                )
            )

            if matches.count >= limit * 4 {
                trimMatches(&matches, limit: limit)
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

    private static func estimatedVerseCount(in index: BibleVersionIndex) -> Int {
        index.books.reduce(0) { partial, book in
            partial + book.chapters.reduce(0) { $0 + $1.verses.count }
        }
    }

    private func trimMatches(_ matches: inout [(score: Int, hint: BibleSearchHint)], limit: Int) {
        matches.sort { lhs, rhs in
            if lhs.score != rhs.score { return lhs.score > rhs.score }
            return lhs.hint.title < rhs.hint.title
        }
        if matches.count > limit * 2 {
            matches = Array(matches.prefix(limit * 2))
        }
    }
}
