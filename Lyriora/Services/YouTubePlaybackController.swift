//
//  YouTubePlaybackController.swift
//  Lyriora
//

import Foundation
import Observation

@MainActor
@Observable
final class YouTubePlaybackController {
    private(set) var currentTime: TimeInterval = 0
    private(set) var duration: TimeInterval = 0

    var isScrubbing = false
    var pendingSeek: TimeInterval?
    var onDurationUpdate: ((TimeInterval) -> Void)?

    func updateProgress(current: TimeInterval, duration newDuration: TimeInterval) {
        if pendingSeek == nil, !isScrubbing {
            currentTime = max(0, current)
        }

        if newDuration.isFinite, newDuration > 0, duration != newDuration {
            duration = newDuration
            onDurationUpdate?(newDuration)
        }
    }

    func requestSeek(to time: TimeInterval) {
        let clamped: TimeInterval
        if duration > 0 {
            clamped = max(0, min(time, duration))
        } else {
            clamped = max(0, time)
        }
        pendingSeek = clamped
        currentTime = clamped
    }

    func consumePendingSeek() -> TimeInterval? {
        defer { pendingSeek = nil }
        return pendingSeek
    }

    func resetProgress() {
        currentTime = 0
        duration = 0
        pendingSeek = nil
        isScrubbing = false
    }
}
