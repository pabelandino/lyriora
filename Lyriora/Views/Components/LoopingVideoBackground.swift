//
//  LoopingVideoBackground.swift
//  Lyriora
//

import AVFoundation
import SwiftUI

struct LoopingVideoBackground: View {
    let url: URL
    var contentMode: BackgroundContentMode = .fill
    var canvasSize: CGSize = PresentationLayout.referenceCanvasSize
    var loops: Bool = true
    var isPlaying: Bool = true
    var isMuted: Bool = false
    var seekRequest: VideoSeekRequest?
    var reportsProgress: Bool = false
    var onProgress: ((TimeInterval, TimeInterval) -> Void)?

    var body: some View {
        #if canImport(UIKit)
        LoopingVideoBackgroundRepresentable(
            url: url,
            contentMode: contentMode,
            canvasSize: canvasSize,
            loops: loops,
            isPlaying: isPlaying,
            isMuted: isMuted,
            seekRequest: seekRequest,
            reportsProgress: reportsProgress,
            onProgress: onProgress
        )
        #elseif os(macOS)
        LoopingVideoBackgroundRepresentable(
            url: url,
            contentMode: contentMode,
            canvasSize: canvasSize,
            loops: loops,
            isPlaying: isPlaying,
            isMuted: isMuted,
            seekRequest: seekRequest,
            reportsProgress: reportsProgress,
            onProgress: onProgress
        )
        #endif
    }

    fileprivate static func videoGravity(
        for contentMode: BackgroundContentMode,
        canvasSize: CGSize
    ) -> AVLayerVideoGravity {
        switch contentMode.resolved(
            mediaSize: CGSize(width: 16, height: 9),
            canvasSize: canvasSize
        ) {
        case .fill:
            return .resizeAspectFill
        case .fit:
            return .resizeAspect
        }
    }
}

#if canImport(UIKit)
import UIKit

private struct LoopingVideoBackgroundRepresentable: UIViewRepresentable {
    let url: URL
    var contentMode: BackgroundContentMode
    var canvasSize: CGSize
    var loops: Bool
    var isPlaying: Bool
    var isMuted: Bool
    var seekRequest: VideoSeekRequest?
    var reportsProgress: Bool
    var onProgress: ((TimeInterval, TimeInterval) -> Void)?

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> LoopingVideoPlayerView {
        LoopingVideoPlayerView()
    }

    func updateUIView(_ uiView: LoopingVideoPlayerView, context: Context) {
        uiView.configure(
            url: url,
            videoGravity: LoopingVideoBackground.videoGravity(for: contentMode, canvasSize: canvasSize),
            loops: loops,
            isPlaying: isPlaying,
            isMuted: isMuted,
            seekRequest: seekRequest,
            reportsProgress: reportsProgress,
            onProgress: onProgress,
            progressReporter: uiView.progressReporter,
            lastHandledSeekID: &context.coordinator.lastHandledSeekID
        )
    }

    final class Coordinator {
        var lastHandledSeekID: UUID?
    }
}

final class LoopingVideoPlayerView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var player: AVPlayer?
    private var endObserver: NSObjectProtocol?
    private var timeObserver: Any?
    private var currentURL: URL?
    private var loopsEnabled = true
    fileprivate let progressReporter = VideoProgressReporter()

    override init(frame: CGRect) {
        super.init(frame: frame)
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    func configure(
        url: URL,
        videoGravity: AVLayerVideoGravity,
        loops: Bool,
        isPlaying: Bool,
        isMuted: Bool,
        seekRequest: VideoSeekRequest?,
        reportsProgress: Bool,
        onProgress: ((TimeInterval, TimeInterval) -> Void)?,
        progressReporter: VideoProgressReporter,
        lastHandledSeekID: inout UUID?
    ) {
        VideoPlayerConfigurator.configure(
            playerLayer: playerLayer,
            currentURL: &currentURL,
            player: &player,
            endObserver: &endObserver,
            timeObserver: &timeObserver,
            loopsEnabled: &loopsEnabled,
            progressReporter: progressReporter,
            url: url,
            videoGravity: videoGravity,
            loops: loops,
            isPlaying: isPlaying,
            isMuted: isMuted,
            seekRequest: seekRequest,
            reportsProgress: reportsProgress,
            onProgress: onProgress,
            lastHandledSeekID: &lastHandledSeekID
        )
    }

    deinit {
        VideoPlayerConfigurator.tearDown(
            player: &player,
            playerLayer: playerLayer,
            endObserver: &endObserver,
            timeObserver: &timeObserver,
            currentURL: &currentURL,
            progressReporter: progressReporter
        )
    }
}

