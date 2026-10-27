//
//  TextAnimationStylePreset.swift
//  Lyriora
//

import Foundation

struct TextAnimationStylePreset: Identifiable, Sendable {
    let id: String
    let name: String
    let subtitle: String
    let systemImage: String
    let profile: SlideAnimationProfile

    static let all: [TextAnimationStylePreset] = [
        .movidas,
        .alegre,
        .adoracion,
        .cinematografico,
        .minimal
    ]

    static let movidas = TextAnimationStylePreset(
        id: "movidas",
        name: "Movidas",
        subtitle: "Entrada fuerte · glitch y slam",
        systemImage: "bolt.horizontal.fill",
        profile: SlideAnimationProfile(
            transitionKind: .slideUp,
            transitionIntensity: 1.15,
            transitionSpeed: 1.2,
            effectFallback: .kineticSlam,
            effectIntensity: 1.2,
            effectSpeed: 1.35
        )
    )

    static let alegre = TextAnimationStylePreset(
        id: "alegre",
        name: "Alegre",
        subtitle: "Pop colorido · neon continuo",
        systemImage: "party.popper.fill",
        profile: SlideAnimationProfile(
            transitionKind: .popIn,
            transitionIntensity: 1.05,
            transitionSpeed: 1.1,
            effectFallback: .gradientNeon,
            effectIntensity: 1.1,
            effectSpeed: 1.15
        )
    )

    static let adoracion = TextAnimationStylePreset(
        id: "adoracion",
        name: "Adoración",
        subtitle: "Entrada suave · brillo persistente",
        systemImage: "hands.sparkles.fill",
        profile: SlideAnimationProfile(
            transitionKind: .fadeIn,
            transitionIntensity: 0.85,
            transitionSpeed: 0.75,
            effectFallback: .neonGlow,
            effectIntensity: 0.8,
            effectSpeed: 0.7
        )
    )

    static let cinematografico = TextAnimationStylePreset(
        id: "cinematografico",
        name: "Cinematográfico",
        subtitle: "Entrada lateral · eco y cromático",
        systemImage: "film.fill",
        profile: SlideAnimationProfile(
            transitionKind: .slideLeft,
            transitionIntensity: 1,
            transitionSpeed: 0.95,
            effectFallback: .echoTrail,
            effectIntensity: 1,
            effectSpeed: 0.9
        )
    )

    static let minimal = TextAnimationStylePreset(
        id: "minimal",
        name: "Minimal",
        subtitle: "Solo fade limpio",
        systemImage: "circle.hexagongrid.fill",
        profile: SlideAnimationProfile(
            transitionKind: .fadeIn,
            transitionIntensity: 0.7,
            transitionSpeed: 0.8
        )
    )
}

extension TextAnimationStylePreset {
    func appliedProfile() -> SlideAnimationProfile {
        profile
    }
}
