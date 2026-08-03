//
//  LoopingVideoBackground.swift
//  Lyriora
//

import AVFoundation
import SwiftUI

#if canImport(UIKit)
import UIKit

struct LoopingVideoBackground: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> LoopingVideoPlayerView {
        LoopingVideoPlayerView()
    }

    func updateUIView(_ uiView: LoopingVideoPlayerView, context: Context) {
        uiView.configure(url: url)
    }

    final class LoopingVideoPlayerView: UIView {
        private let playerLayer = AVPlayerLayer()
        private var player: AVPlayer?
        private var endObserver: NSObjectProtocol?
        private var currentURL: URL?

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

        func configure(url: URL) {
            guard currentURL != url else {
                player?.play()
                return
            }

            tearDownPlayer()

            let item = AVPlayerItem(url: url)
            let player = AVPlayer(playerItem: item)
            player.isMuted = true
            player.actionAtItemEnd = .none

            endObserver = NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: item,
                queue: .main
            ) { [weak player] _ in
                player?.seek(to: .zero)
                player?.play()
            }

            player.play()
            playerLayer.player = player
            self.player = player
            currentURL = url
        }

        private func tearDownPlayer() {
            player?.pause()
            playerLayer.player = nil
            player = nil

            if let endObserver {
                NotificationCenter.default.removeObserver(endObserver)
                self.endObserver = nil
            }

            currentURL = nil
        }

        deinit {
            tearDownPlayer()
        }
    }
}

#elseif os(macOS)
import AppKit

struct LoopingVideoBackground: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> LoopingVideoPlayerView {
        LoopingVideoPlayerView()
    }

    func updateNSView(_ nsView: LoopingVideoPlayerView, context: Context) {
        nsView.configure(url: url)
    }

    final class LoopingVideoPlayerView: NSView {
        private let playerLayer = AVPlayerLayer()
        private var player: AVPlayer?
        private var endObserver: NSObjectProtocol?
        private var currentURL: URL?

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

        func configure(url: URL) {
            guard currentURL != url else {
                player?.play()
                return
            }

            tearDownPlayer()

            let item = AVPlayerItem(url: url)
            let player = AVPlayer(playerItem: item)
            player.isMuted = true
            player.actionAtItemEnd = .none

            endObserver = NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: item,
                queue: .main
            ) { [weak player] _ in
                player?.seek(to: .zero)
                player?.play()
            }

            player.play()
            playerLayer.player = player
            self.player = player
            currentURL = url
        }

        private func tearDownPlayer() {
            player?.pause()
            playerLayer.player = nil
            player = nil

            if let endObserver {
                NotificationCenter.default.removeObserver(endObserver)
                self.endObserver = nil
            }

            currentURL = nil
        }

        deinit {
            tearDownPlayer()
        }
    }
}
#endif
