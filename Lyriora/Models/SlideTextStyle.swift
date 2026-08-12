//
//  SlideTextStyle.swift
//  Lyriora
//

import Foundation

enum PresentationFontDesign: String, Codable, CaseIterable, Identifiable, Sendable {
    case `default`
    case rounded
    case serif
    case monospaced

    var id: String { rawValue }

    var label: String {
        switch self {
        case .default: "Default"
        case .rounded: "Rounded"
        case .serif: "Serif"
        case .monospaced: "Monospaced"
        }
    }
}

struct SlideTextStyle: Codable, Equatable, Sendable {
    var isAdaptiveScalingEnabled: Bool
    var minFontSize: Double
    var maxFontSize: Double
    var fontWeight: PresentationFontWeight
    var fontFamily: PresentationFontFamily
    var textColor: CodableColor
    var paddingRatio: Double
    var horizontalPaddingRatio: Double
    var verticalPaddingRatio: Double
    var lineSpacing: Double
    var maxLinesPerSlide: Int
    var shadowEnabled: Bool
    var shadowColor: CodableColor
    var shadowRadius: Double
    var shadowOpacity: Double
    var shadowYOffset: Double

    static let `default` = SlideTextStyle(
        isAdaptiveScalingEnabled: false,
        minFontSize: 30,
        maxFontSize: 30,
        fontWeight: .bold,
        fontFamily: .systemRounded,
        textColor: .white,
        paddingRatio: 0.06,
        horizontalPaddingRatio: 0.06,
        verticalPaddingRatio: 0.06,
        lineSpacing: 4,
        maxLinesPerSlide: 4,
        shadowEnabled: true,
        shadowColor: CodableColor(red: 0, green: 0, blue: 0, alpha: 0.4),
        shadowRadius: 8,
        shadowOpacity: 1,
        shadowYOffset: 4
    )

    static let previewDefault = SlideTextStyle(
        isAdaptiveScalingEnabled: true,
        minFontSize: 10,
        maxFontSize: 28,
        fontWeight: .semibold,
        fontFamily: .systemRounded,
        textColor: .white,
        paddingRatio: 0.08,
        lineSpacing: 3,
        maxLinesPerSlide: 4,
        shadowEnabled: true,
        shadowColor: CodableColor(red: 0, green: 0, blue: 0, alpha: 0.35),
        shadowRadius: 4,
        shadowOpacity: 1,
        shadowYOffset: 2
    )

    enum CodingKeys: String, CodingKey {
        case isAdaptiveScalingEnabled, minFontSize, maxFontSize, fontWeight
        case fontFamily, fontDesign, textColor, paddingRatio
        case horizontalPaddingRatio, verticalPaddingRatio, lineSpacing
        case maxLinesPerSlide, shadowEnabled, shadowColor, shadowRadius
        case shadowOpacity, shadowYOffset
    }

