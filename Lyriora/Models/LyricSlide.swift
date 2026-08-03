//
//  LyricSlide.swift
//  Lyriora
//

import Foundation

struct LyricSlide: Identifiable, Equatable, Hashable, Sendable {
    let index: Int
    let text: String

    var id: Int { index }

    init(index: Int, text: String) {
        self.index = index
        self.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
