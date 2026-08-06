//
//  VideoPlaybackController.swift
//  Lyriora
//

import AVFoundation
import Foundation
import Observation

@MainActor
@Observable
final class VideoPlaybackController {
    private(set) var currentTime: TimeInterval = 0
    private(set) var duration: TimeInterval = 0
    private(set) var player: AVPlayer?

    private var currentURL: URL?
    private var configuredLoops = false
    private var playerLooper: AVPlayerLooper?
    private var timeObserver: Any?
    private var endObserver: NSObjectProtocol?

    var isPlaying = true
    var loops = true
    var isMuted = false
    var isScrubbing = false
    var onDurationUpdate: ((TimeInterval) -> Void)?

    func load(url: URL) {
        if currentURL == url, configuredLoops == loops {
            applyPlaybackSettings()
            return
        }

        teardownObservers()
        teardownLooper()

        let item = AVPlayerItem(url: url)
        let queuePlayer = AVQueuePlayer()
        queuePlayer.actionAtItemEnd = .none

        if loops {
            playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: item)
        } else {
            queuePlayer.insert(item, after: nil)
            installEndObserver(for: item, player: queuePlayer)
        }

        player = queuePlayer
        currentURL = url
        configuredLoops = loops
        currentTime = 0
        duration = 0

        installProgressObserver(for: queuePlayer)
        applyPlaybackSettings()
    }

    func applyPlaybackSettings() {
        if let currentURL, configuredLoops != loops {
            load(url: currentURL)
            return
        }

        player?.isMuted = isMuted

        guard let player else { return }

        if isPlaying {
            player.play()
        } else {
            player.pause()
        }
    }

    func seek(to time: TimeInterval) {
        let clamped = max(0, time)
        currentTime = clamped

        guard let player else { return }

        player.seek(
            to: CMTime(seconds: clamped, preferredTimescale: 600),
            toleranceBefore: .zero,
            toleranceAfter: .zero
        )
    }

    func stop() {
        isPlaying = false
        seek(to: 0)
        player?.pause()
    }

    func teardown() {
        teardownObservers()
        teardownLooper()
        player?.pause()
        player = nil
        currentURL = nil
        configuredLoops = false
        currentTime = 0
        duration = 0
    }

    private func handleProgressTick(_ time: CMTime, player: AVPlayer) {
        guard !isScrubbing else { return }

        let seconds = CMTimeGetSeconds(time)
        if seconds.isFinite {
            currentTime = max(0, seconds)
        }

        if let item = player.currentItem {
            let total = CMTimeGetSeconds(item.duration)
            if total.isFinite, total > 0, duration != total {
                duration = total
                onDurationUpdate?(total)
            }
        }
    }

    private func installProgressObserver(for player: AVPlayer) {
        removeProgressObserver()

        let interval = CMTime(seconds: 0.25, preferredTimescale: 600)
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self, weak player] time in
            guard let self, let player else { return }
            Task { @MainActor in
                self.handleProgressTick(time, player: player)
            }
        }
    }

    private func installEndObserver(for item: AVPlayerItem, player: AVPlayer) {
        removeEndObserver()

        endObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: item,
            queue: .main
        ) { [weak self, weak player] _ in
            guard let self, let player else { return }
            Task { @MainActor in
                if self.loops {
                    player.seek(to: .zero)
                    player.play()
                    self.currentTime = 0
                } else {
                    player.pause()
                    self.isPlaying = false
                }
            }
        }
    }

    private func teardownLooper() {
        playerLooper?.disableLooping()
        playerLooper = nil
    }

    private func teardownObservers() {
        removeProgressObserver()
        removeEndObserver()
    }

    private func removeProgressObserver() {
        guard let timeObserver, let player else {
            self.timeObserver = nil
            return
        }
        player.removeTimeObserver(timeObserver)
        self.timeObserver = nil
    }

    private func removeEndObserver() {
        if let endObserver {
            NotificationCenter.default.removeObserver(endObserver)
        }
        endObserver = nil
    }
}
