//
//  LyricSlide.swift
//  Lyriora
//

import Foundation

struct LyricSlide: Identifiable, Codable, Equatable, Sendable {
    let id: UUID
    var order: Int
    var text: String
    var tag: LyricSlideTag
    var style: SlideTextStyle?
    var animationProfile: SlideAnimationProfile?
    var wordFontSizeOverrides: [WordFontSizeOverride]
    /// Links this slide chunk back to its canonical section for edits and re-chunking.
    var sourceSectionID: UUID?
    /// SimplePlay section that triggers this slide during live performance.
    var simplePlaySectionID: UUID?

    var index: Int { order }

    init(
        id: UUID = UUID(),
        order: Int,
        text: String,
        tag: LyricSlideTag = .unknown,
        style: SlideTextStyle? = nil,
        animationProfile: SlideAnimationProfile? = nil,
        wordFontSizeOverrides: [WordFontSizeOverride] = [],
        sourceSectionID: UUID? = nil,
        simplePlaySectionID: UUID? = nil
    ) {
        self.id = id
        self.order = order
        self.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        self.tag = tag
        self.style = style
        self.animationProfile = animationProfile
        self.wordFontSizeOverrides = wordFontSizeOverrides
        self.sourceSectionID = sourceSectionID
        self.simplePlaySectionID = simplePlaySectionID
    }

    private enum CodingKeys: String, CodingKey {
        case id, order, text, tag, style, animationProfile, wordFontSizeOverrides
        case sourceSectionID, simplePlaySectionID
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        order = try container.decode(Int.self, forKey: .order)
        text = try container.decode(String.self, forKey: .text)
        tag = try container.decode(LyricSlideTag.self, forKey: .tag)
        style = try container.decodeIfPresent(SlideTextStyle.self, forKey: .style)
        animationProfile = try container.decodeIfPresent(SlideAnimationProfile.self, forKey: .animationProfile)
        wordFontSizeOverrides = try container.decodeIfPresent([WordFontSizeOverride].self, forKey: .wordFontSizeOverrides) ?? []
        sourceSectionID = try container.decodeIfPresent(UUID.self, forKey: .sourceSectionID)
        simplePlaySectionID = try container.decodeIfPresent(UUID.self, forKey: .simplePlaySectionID)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(order, forKey: .order)
        try container.encode(text, forKey: .text)
        try container.encode(tag, forKey: .tag)
        try container.encodeIfPresent(style, forKey: .style)
        try container.encodeIfPresent(animationProfile, forKey: .animationProfile)
        if !wordFontSizeOverrides.isEmpty {
            try container.encode(wordFontSizeOverrides, forKey: .wordFontSizeOverrides)
        }
        try container.encodeIfPresent(sourceSectionID, forKey: .sourceSectionID)
        try container.encodeIfPresent(simplePlaySectionID, forKey: .simplePlaySectionID)
    }

    init(index: Int, text: String) {
        self.init(order: index, text: text, tag: .unknown, style: nil)
    }
}
