//
//  PresentationTextConfiguration.swift
//  Lyriora
//

import SwiftUI

struct PresentationTextConfiguration: Equatable {
    let minFontSize: CGFloat
    let maxFontSize: CGFloat
    let fontWeight: PresentationFontWeight
    let fontFamily: PresentationFontFamily
    let textColor: Color
    let paddingRatio: CGFloat
    let lineSpacing: CGFloat
    let isAdaptiveScalingEnabled: Bool
    let shadowEnabled: Bool
    let shadowColor: Color
    let shadowRadius: CGFloat
    let shadowOpacity: Double
    let shadowYOffset: CGFloat

    init(settings: PresentationTextSettings) {
        let style = SlideTextStyle(
            isAdaptiveScalingEnabled: settings.isAdaptiveScalingEnabled,
            minFontSize: settings.minFontSize,
            maxFontSize: min(settings.maxFontSize, 40),
            fontWeight: settings.fontWeight,
            fontFamily: .systemRounded,
            textColor: .white,
            paddingRatio: settings.paddingRatio,
            lineSpacing: 4,
            maxLinesPerSlide: 4,
            shadowEnabled: true,
            shadowColor: CodableColor(red: 0, green: 0, blue: 0, alpha: 0.4),
            shadowRadius: 8,
            shadowOpacity: 1,
            shadowYOffset: 4
        )
        self.init(style: style)
    }

    init(style: SlideTextStyle) {
        let minSize = min(style.minFontSize, style.maxFontSize)
        let maxSize = max(style.minFontSize, style.maxFontSize)

        minFontSize = CGFloat(minSize)
        maxFontSize = CGFloat(maxSize)
        fontWeight = style.fontWeight
        fontFamily = style.fontFamily
        textColor = style.textColor.color
        paddingRatio = CGFloat(style.paddingRatio)
        lineSpacing = CGFloat(style.lineSpacing)
        isAdaptiveScalingEnabled = style.isAdaptiveScalingEnabled
        shadowEnabled = style.shadowEnabled
        shadowColor = style.shadowColor.color
        shadowRadius = CGFloat(style.shadowRadius)
        shadowOpacity = style.shadowOpacity
        shadowYOffset = CGFloat(style.shadowYOffset)
    }

    func font(size: CGFloat) -> Font {
        fontFamily.font(size: size, weight: fontWeight)
    }
}

extension PresentationFontWeight {
    var swiftUIWeight: Font.Weight {
        switch self {
        case .regular: .regular
        case .medium: .medium
        case .semibold: .semibold
        case .bold: .bold
        }
    }
}

#if canImport(UIKit)
import UIKit

extension PresentationFontWeight {
    var uiWeight: UIFont.Weight {
        switch self {
        case .regular: .regular
        case .medium: .medium
        case .semibold: .semibold
        case .bold: .bold
        }
    }
}
#elseif os(macOS)
import AppKit

extension PresentationFontWeight {
    var nsWeight: NSFont.Weight {
        switch self {
        case .regular: .regular
        case .medium: .medium
        case .semibold: .semibold
        case .bold: .bold
        }
    }
}
#endif

extension SlideTextStyle {
    func presentationConfiguration(isPreview: Bool) -> PresentationTextConfiguration {
        PresentationTextConfiguration(style: self)
    }
}
