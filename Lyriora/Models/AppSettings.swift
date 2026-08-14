//
//  AppSettings.swift
//  Lyriora
//

import Foundation

struct AppSettings: Codable, Equatable, Sendable {
    var externalDisplay: PresentationTextSettings
    var preview: PresentationTextSettings
    var defaultBackground: DefaultBackgroundSettings
    var backgroundContentMode: BackgroundContentMode
    /// When true, SimplePlay can still connect but Lyriora ignores automatic slide triggers.
    var isSimplePlayManualMode: Bool

    static let `default` = AppSettings(
        externalDisplay: .externalDefault,
        preview: .previewDefault,
        defaultBackground: .default,
        backgroundContentMode: .fill,
        isSimplePlayManualMode: false
    )

    init(
        externalDisplay: PresentationTextSettings,
        preview: PresentationTextSettings,
        defaultBackground: DefaultBackgroundSettings,
        backgroundContentMode: BackgroundContentMode = .fill,
        isSimplePlayManualMode: Bool = false
    ) {
        self.externalDisplay = externalDisplay
        self.preview = preview
        self.defaultBackground = defaultBackground
        self.backgroundContentMode = backgroundContentMode
        self.isSimplePlayManualMode = isSimplePlayManualMode
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        externalDisplay = try container.decode(PresentationTextSettings.self, forKey: .externalDisplay)
        preview = try container.decode(PresentationTextSettings.self, forKey: .preview)
        defaultBackground = try container.decodeIfPresent(
            DefaultBackgroundSettings.self,
            forKey: .defaultBackground
        ) ?? .default
        backgroundContentMode = try container.decodeIfPresent(
            BackgroundContentMode.self,
            forKey: .backgroundContentMode
        ) ?? .fill
        isSimplePlayManualMode = try container.decodeIfPresent(Bool.self, forKey: .isSimplePlayManualMode) ?? false
    }
}

struct PresentationTextSettings: Codable, Equatable, Sendable {
    var isAdaptiveScalingEnabled: Bool
    var minFontSize: Double
    var maxFontSize: Double
    var fontWeight: PresentationFontWeight
    var paddingRatio: Double

    static let externalDefault = PresentationTextSettings(
        isAdaptiveScalingEnabled: true,
        minFontSize: 12,
        maxFontSize: 40,
        fontWeight: .bold,
        paddingRatio: 0.06
    )

    static let previewDefault = PresentationTextSettings(
        isAdaptiveScalingEnabled: true,
        minFontSize: 10,
        maxFontSize: 28,
        fontWeight: .semibold,
        paddingRatio: 0.08
    )
}

enum PresentationFontWeight: String, Codable, CaseIterable, Identifiable, Sendable {
    case regular
    case medium
    case semibold
    case bold

    var id: String { rawValue }

    var label: String {
        rawValue.capitalized
    }
}