#elseif os(macOS)
import AppKit

private struct LoopingVideoBackgroundRepresentable: NSViewRepresentable {
    let url: URL
    var contentMode: BackgroundContentMode
    var canvasSize: CGSize
    var loops: Bool
    var isPlaying: Bool
    var isMuted: Bool
    var seekRequest: VideoSeekRequest?
    var reportsProgress: Bool
    var onProgress: ((TimeInterval, TimeInterval) -> Void)?

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeNSView(context: Context) -> LoopingVideoPlayerView {
        LoopingVideoPlayerView()
    }

    func updateNSView(_ nsView: LoopingVideoPlayerView, context: Context) {
        nsView.configure(
            url: url,
            videoGravity: LoopingVideoBackground.videoGravity(for: contentMode, canvasSize: canvasSize),
            loops: loops,
            isPlaying: isPlaying,
            isMuted: isMuted,
            seekRequest: seekRequest,
            reportsProgress: reportsProgress,
            onProgress: onProgress,
            progressReporter: nsView.progressReporter,
            lastHandledSeekID: &context.coordinator.lastHandledSeekID
        )
    }

    final class Coordinator {
        var lastHandledSeekID: UUID?
    }
}

final class LoopingVideoPlayerView: NSView {
    private let playerLayer = AVPlayerLayer()
    private var player: AVPlayer?
    private var endObserver: NSObjectProtocol?
    private var timeObserver: Any?
    private var currentURL: URL?
    private var loopsEnabled = true
    fileprivate let progressReporter = VideoProgressReporter()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        playerLayer.videoGravity = .resizeAspectFill
        layer?.addSublayer(playerLayer)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func layout() {
        super.layout()
        playerLayer.frame = bounds
    }

    func configure(
        url: URL,
        videoGravity: AVLayerVideoGravity,
        loops: Bool,
        isPlaying: Bool,
        isMuted: Bool,
        seekRequest: VideoSeekRequest?,
        reportsProgress: Bool,
        onProgress: ((TimeInterval, TimeInterval) -> Void)?,
        progressReporter: VideoProgressReporter,
        lastHandledSeekID: inout UUID?
    ) {
        VideoPlayerConfigurator.configure(
            playerLayer: playerLayer,
            currentURL: &currentURL,
            player: &player,
            endObserver: &endObserver,
            timeObserver: &timeObserver,
            loopsEnabled: &loopsEnabled,
            progressReporter: progressReporter,
            url: url,
            videoGravity: videoGravity,
            loops: loops,
            isPlaying: isPlaying,
            isMuted: isMuted,
            seekRequest: seekRequest,
            reportsProgress: reportsProgress,
            onProgress: onProgress,
            lastHandledSeekID: &lastHandledSeekID
        )
    }

    deinit {
        VideoPlayerConfigurator.tearDown(
            player: &player,
            playerLayer: playerLayer,
            endObserver: &endObserver,
            timeObserver: &timeObserver,
            currentURL: &currentURL,
            progressReporter: progressReporter
        )
    }
}
#endif

private enum VideoPlayerConfigurator {
    static func configure(
        playerLayer: AVPlayerLayer,
        currentURL: inout URL?,
        player: inout AVPlayer?,
        endObserver: inout NSObjectProtocol?,
        timeObserver: inout Any?,
        loopsEnabled: inout Bool,
        progressReporter: VideoProgressReporter,
        url: URL,
        videoGravity: AVLayerVideoGravity,
        loops: Bool,
        isPlaying: Bool,
        isMuted: Bool,
        seekRequest: VideoSeekRequest?,
        reportsProgress: Bool,
        onProgress: ((TimeInterval, TimeInterval) -> Void)?,
        lastHandledSeekID: inout UUID?
    ) {
        playerLayer.videoGravity = videoGravity
        let previousLoops = loopsEnabled
        loopsEnabled = loops
        progressReporter.handler = onProgress

        if currentURL == url, let player {
            player.isMuted = isMuted
            applySeekRequest(seekRequest, player: player, lastHandledSeekID: &lastHandledSeekID)
            updateProgressReporting(
                reportsProgress,
                player: player,
                timeObserver: &timeObserver,
                progressReporter: progressReporter
            )
            updatePlayback(isPlaying, loopsEnabled: loopsEnabled, player: player)

            if loops != previousLoops, let item = player.currentItem {
                refreshEndObserver(
                    for: item,
                    player: player,
                    loops: loops,
                    endObserver: &endObserver
                )
            }
            return
        }

        tearDown(
            player: &player,
            playerLayer: playerLayer,
            endObserver: &endObserver,
            timeObserver: &timeObserver,
            currentURL: &currentURL,
            progressReporter: progressReporter
        )

        let item = AVPlayerItem(url: url)
        let newPlayer = AVPlayer(playerItem: item)
        newPlayer.isMuted = isMuted
        newPlayer.actionAtItemEnd = .none
        let shouldLoop = loopsEnabled

        endObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: item,
            queue: .main
        ) { [weak newPlayer] _ in
            guard let newPlayer else { return }

            if shouldLoop {
                newPlayer.seek(to: .zero)
                newPlayer.play()
            } else {
                newPlayer.pause()
            }
        }

