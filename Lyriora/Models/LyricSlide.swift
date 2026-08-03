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

    var index: Int { order }

    init(
        id: UUID = UUID(),
        order: Int,
        text: String,
        tag: LyricSlideTag = .unknown,
        style: SlideTextStyle? = nil
    ) {
        self.id = id
        self.order = order
        self.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        self.tag = tag
        self.style = style
    }

    init(index: Int, text: String) {
        self.init(order: index, text: text, tag: .unknown, style: nil)
    }
}
