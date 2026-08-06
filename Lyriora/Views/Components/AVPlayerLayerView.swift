//
//  AVPlayerLayerView.swift
//  Lyriora
//

import AVFoundation
import SwiftUI

#if os(macOS)
import AVKit
#endif

struct AVPlayerLayerView: View {
    let player: AVPlayer
    var contentMode: BackgroundContentMode = .fill
    var canvasSize: CGSize = PresentationLayout.referenceCanvasSize

    var body: some View {
        #if canImport(UIKit)
        AVPlayerLayerRepresentable(
            player: player,
            videoGravity: Self.videoGravity(for: contentMode, canvasSize: canvasSize)
        )
        #elseif os(macOS)
        AVPlayerViewRepresentable(
            player: player,
            videoGravity: Self.videoGravity(for: contentMode, canvasSize: canvasSize)
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

private struct AVPlayerLayerRepresentable: UIViewRepresentable {
    let player: AVPlayer
    let videoGravity: AVLayerVideoGravity

    func makeUIView(context: Context) -> PlayerLayerView {
        PlayerLayerView()
    }

    func updateUIView(_ uiView: PlayerLayerView, context: Context) {
        uiView.configure(player: player, videoGravity: videoGravity)
    }

    static func dismantleUIView(_ uiView: PlayerLayerView, coordinator: ()) {
        uiView.configure(player: nil, videoGravity: .resizeAspectFill)
    }

    final class PlayerLayerView: UIView {
        override class var layerClass: AnyClass {
            AVPlayerLayer.self
        }

        private var playerLayer: AVPlayerLayer {
            layer as! AVPlayerLayer
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            playerLayer.videoGravity = .resizeAspectFill
            backgroundColor = .clear
        }

        required init?(coder: NSCoder) {
            nil
        }

        func configure(player: AVPlayer?, videoGravity: AVLayerVideoGravity) {
            playerLayer.videoGravity = videoGravity
            if playerLayer.player !== player {
                playerLayer.player = player
            }
        }
    }
}

#elseif os(macOS)

private struct AVPlayerViewRepresentable: NSViewRepresentable {
    let player: AVPlayer
    let videoGravity: AVLayerVideoGravity

    func makeNSView(context: Context) -> AVPlayerView {
        let view = AVPlayerView()
        view.controlsStyle = .none
        view.videoGravity = videoGravity
        view.player = player
        return view
    }

    func updateNSView(_ nsView: AVPlayerView, context: Context) {
        nsView.videoGravity = videoGravity
        if nsView.player !== player {
            nsView.player = player
        }
    }

    static func dismantleNSView(_ nsView: AVPlayerView, coordinator: ()) {
        nsView.player = nil
    }
}
#endif
