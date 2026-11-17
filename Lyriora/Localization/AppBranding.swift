//
//  AppBranding.swift
//  Lyriora
//

import Foundation

enum AppBranding {
    static let bundleIdentifier = "com.lvoqshow.app"

    /// User-visible app name from string catalog (follows system language).
    static var displayName: String { L10n.App.displayName }
}