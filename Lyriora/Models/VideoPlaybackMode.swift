//
//  VideoPlaybackMode.swift
//  Lyriora
//

import Foundation

enum VideoPlaybackMode: String, Sendable {
    case loop
    case playOnce

    var toggled: VideoPlaybackMode {
        switch self {
        case .loop: .playOnce
        case .playOnce: .loop
        }
    }

    var loopsVideo: Bool {
        self == .loop
    }
}
