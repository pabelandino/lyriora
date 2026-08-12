//
//  TextAnimationKind.swift
//  Lyriora
//

import Foundation

enum TextAnimationKind: String, Codable, CaseIterable, Identifiable, Sendable {
    case none
    case fadeIn
    case blink
    case blinkSemiRotate
    case pulse
    case bounce
    case wave
    case waveRotate
    case shake
    case slideUp
    case slideDown
    case slideLeft
    case slideRight
    case wiggle
    case popIn
    case elastic
    case float
    case heartbeat
    case jitter
    case typewriter
    case staggerFade
    case flipHorizontal
    case flipVertical
    case glowPulse
    case spin
    case zoomPulse

    // Pro / lyric-video style effects
    case neonGlow
    case gradientNeon
    case echoTrail
    case vibrateEcho
    case chromaticShift
    case outlineStack
    case kineticSlam
    case glitchSlice
    case hudGlitch

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .none: "None"
        case .fadeIn: "Fade In"
        case .blink: "Blink"
        case .blinkSemiRotate: "Blink + Tilt"
        case .pulse: "Pulse"
        case .bounce: "Bounce"
        case .wave: "Wave"
        case .waveRotate: "Wave Rotate"
        case .shake: "Shake"
        case .slideUp: "Slide Up"
        case .slideDown: "Slide Down"
        case .slideLeft: "Slide Left"
        case .slideRight: "Slide Right"
        case .wiggle: "Wiggle"
        case .popIn: "Pop In"
        case .elastic: "Elastic"
        case .float: "Float"
        case .heartbeat: "Heartbeat"
        case .jitter: "Jitter"
        case .typewriter: "Typewriter"
        case .staggerFade: "Stagger Fade"
        case .flipHorizontal: "Flip H"
        case .flipVertical: "Flip V"
        case .glowPulse: "Glow Pulse"
        case .spin: "Spin"
        case .zoomPulse: "Zoom Pulse"
        case .neonGlow: "Neon Glow"
        case .gradientNeon: "Gradient Neon"
        case .echoTrail: "Echo Trail"
        case .vibrateEcho: "Vibrate Echo"
        case .chromaticShift: "Chromatic"
        case .outlineStack: "Outline Stack"
        case .kineticSlam: "Kinetic Slam"
        case .glitchSlice: "Glitch Slice"
        case .hudGlitch: "HUD Glitch"
        }
    }

    var systemImage: String {
        switch self {
        case .none: "circle.slash"
        case .fadeIn: "sun.max"
        case .blink: "eye"
        case .blinkSemiRotate: "eye.trianglebadge.exclamationmark"
        case .pulse: "waveform.path"
        case .bounce: "arrow.up.and.down.circle"
        case .wave: "water.waves"
        case .waveRotate: "tornado"
        case .shake: "iphone.gen3.radiowaves.left.and.right"
        case .slideUp: "arrow.up"
        case .slideDown: "arrow.down"
        case .slideLeft: "arrow.left"
        case .slideRight: "arrow.right"
        case .wiggle: "scribble.variable"
        case .popIn: "sparkles"
        case .elastic: "figure.flexibility"
        case .float: "cloud"
        case .heartbeat: "heart"
        case .jitter: "bolt"
        case .typewriter: "keyboard"
        case .staggerFade: "square.stack.3d.down.forward"
        case .flipHorizontal: "arrow.left.and.right.righttriangle.left.righttriangle.right"
        case .flipVertical: "arrow.up.and.down.righttriangle.up.righttriangle.down"
        case .glowPulse: "light.max"
        case .spin: "arrow.triangle.2.circlepath"
        case .zoomPulse: "plus.magnifyingglass"
        case .neonGlow: "lightbulb.max"
        case .gradientNeon: "rainbow"
        case .echoTrail: "square.3.layers.3d"
        case .vibrateEcho: "waveform.badge.magnifyingglass"
        case .chromaticShift: "camera.filters"
        case .outlineStack: "square.stack.3d.up"
        case .kineticSlam: "bolt.fill"
        case .glitchSlice: "tv"
        case .hudGlitch: "rectangle.dashed.badge.record"
        }
    }

    var usesProLayerRendering: Bool {
        switch self {
        case .neonGlow, .gradientNeon, .echoTrail, .vibrateEcho, .chromaticShift,
             .outlineStack, .kineticSlam, .glitchSlice, .hudGlitch:
            true
        default:
            false
        }
    }

    var isProEffect: Bool {
        usesProLayerRendering
    }

    static var proCases: [TextAnimationKind] {
        allCases.filter(\.isProEffect)
    }

    static var basicCases: [TextAnimationKind] {
        allCases.filter { !$0.isProEffect }
    }

    var supportsWholeSlide: Bool { true }

    var supportsWordScope: Bool { true }

    /// Transitions that spread a visual curve across words while sharing the same enter timing.
    var usesSpatialTransitionLayout: Bool {
        switch self {
        case .wave, .waveRotate, .staggerFade:
            true
        default:
            false
        }
    }
}