    init(
        isAdaptiveScalingEnabled: Bool,
        minFontSize: Double,
        maxFontSize: Double,
        fontWeight: PresentationFontWeight,
        fontFamily: PresentationFontFamily,
        textColor: CodableColor,
        paddingRatio: Double,
        horizontalPaddingRatio: Double? = nil,
        verticalPaddingRatio: Double? = nil,
        lineSpacing: Double,
        maxLinesPerSlide: Int,
        shadowEnabled: Bool,
        shadowColor: CodableColor,
        shadowRadius: Double,
        shadowOpacity: Double,
        shadowYOffset: Double
    ) {
        self.isAdaptiveScalingEnabled = isAdaptiveScalingEnabled
        self.minFontSize = minFontSize
        self.maxFontSize = maxFontSize
        self.fontWeight = fontWeight
        self.fontFamily = fontFamily
        self.textColor = textColor
        self.paddingRatio = paddingRatio
        self.horizontalPaddingRatio = horizontalPaddingRatio ?? paddingRatio
        self.verticalPaddingRatio = verticalPaddingRatio ?? paddingRatio
        self.lineSpacing = lineSpacing
        self.maxLinesPerSlide = maxLinesPerSlide
        self.shadowEnabled = shadowEnabled
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.shadowYOffset = shadowYOffset
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isAdaptiveScalingEnabled = try container.decode(Bool.self, forKey: .isAdaptiveScalingEnabled)
        minFontSize = try container.decode(Double.self, forKey: .minFontSize)
        maxFontSize = try container.decode(Double.self, forKey: .maxFontSize)
        fontWeight = try container.decode(PresentationFontWeight.self, forKey: .fontWeight)
        if let family = try container.decodeIfPresent(PresentationFontFamily.self, forKey: .fontFamily) {
            fontFamily = family
        } else if let design = try container.decodeIfPresent(PresentationFontDesign.self, forKey: .fontDesign) {
            fontFamily = PresentationFontFamily(fromLegacyDesign: design)
        } else {
            fontFamily = .systemRounded
        }
        textColor = try container.decode(CodableColor.self, forKey: .textColor)
        paddingRatio = try container.decode(Double.self, forKey: .paddingRatio)
        horizontalPaddingRatio = try container.decodeIfPresent(Double.self, forKey: .horizontalPaddingRatio) ?? paddingRatio
        verticalPaddingRatio = try container.decodeIfPresent(Double.self, forKey: .verticalPaddingRatio) ?? paddingRatio
        lineSpacing = try container.decode(Double.self, forKey: .lineSpacing)
        maxLinesPerSlide = try container.decode(Int.self, forKey: .maxLinesPerSlide)
        shadowEnabled = try container.decode(Bool.self, forKey: .shadowEnabled)
        shadowColor = try container.decode(CodableColor.self, forKey: .shadowColor)
        shadowRadius = try container.decode(Double.self, forKey: .shadowRadius)
        shadowOpacity = try container.decode(Double.self, forKey: .shadowOpacity)
        shadowYOffset = try container.decode(Double.self, forKey: .shadowYOffset)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isAdaptiveScalingEnabled, forKey: .isAdaptiveScalingEnabled)
        try container.encode(minFontSize, forKey: .minFontSize)
        try container.encode(maxFontSize, forKey: .maxFontSize)
        try container.encode(fontWeight, forKey: .fontWeight)
        try container.encode(fontFamily, forKey: .fontFamily)
        try container.encode(textColor, forKey: .textColor)
        try container.encode(paddingRatio, forKey: .paddingRatio)
        try container.encode(horizontalPaddingRatio, forKey: .horizontalPaddingRatio)
        try container.encode(verticalPaddingRatio, forKey: .verticalPaddingRatio)
        try container.encode(lineSpacing, forKey: .lineSpacing)
        try container.encode(maxLinesPerSlide, forKey: .maxLinesPerSlide)
        try container.encode(shadowEnabled, forKey: .shadowEnabled)
        try container.encode(shadowColor, forKey: .shadowColor)
        try container.encode(shadowRadius, forKey: .shadowRadius)
        try container.encode(shadowOpacity, forKey: .shadowOpacity)
        try container.encode(shadowYOffset, forKey: .shadowYOffset)
    }
}

extension SlideTextStyle {
    var fontSize: Double {
        get { maxFontSize }
        set {
            maxFontSize = newValue
            minFontSize = newValue
        }
    }
}

struct LyricStyleProfile: Codable, Equatable, Sendable {
    var name: String
    var defaultStyle: SlideTextStyle
    var tagStyles: [String: SlideTextStyle]
    /// Lyric-wide default transitions and pro effects (Text Style editor).
    var defaultAnimationProfile: SlideAnimationProfile

    static let `default` = LyricStyleProfile(
        name: "Default Style",
        defaultStyle: .default,
        tagStyles: [:],
        defaultAnimationProfile: SlideAnimationProfile()
    )

    private enum CodingKeys: String, CodingKey {
        case name, defaultStyle, tagStyles, defaultAnimationProfile
    }

    init(
        name: String,
        defaultStyle: SlideTextStyle,
        tagStyles: [String: SlideTextStyle],
        defaultAnimationProfile: SlideAnimationProfile = SlideAnimationProfile()
    ) {
        self.name = name
        self.defaultStyle = defaultStyle
        self.tagStyles = tagStyles
        self.defaultAnimationProfile = defaultAnimationProfile
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        defaultStyle = try container.decode(SlideTextStyle.self, forKey: .defaultStyle)
        tagStyles = try container.decodeIfPresent([String: SlideTextStyle].self, forKey: .tagStyles) ?? [:]
        defaultAnimationProfile = try container.decodeIfPresent(
            SlideAnimationProfile.self,
            forKey: .defaultAnimationProfile
        ) ?? SlideAnimationProfile()
    }

    func resolvedStyle(for slide: LyricSlide) -> SlideTextStyle {
        if let custom = slide.style {
            return custom
        }
        if let tagged = tagStyles[slide.tag.rawValue] {
            return tagged
        }
        return defaultStyle
    }

    func resolvedAnimationProfile(for slide: LyricSlide) -> SlideAnimationProfile {
        if let slideProfile = slide.animationProfile, slideProfile.hasAnimations {
            return slideProfile
        }
        return defaultAnimationProfile
    }
}

struct LyricEditorLaunch: Identifiable, Hashable, Codable {
    let id: UUID
    let existingLyricID: UUID?

    init(existingLyricID: UUID? = nil) {
        self.id = UUID()
        self.existingLyricID = existingLyricID
    }
}
