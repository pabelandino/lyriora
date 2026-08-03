//
//  DefaultBackgroundPreset.swift
//  Lyriora
//

import SwiftUI

enum DefaultBackgroundPreset: String, Codable, CaseIterable, Identifiable, Sendable {
    case oceanBlue
    case midnightBlue
    case cobaltFade
    case arcticGlow
    case deepNavy

    var id: String { rawValue }

    var label: String {
        switch self {
        case .oceanBlue: "Ocean Blue"
        case .midnightBlue: "Midnight Blue"
        case .cobaltFade: "Cobalt Fade"
        case .arcticGlow: "Arctic Glow"
        case .deepNavy: "Deep Navy"
        }
    }

    var colors: [Color] {
        switch self {
        case .oceanBlue:
            [
                Color(red: 0.03, green: 0.06, blue: 0.14),
                Color(red: 0.05, green: 0.11, blue: 0.24),
                Color(red: 0.08, green: 0.18, blue: 0.38),
                Color(red: 0.11, green: 0.28, blue: 0.52),
                Color(red: 0.14, green: 0.36, blue: 0.64),
                Color(red: 0.09, green: 0.22, blue: 0.46),
                Color(red: 0.04, green: 0.08, blue: 0.20)
            ]
        case .midnightBlue:
            [
                Color(red: 0.02, green: 0.04, blue: 0.10),
                Color(red: 0.04, green: 0.08, blue: 0.18),
                Color(red: 0.06, green: 0.12, blue: 0.26),
                Color(red: 0.08, green: 0.16, blue: 0.32),
                Color(red: 0.05, green: 0.10, blue: 0.22),
                Color(red: 0.03, green: 0.06, blue: 0.14)
            ]
        case .cobaltFade:
            [
                Color(red: 0.04, green: 0.10, blue: 0.22),
                Color(red: 0.07, green: 0.16, blue: 0.34),
                Color(red: 0.10, green: 0.24, blue: 0.48),
                Color(red: 0.16, green: 0.34, blue: 0.62),
                Color(red: 0.12, green: 0.26, blue: 0.54),
                Color(red: 0.06, green: 0.14, blue: 0.30)
            ]
        case .arcticGlow:
            [
                Color(red: 0.06, green: 0.12, blue: 0.22),
                Color(red: 0.10, green: 0.20, blue: 0.36),
                Color(red: 0.14, green: 0.30, blue: 0.50),
                Color(red: 0.20, green: 0.40, blue: 0.58),
                Color(red: 0.16, green: 0.34, blue: 0.52),
                Color(red: 0.08, green: 0.16, blue: 0.28)
            ]
        case .deepNavy:
            [
                Color(red: 0.01, green: 0.03, blue: 0.08),
                Color(red: 0.03, green: 0.06, blue: 0.14),
                Color(red: 0.05, green: 0.10, blue: 0.20),
                Color(red: 0.07, green: 0.14, blue: 0.28),
                Color(red: 0.04, green: 0.08, blue: 0.16),
                Color(red: 0.02, green: 0.05, blue: 0.11)
            ]
        }
    }

    var linearGradient: LinearGradient {
        LinearGradient(
            colors: colors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

struct DefaultBackgroundSettings: Codable, Equatable, Sendable {
    var preset: DefaultBackgroundPreset
    var blurRadius: Double
    var overlayOpacity: Double

    static let `default` = DefaultBackgroundSettings(
        preset: .oceanBlue,
        blurRadius: 72,
        overlayOpacity: 0.32
    )
}

struct ConfigurableDefaultGradientView: View {
    let settings: DefaultBackgroundSettings

    var body: some View {
        settings.preset.linearGradient
    }
}
