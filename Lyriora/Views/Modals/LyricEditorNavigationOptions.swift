//
//  LyricEditorNavigationOptions.swift
//  Lyriora
//

import SwiftUI

enum LyricEditorNavigationOption: Equatable, Hashable, Identifiable {
    case lyrics
    case typography

    static let mainPages: [LyricEditorNavigationOption] = [.lyrics, .typography]

    var id: Self { self }

    var title: String {
        switch self {
        case .lyrics: "Lyrics"
        case .typography: "Text Style"
        }
    }

    var systemImage: String {
        switch self {
        case .lyrics: "append.page"
        case .typography: "textformat"
        }
    }
}
