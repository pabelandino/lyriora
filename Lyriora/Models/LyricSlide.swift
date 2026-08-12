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
    /// Links this slide chunk back to its canonical section for edits and re-chunking.
    var sourceSectionID: UUID?

    var index: Int { order }

    init(
        id: UUID = UUID(),
        order: Int,
        text: String,
        tag: LyricSlideTag = .unknown,
        style: SlideTextStyle? = nil,
        animationProfile: SlideAnimationProfile? = nil,
        sourceSectionID: UUID? = nil
    ) {
        self.id = id
        self.order = order
        self.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        self.tag = tag
        self.style = style
        self.animationProfile = animationProfile
        self.sourceSectionID = sourceSectionID
    }

    init(index: Int, text: String) {
        self.init(order: index, text: text, tag: .unknown, style: nil)
    }
}
