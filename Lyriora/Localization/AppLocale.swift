//
//  AppLocale.swift
//  Lyriora
//

import Foundation

/// UI languages shipped with the app. Add a case here and matching entries in
/// `Localizable.xcstrings` / `InfoPlist.xcstrings`, then register the code in the
/// Xcode project's `knownRegions`.
enum AppLocale: String, CaseIterable, Sendable, Identifiable {
    case english = "en"
    case spanish = "es"
    case portuguese = "pt"

    var id: String { rawValue }

    var languageCode: String { rawValue }
}

enum AppLocaleCatalog {
    static let supportedLanguageCodes: [String] = AppLocale.allCases.map(\.languageCode)
}