        playerLayer.player = newPlayer
        player = newPlayer
        currentURL = url

        applySeekRequest(seekRequest, player: newPlayer, lastHandledSeekID: &lastHandledSeekID)
        updateProgressReporting(
            reportsProgress,
            player: newPlayer,
            timeObserver: &timeObserver,
            progressReporter: progressReporter
        )
        updatePlayback(isPlaying, loopsEnabled: loopsEnabled, player: newPlayer)
    }

    private static func refreshEndObserver(
        for item: AVPlayerItem,
        player: AVPlayer,
        loops: Bool,
        endObserver: inout NSObjectProtocol?
    ) {
        if let endObserver {
            NotificationCenter.default.removeObserver(endObserver)
        }

        endObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: item,
            queue: .main
        ) { [weak player] _ in
            guard let player else { return }

            if loops {
                player.seek(to: .zero)
                player.play()
            } else {
                player.pause()
            }
        }
    }

    static func tearDown(
        player: inout AVPlayer?,
        playerLayer: AVPlayerLayer,
        endObserver: inout NSObjectProtocol?,
        timeObserver: inout Any?,
        currentURL: inout URL?,
        progressReporter: VideoProgressReporter
    ) {
        removeTimeObserver(from: player, timeObserver: &timeObserver)
        player?.pause()
        playerLayer.player = nil
        player = nil

        if let endObserver {
            NotificationCenter.default.removeObserver(endObserver)
        }
        endObserver = nil
        currentURL = nil
        progressReporter.handler = nil
    }

    private static func applySeekRequest(
        _ seekRequest: VideoSeekRequest?,
        player: AVPlayer,
        lastHandledSeekID: inout UUID?
    ) {
        guard let seekRequest, seekRequest.id != lastHandledSeekID else { return }
        lastHandledSeekID = seekRequest.id

        let time = CMTime(seconds: max(0, seekRequest.time), preferredTimescale: 600)
        player.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
    }

    private static func updateProgressReporting(
        _ reportsProgress: Bool,
        player: AVPlayer,
        timeObserver: inout Any?,
        progressReporter: VideoProgressReporter
    ) {
        if reportsProgress {
            guard timeObserver == nil else { return }

            let interval = CMTime(seconds: 0.25, preferredTimescale: 600)
            timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
                guard let item = player.currentItem else { return }

                let current = CMTimeGetSeconds(time)
                let duration = CMTimeGetSeconds(item.duration)
                let resolvedDuration = duration.isFinite && duration > 0 ? duration : 0

                progressReporter.handler?(current, resolvedDuration)
            }
        } else {
            removeTimeObserver(from: player, timeObserver: &timeObserver)
        }
    }

    private static func updatePlayback(_ isPlaying: Bool, loopsEnabled: Bool, player: AVPlayer) {
        if isPlaying {
            if !loopsEnabled,
               let item = player.currentItem,
               item.status == .readyToPlay {
                let currentSeconds = CMTimeGetSeconds(item.currentTime())
                let durationSeconds = CMTimeGetSeconds(item.duration)
                if durationSeconds.isFinite,
                   durationSeconds > 0,
                   currentSeconds >= durationSeconds - 0.05 {
                    player.seek(to: .zero)
                }
            }
            player.play()
        } else {
            player.pause()
        }
    }

    private static func removeTimeObserver(from player: AVPlayer?, timeObserver: inout Any?) {
        guard let token = timeObserver, let player else {
            timeObserver = nil
            return
        }
        player.removeTimeObserver(token)
        timeObserver = nil
    }
}
