//
//  LyricSlideTag.swift
//  Lyriora
//

import Foundation

enum LyricSlideTag: String, Codable, CaseIterable, Identifiable, Sendable {
    case intro
    case verse
    case verse1
    case verse2
    case verse3
    case preChorus
    case chorus
    case bridge
    case tag
    case outro
    case instrumental
    case unknown

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .intro: "Intro"
        case .verse: "Verse"
        case .verse1: "Verse 1"
        case .verse2: "Verse 2"
        case .verse3: "Verse 3"
        case .preChorus: "Pre-Chorus"
        case .chorus: "Chorus"
        case .bridge: "Bridge"
        case .tag: "Tag"
        case .outro: "Outro"
        case .instrumental: "Instrumental"
        case .unknown: "Section"
        }
    }

    var spanishName: String {
        switch self {
        case .intro: "Intro"
        case .verse: "Verso"
        case .verse1: "Verso 1"
        case .verse2: "Verso 2"
        case .verse3: "Verso 3"
        case .preChorus: "Pre-Coro"
        case .chorus: "Coro"
        case .bridge: "Puente"
        case .tag: "Tag"
        case .outro: "Outro"
        case .instrumental: "Interludio"
        case .unknown: "Sección"
        }
    }

    func localizedName(for language: LyricLanguage) -> String {
        language == .spanish ? spanishName : displayName
    }
}

enum LyricLanguage: String, Codable, CaseIterable, Identifiable, Sendable {
    case english
    case spanish
    case unknown

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .english: "English"
        case .spanish: "Spanish"
        case .unknown: "Unknown"
        }
    }
}
