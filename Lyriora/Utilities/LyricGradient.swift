//
//  LyricGradient.swift
//  Lyriora
//

import SwiftUI

enum LyricGradient {
    static func colors(for seed: UInt64) -> [Color] {
        let hue1 = Double(seed % 360) / 360.0
        let hue2 = Double((seed / 360) % 360) / 360.0
        let hue3 = Double((seed / 129_600) % 360) / 360.0

        return [
            Color(hue: hue1, saturation: 0.65, brightness: 0.85),
            Color(hue: hue2, saturation: 0.55, brightness: 0.75),
            Color(hue: hue3, saturation: 0.70, brightness: 0.65)
        ]
    }

    static func linearGradient(for seed: UInt64) -> LinearGradient {
        LinearGradient(
            colors: colors(for: seed),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
