//
//  BackgroundContentMode.swift
//  Lyriora
//

import CoreGraphics
import Foundation

enum BackgroundContentMode: String, Codable, CaseIterable, Identifiable, Sendable {
    case fill
    case fit
    case auto
    case landscape
    case portrait
    case square

    var id: String { rawValue }

    var label: String {
        switch self {
        case .fill: "Fill"
        case .fit: "Fit"
        case .auto: "Auto"
        case .landscape: "Landscape"
        case .portrait: "Portrait"
        case .square: "Square"
        }
    }

    var subtitle: String {
        switch self {
        case .fill: "Crop to fill the screen"
        case .fit: "Show the entire image"
        case .auto: "Best fit for any orientation"
        case .landscape: "Optimized for wide images"
        case .portrait: "Optimized for tall images"
        case .square: "Optimized for square images"
        }
    }

    var systemImage: String {
        switch self {
        case .fill: "arrow.up.left.and.arrow.down.right"
        case .fit: "arrow.down.right.and.arrow.up.left"
        case .auto: "wand.and.stars"
        case .landscape: "rectangle.landscape.rotate"
        case .portrait: "rectangle.portrait.rotate"
        case .square: "square"
        }
    }

    /// Resolves smart/auto modes using the media and canvas aspect ratios.
    func resolved(
        mediaSize: CGSize,
        canvasSize: CGSize = PresentationLayout.referenceCanvasSize
    ) -> ResolvedBackgroundContentMode {
        guard mediaSize.width > 0, mediaSize.height > 0 else {
            return .fill
        }

        let mediaAspect = mediaSize.width / mediaSize.height
        let canvasAspect = canvasSize.width / max(canvasSize.height, 1)

        switch self {
        case .fill, .landscape:
            return .fill
        case .fit, .portrait, .square:
            return .fit
        case .auto:
            if abs(mediaAspect - canvasAspect) < 0.12 {
                return .fill
            }
            if mediaAspect < 0.95 {
                return .fit
            }
            if mediaAspect > 1.15 {
                return .fill
            }
            return .fit
        }
    }
}

enum ResolvedBackgroundContentMode {
    case fill
    case fit
}
