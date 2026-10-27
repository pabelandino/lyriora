//
//  LibrarySearch.swift
//  Lyriora
//

import Foundation

enum LibrarySearch {
    static func matches(_ query: String, in text: String) -> Bool {
        let normalizedQuery = normalize(query)
        guard !normalizedQuery.isEmpty else { return true }

        let normalizedText = normalize(text)
        return normalizedText.contains(normalizedQuery)
    }

    static func normalize(_ text: String) -> String {
        text
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    static func queryWords(_ query: String) -> [String] {
        normalize(query)
            .split(whereSeparator: \.isWhitespace)
            .map(String.init)
            .filter { !$0.isEmpty }
    }
}

extension MediaAsset {
    func matchesSearch(_ query: String) -> Bool {
        LibrarySearch.matches(query, in: listLabel)
    }
}

extension LyricDocument {
    var searchableText: String {
        var parts = [title, content]

        for section in sourceSections {
            parts.append(section.tag.localizedName(for: language))
            parts.append(contentsOf: section.lines)
        }

        for slide in slides {
            parts.append(slide.text)
        }

        return parts.joined(separator: "\n")
    }

    func matchesSearch(_ query: String) -> Bool {
        guard !LibrarySearch.normalize(query).isEmpty else { return true }

        if LibrarySearch.matches(query, in: title) {
            return true
        }

        let haystack = LibrarySearch.normalize(searchableText)
        let queryWords = LibrarySearch.queryWords(query)

        if queryWords.count > 1 {
            return queryWords.allSatisfy { haystack.contains($0) }
        }

        return haystack.contains(LibrarySearch.normalize(query))
    }

    func searchMatchSnippet(matching query: String) -> String? {
        guard !LibrarySearch.normalize(query).isEmpty else { return nil }

        for slide in slides {
            if let line = firstMatchingLine(in: slide.text, query: query) {
                return line
            }
        }

        for section in sourceSections {
            if LibrarySearch.matches(query, in: section.tag.localizedName(for: language)) {
                if let line = section.lines.first {
                    return line
                }
            }

            if let line = section.lines.first(where: { LibrarySearch.matches(query, in: $0) }) {
                return line
            }
        }

        if let line = firstMatchingLine(in: content, query: query) {
            return line
        }

        if LibrarySearch.matches(query, in: title) {
            return title
        }

        return nil
    }

    private func firstMatchingLine(in text: String, query: String) -> String? {
        text
            .components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .first { !$0.isEmpty && LibrarySearch.matches(query, in: $0) }
    }
}
