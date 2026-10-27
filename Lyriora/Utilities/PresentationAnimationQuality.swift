//
//  PresentationAnimationQuality.swift
//  Lyriora
//

import Foundation

/// Controls how aggressively persistent pro effects are rendered.
enum PresentationAnimationQuality: Sendable {
    /// In-app preview: lower frame rate and lighter pro layers.
    case preview
    /// External display / live output: full quality.
    case live

    var effectFrameInterval: TimeInterval {
        switch self {
        case .preview: 1.0 / 20.0
        case .live: 1.0 / 24.0
        }
    }
}

enum ProTextRenderQuality: Sendable {
    case preview
    case live
}
