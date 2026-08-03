//
//  LyricTheme.swift
//  Lyriora
//

import Foundation

struct LyricTheme: Identifiable, Codable, Equatable, Sendable {
    let id: UUID
    var name: String
    var style: SlideTextStyle
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        style: SlideTextStyle,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.style = style
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    static let previewSampleText = """
    Lorem ipsum dolor sit amet
    consectetur adipiscing elit
    sed do eiusmod tempor incididunt
    ut labore et dolore magna aliqua
    """
}
