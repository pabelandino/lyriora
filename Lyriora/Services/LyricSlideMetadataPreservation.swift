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

        return newSlides.map { newSlide in
            let previous = lookupByKey[matchKey(for: newSlide)] ?? lookupByOrder[newSlide.order]
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

    /// Ensures slide tags reflect their canonical section tags after re-chunking.
    static func applySectionTags(
        from sections: [LyricSectionSource],
        to slides: [LyricSlide]
    ) -> [LyricSlide] {
        guard !sections.isEmpty else { return slides }

        let tagsBySectionID = Dictionary(uniqueKeysWithValues: sections.map { ($0.id, $0.tag) })
        return slides.map { slide in
            guard let sectionID = slide.sourceSectionID,
                  let sectionTag = tagsBySectionID[sectionID] else {
                return slide
            }

            guard slide.tag != sectionTag else { return slide }

            var updated = slide
            updated.tag = sectionTag
            return updated
        }
    }

    /// Copies slide-level tag/text edits back onto canonical sections.
    static func syncSections(
        from slides: [LyricSlide],
        into sections: [LyricSectionSource]
    ) -> [LyricSectionSource] {
        guard !sections.isEmpty else { return sections }

        return sections.compactMap { section in
            var updated = section
            let sectionSlides = slides
                .filter { $0.sourceSectionID == section.id }
                .sorted { $0.order < $1.order }

            guard !sectionSlides.isEmpty else {
                return nil
            }

            updated.lines = sectionSlides.flatMap { LyricImportParser.lines(from: $0.text) }
            guard !updated.lines.isEmpty else { return nil }

            updated.tag = resolvedSectionTag(for: sectionSlides, current: section.tag)
            return updated
        }
    }

    private static func resolvedSectionTag(
        for sectionSlides: [LyricSlide],
        current: LyricSlideTag
    ) -> LyricSlideTag {
        let tags = sectionSlides.map(\.tag)
        let uniqueTags = Set(tags)
        if uniqueTags.count == 1, let onlyTag = uniqueTags.first {
            return onlyTag
        }

        let counts = Dictionary(grouping: tags, by: { $0 }).mapValues(\.count)
        if let minorityTag = counts.min(by: { $0.value < $1.value })?.key {
            return minorityTag
        }
        return current
    }

    private static func matchKey(for slide: LyricSlide) -> String {
        let section = slide.sourceSectionID?.uuidString ?? "none"
        let text = normalizeText(slide.text)
        return "\(section)|\(text)"
    }

    private static func normalizeText(_ text: String) -> String {
        text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\r\n", with: "\n")
    }
}
