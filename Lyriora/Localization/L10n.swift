//
//  L10n.swift
//  Lyriora
//

import Foundation

/// Type-safe access to `Localizable.xcstrings`. Keep keys grouped by feature; add
/// new strings to the catalog before referencing them here.
enum L10n {
    private static let table = "Localizable"

    enum App {
        /// Marketing name shown in UI copy (localized where appropriate).
        static var displayName: String {
            String(localized: "app.display_name", table: table)
        }
    }

    enum Main {
        static var rotateIPhoneTitle: String {
            String(localized: "main.rotate_iphone.title", table: table)
        }

        static var rotateIPhoneBody: String {
            String(localized: "main.rotate_iphone.body", table: table)
        }
    }
}