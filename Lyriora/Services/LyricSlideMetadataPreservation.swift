//
//  LyricSlideMetadataPreservation.swift
//  Lyriora
//

import Foundation

enum LyricSlideMetadataPreservation {
    /// Re-applies slide metadata (id, style, animation profile) after layout re-chunking.
    static func apply(previousSlides: [LyricSlide], to newSlides: [LyricSlide]) -> [LyricSlide] {
        guard !previousSlides.isEmpty else { return newSlides }

        let lookupByKey = Dictionary(
            previousSlides.map { (matchKey(for: $0), $0) },
            uniquingKeysWith: { first, _ in first }
        )
        let lookupByOrder = Dictionary(
            previousSlides.map { ($0.order, $0) },
            uniquingKeysWith: { first, _ in first }
        )

        return newSlides.enumerated().map { index, newSlide in
            let previous = lookupByKey[matchKey(for: newSlide)] ?? lookupByOrder[index]
            guard let previous else { return newSlide }

            if normalizeText(previous.text) == normalizeText(newSlide.text) {
                return LyricSlide(
                    id: previous.id,
                    order: newSlide.order,
                    text: newSlide.text,
                    tag: newSlide.tag,
                    style: previous.style,
                    animationProfile: previous.animationProfile,
                    wordFontSizeOverrides: previous.wordFontSizeOverrides,
                    sourceSectionID: newSlide.sourceSectionID,
                    simplePlaySectionID: previous.simplePlaySectionID
                )
            }

            var merged = newSlide
            merged.style = previous.style
            merged.animationProfile = previous.animationProfile
            merged.wordFontSizeOverrides = previous.wordFontSizeOverrides
            merged.simplePlaySectionID = previous.simplePlaySectionID
            return merged
        }
    }

    private static func matchKey(for slide: LyricSlide) -> String {
        let section = slide.sourceSectionID?.uuidString ?? "none"
        let tag = slide.tag.rawValue
        let text = normalizeText(slide.text)
        return "\(section)|\(tag)|\(text)"
    }

    private static func normalizeText(_ text: String) -> String {
        text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\r\n", with: "\n")
    }
}
