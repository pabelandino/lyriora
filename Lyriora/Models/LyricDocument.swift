//
//  LyricDocument.swift
//  Lyriora
//

import Foundation

struct LyricDocument: Identifiable, Codable, Equatable, Sendable {
    let id: UUID
    var title: String
    var content: String
    var storedSlides: [LyricSlide]
    var sourceSections: [LyricSectionSource]
    var styleProfile: LyricStyleProfile
    var language: LyricLanguage
    var colorSeed: UInt64
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        content: String = "",
        storedSlides: [LyricSlide] = [],
        sourceSections: [LyricSectionSource] = [],
        styleProfile: LyricStyleProfile = .default,
        language: LyricLanguage = .unknown,
        colorSeed: UInt64 = UInt64.random(in: 0...UInt64.max),
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.storedSlides = storedSlides
        self.sourceSections = sourceSections
        self.styleProfile = styleProfile
        self.language = language
        self.colorSeed = colorSeed
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    var slides: [LyricSlide] {
        if !storedSlides.isEmpty {
            return storedSlides.sorted { $0.order < $1.order }
        }
        return LyricImportParser.parseLegacyContent(content)
    }

    mutating func syncContentFromSlides() {
        if !sourceSections.isEmpty {
            content = LyricImportParser.rawText(from: sourceSections, language: language)
        } else if !storedSlides.isEmpty {
            let sections = LyricImportParser.sections(from: storedSlides)
            content = LyricImportParser.rawText(from: sections, language: language)
            sourceSections = sections
        } else {
            content = storedSlides
                .sorted { $0.order < $1.order }
                .map { slide in
                    let header = "[\(slide.tag.localizedName(for: language))]"
                    return "\(header)\n\(slide.text)"
                }
                .joined(separator: "\n\n---\n\n")
        }
        updatedAt = .now
    }

    enum CodingKeys: String, CodingKey {
        case id, title, content, storedSlides, sourceSections, styleProfile, language, colorSeed, createdAt, updatedAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        content = try container.decode(String.self, forKey: .content)
        storedSlides = try container.decodeIfPresent([LyricSlide].self, forKey: .storedSlides) ?? []
        sourceSections = try container.decodeIfPresent([LyricSectionSource].self, forKey: .sourceSections) ?? []
        styleProfile = try container.decodeIfPresent(LyricStyleProfile.self, forKey: .styleProfile) ?? .default
        language = try container.decodeIfPresent(LyricLanguage.self, forKey: .language) ?? .unknown
        colorSeed = try container.decodeIfPresent(UInt64.self, forKey: .colorSeed) ?? UInt64.random(in: 0...UInt64.max)
        createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt) ?? .now
        updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt) ?? .now

        if sourceSections.isEmpty, !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            sourceSections = LyricImportParser.parseSections(content).sections
        }

        if storedSlides.isEmpty, !sourceSections.isEmpty {
            storedSlides = LyricImportParser.makeSlides(
                from: sourceSections,
                style: styleProfile.defaultStyle
            )
            language = LyricImportParser.parseSections(content).language
        } else if storedSlides.isEmpty, !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let parsed = LyricImportParser.parse(content, styleProfile: styleProfile)
            storedSlides = parsed.slides
            sourceSections = parsed.sections
            language = parsed.language
        }
    }
}

extension LyricDocument {
    var previewSnippet: String {
        let firstSlide = slides.first?.text ?? content
        return firstSlide
            .components(separatedBy: .newlines)
            .first?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    /// Rebuilds slide chunks from canonical sections using the current style and canvas size.
    func resolvedSlides(
        containerSize: CGSize = PresentationLayout.referenceCanvasSize,
        style: SlideTextStyle? = nil
    ) -> [LyricSlide] {
        let layoutStyle = style ?? styleProfile.defaultStyle
        guard !sourceSections.isEmpty else { return slides }

        let previousSlides = storedSlides.isEmpty
            ? slides
            : storedSlides.sorted { $0.order < $1.order }
        let rechunks = LyricImportParser.makeSlides(
            from: sourceSections,
            style: layoutStyle,
            containerSize: containerSize
        )
        return LyricSlideMetadataPreservation.apply(previousSlides: previousSlides, to: rechunks)
    }
}
