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
    let horizontalPaddingRatio: CGFloat
    let verticalPaddingRatio: CGFloat
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

        self.init(
            minFontSize: CGFloat(minSize),
            maxFontSize: CGFloat(maxSize),
            fontWeight: style.fontWeight,
            fontFamily: style.fontFamily,
            textColor: style.textColor.color,
            paddingRatio: CGFloat(style.paddingRatio),
            horizontalPaddingRatio: CGFloat(style.horizontalPaddingRatio),
            verticalPaddingRatio: CGFloat(style.verticalPaddingRatio),
            lineSpacing: CGFloat(style.lineSpacing),
            isAdaptiveScalingEnabled: style.isAdaptiveScalingEnabled,
            shadowEnabled: style.shadowEnabled,
            shadowColor: style.shadowColor.color,
            shadowRadius: CGFloat(style.shadowRadius),
            shadowOpacity: style.shadowOpacity,
            shadowYOffset: CGFloat(style.shadowYOffset)
        )
    }

    init(
        minFontSize: CGFloat,
        maxFontSize: CGFloat,
        fontWeight: PresentationFontWeight,
        fontFamily: PresentationFontFamily,
        textColor: Color,
        paddingRatio: CGFloat,
        horizontalPaddingRatio: CGFloat? = nil,
        verticalPaddingRatio: CGFloat? = nil,
        lineSpacing: CGFloat,
        isAdaptiveScalingEnabled: Bool,
        shadowEnabled: Bool,
        shadowColor: Color,
        shadowRadius: CGFloat,
        shadowOpacity: Double,
        shadowYOffset: CGFloat
    ) {
        self.minFontSize = minFontSize
        self.maxFontSize = maxFontSize
        self.fontWeight = fontWeight
        self.fontFamily = fontFamily
        self.textColor = textColor
        self.paddingRatio = paddingRatio
        self.horizontalPaddingRatio = horizontalPaddingRatio ?? paddingRatio
        self.verticalPaddingRatio = verticalPaddingRatio ?? paddingRatio
        self.lineSpacing = lineSpacing
        self.isAdaptiveScalingEnabled = isAdaptiveScalingEnabled
        self.shadowEnabled = shadowEnabled
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.shadowYOffset = shadowYOffset
    }

    func availableTextSize(in containerSize: CGSize) -> CGSize {
        let horizontalInset = containerSize.width * horizontalPaddingRatio
        let verticalInset = containerSize.height * verticalPaddingRatio
        return CGSize(
            width: max(containerSize.width - (horizontalInset * 2), 1),
            height: max(containerSize.height - (verticalInset * 2), 1)
        )
    }

    func contentInsets(for containerSize: CGSize) -> EdgeInsets {
        EdgeInsets(
            top: containerSize.height * verticalPaddingRatio,
            leading: containerSize.width * horizontalPaddingRatio,
            bottom: containerSize.height * verticalPaddingRatio,
            trailing: containerSize.width * horizontalPaddingRatio
        )
    }

    /// Scales typography to approximate full-screen presentation inside a small editor preview.
    func scaledApproximation(for containerSize: CGSize) -> PresentationTextConfiguration {
        let canvasScale = PresentationLayout.scaleToFit(
            contentSize: PresentationLayout.referenceCanvasSize,
            in: containerSize
        )

        return PresentationTextConfiguration(
            minFontSize: max(minFontSize * canvasScale, 6),
            maxFontSize: max(maxFontSize * canvasScale, 8),
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            textColor: textColor,
            paddingRatio: max(paddingRatio, 0.08),
            horizontalPaddingRatio: max(horizontalPaddingRatio, 0.08),
            verticalPaddingRatio: max(verticalPaddingRatio, 0.08),
            lineSpacing: max(lineSpacing * canvasScale, 1),
            isAdaptiveScalingEnabled: true,
            shadowEnabled: shadowEnabled,
            shadowColor: shadowColor,
            shadowRadius: max(shadowRadius * canvasScale, 0),
            shadowOpacity: shadowOpacity,
            shadowYOffset: shadowYOffset * canvasScale
        )
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
