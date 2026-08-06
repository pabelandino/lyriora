//
//  DefaultBackgroundPreset.swift
//  Lyriora
//

import SwiftUI

enum DefaultBackgroundPreset: String, Codable, CaseIterable, Identifiable, Sendable {
    case meshWaves
    case twilightWaves
    case daylightWaves
    case violetDusk
    case morningHaze

    var id: String { rawValue }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)

        switch raw {
        case "meshWaves", "twilightWaves", "daylightWaves", "violetDusk", "morningHaze":
            guard let preset = DefaultBackgroundPreset(rawValue: raw) else {
                self = .meshWaves
                return
            }
            self = preset
        case "oceanBlue", "midnightBlue", "cobaltFade", "arcticGlow", "deepNavy":
            self = .meshWaves
        default:
            self = .meshWaves
        }
    }

    var label: String {
        switch self {
        case .meshWaves: "Mesh Waves"
        case .twilightWaves: "Twilight Waves"
        case .daylightWaves: "Daylight Waves"
        case .violetDusk: "Violet Dusk"
        case .morningHaze: "Morning Haze"
        }
    }

    var isAdaptive: Bool {
        self == .meshWaves
    }

    func resolvedStyle(for colorScheme: ColorScheme) -> DefaultBackgroundMeshStyle {
        switch self {
        case .meshWaves:
            colorScheme == .dark ? .twilightWaves : .daylightWaves
        case .twilightWaves:
            .twilightWaves
        case .daylightWaves:
            .daylightWaves
        case .violetDusk:
            .violetDusk
        case .morningHaze:
            .morningHaze
        }
    }
}

enum DefaultBackgroundMeshStyle: Sendable {
    case twilightWaves
    case daylightWaves
    case violetDusk
    case morningHaze

    var wavePoints: [SIMD2<Float>] {
        [
            SIMD2(0.00, 0.00), SIMD2(0.50, 0.04), SIMD2(1.00, 0.00),
            SIMD2(0.02, 0.48), SIMD2(0.58, 0.42), SIMD2(0.98, 0.54),
            SIMD2(0.00, 1.00), SIMD2(0.44, 0.96), SIMD2(1.00, 1.00)
        ]
    }

    var colors: [Color] {
        switch self {
        case .twilightWaves:
            [
                Color(red: 0.11, green: 0.03, blue: 0.24),
                Color(red: 0.05, green: 0.04, blue: 0.18),
                Color(red: 0.03, green: 0.03, blue: 0.13),
                Color(red: 0.03, green: 0.06, blue: 0.22),
                Color(red: 0.20, green: 0.06, blue: 0.30),
                Color(red: 0.32, green: 0.05, blue: 0.22),
                Color(red: 0.02, green: 0.04, blue: 0.15),
                Color(red: 0.12, green: 0.07, blue: 0.30),
                Color(red: 0.26, green: 0.04, blue: 0.18)
            ]
        case .violetDusk:
            [
                Color(red: 0.13, green: 0.03, blue: 0.26),
                Color(red: 0.06, green: 0.03, blue: 0.16),
                Color(red: 0.03, green: 0.02, blue: 0.11),
                Color(red: 0.05, green: 0.05, blue: 0.20),
                Color(red: 0.28, green: 0.06, blue: 0.36),
                Color(red: 0.40, green: 0.04, blue: 0.26),
                Color(red: 0.02, green: 0.03, blue: 0.14),
                Color(red: 0.16, green: 0.06, blue: 0.38),
                Color(red: 0.32, green: 0.03, blue: 0.22)
            ]
        case .daylightWaves:
            [
                Color(red: 0.30, green: 0.66, blue: 0.97),
                Color(red: 1.00, green: 1.00, blue: 1.00),
                Color(red: 0.40, green: 0.74, blue: 0.99),
                Color(red: 0.88, green: 0.96, blue: 1.00),
                Color(red: 1.00, green: 1.00, blue: 1.00),
                Color(red: 0.46, green: 0.78, blue: 1.00),
                Color(red: 0.36, green: 0.70, blue: 0.98),
                Color(red: 1.00, green: 1.00, blue: 1.00),
                Color(red: 0.44, green: 0.76, blue: 0.99)
            ]
        case .morningHaze:
            [
                Color(red: 0.38, green: 0.72, blue: 0.99),
                Color(red: 1.00, green: 1.00, blue: 1.00),
                Color(red: 0.48, green: 0.78, blue: 1.00),
                Color(red: 0.92, green: 0.98, blue: 1.00),
                Color(red: 1.00, green: 1.00, blue: 1.00),
                Color(red: 0.52, green: 0.82, blue: 1.00),
                Color(red: 0.42, green: 0.74, blue: 0.99),
                Color(red: 1.00, green: 1.00, blue: 1.00),
                Color(red: 0.50, green: 0.80, blue: 1.00)
            ]
        }
    }
}

struct DefaultBackgroundSettings: Codable, Equatable, Sendable {
    var preset: DefaultBackgroundPreset
    var blurRadius: Double
    var overlayOpacity: Double

    static let `default` = DefaultBackgroundSettings(
        preset: .meshWaves,
        blurRadius: 72,
        overlayOpacity: 0.32
    )
}

struct ConfigurableDefaultGradientView: View {
    let settings: DefaultBackgroundSettings
    @Environment(\.colorScheme) private var colorScheme

    private var layerIdentity: String {
        if settings.preset.isAdaptive {
            return "\(settings.preset.rawValue)-\(colorScheme == .dark ? "dark" : "light")"
        }
        return settings.preset.rawValue
    }

    var body: some View {
        DefaultBackgroundMeshView(preset: settings.preset)
            .id(layerIdentity)
    }
}

struct DefaultBackgroundMeshView: View {
    let preset: DefaultBackgroundPreset
    @Environment(\.colorScheme) private var colorScheme

    private var style: DefaultBackgroundMeshStyle {
        preset.resolvedStyle(for: colorScheme)
    }

    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: style.wavePoints,
            colors: style.colors
        )
    }
}

#if DEBUG
#Preview("Twilight Waves") {
    DefaultBackgroundMeshView(preset: .twilightWaves)
        .ignoresSafeArea()
}

#Preview("Daylight Waves") {
    DefaultBackgroundMeshView(preset: .daylightWaves)
        .ignoresSafeArea()
}
#endif
