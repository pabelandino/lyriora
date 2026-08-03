//
//  PresentationTextConfiguration.swift
//  Lyriora
//

import SwiftUI

struct PresentationTextConfiguration: Equatable {
    let minFontSize: CGFloat
    let maxFontSize: CGFloat
    let fontWeight: Font.Weight
    let paddingRatio: CGFloat
    let isAdaptiveScalingEnabled: Bool

    init(settings: PresentationTextSettings) {
        let minSize = min(settings.minFontSize, settings.maxFontSize)
        let maxSize = max(settings.minFontSize, settings.maxFontSize)

        minFontSize = CGFloat(minSize)
        maxFontSize = CGFloat(maxSize)
        fontWeight = settings.fontWeight.swiftUIWeight
        paddingRatio = CGFloat(settings.paddingRatio)
        isAdaptiveScalingEnabled = settings.isAdaptiveScalingEnabled
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
