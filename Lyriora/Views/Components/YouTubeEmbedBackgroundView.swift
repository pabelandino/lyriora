//
//  YouTubeEmbedBackgroundView.swift
//  Lyriora
//

import SwiftUI
import WebKit

#if canImport(UIKit)
import UIKit
#elseif os(macOS)
import AppKit
#endif

struct YouTubeEmbedBackgroundView: View {
    let videoID: String
    var isPlaying: Bool = true
    var stopToken: Int = 0
    var contentMode: BackgroundContentMode = .fill
    var canvasSize: CGSize = PresentationLayout.referenceCanvasSize
    var playback: YouTubePlaybackController?

    private static let videoAspectRatio = CGSize(width: 16, height: 9)

    private var playbackRequest: YouTubeEmbedPlaybackRequest {
        YouTubeEmbedPlaybackRequest(
            videoID: videoID,
            isPlaying: isPlaying,
            stopToken: stopToken
        )
    }

    private var resolvedContentMode: ResolvedBackgroundContentMode {
        contentMode.resolved(
            mediaSize: Self.videoAspectRatio,
            canvasSize: canvasSize
        )
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black

                YouTubeEmbedWebView(request: playbackRequest, playback: playback)
                    .aspectRatio(
                        Self.videoAspectRatio.width / Self.videoAspectRatio.height,
                        contentMode: resolvedContentMode == .fill ? .fill : .fit
                    )
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct YouTubeEmbedPlaybackRequest: Equatable {
    let videoID: String
    let isPlaying: Bool
    let stopToken: Int
}

struct YouTubeEmbedSession: Equatable {
    let videoID: String
}

private struct YouTubeEmbedWebView: View {
    let request: YouTubeEmbedPlaybackRequest
    var playback: YouTubePlaybackController?

    var body: some View {
        YouTubeEmbedWebViewRepresentable(request: request, playback: playback)
    }
}

private struct YouTubeProgressSnapshot: Decodable {
    let currentTime: Double
    let duration: Double
}

private enum YouTubeProgressParser {
    static func snapshot(from result: Any?) -> YouTubeProgressSnapshot? {
        if let json = result as? String,
           let data = json.data(using: .utf8),
           let snapshot = try? JSONDecoder().decode(YouTubeProgressSnapshot.self, from: data) {
            return snapshot
        }

        if let dictionary = result as? [String: Any] {
            let current = (dictionary["currentTime"] as? Double)
                ?? (dictionary["currentTime"] as? NSNumber)?.doubleValue
            let duration = (dictionary["duration"] as? Double)
                ?? (dictionary["duration"] as? NSNumber)?.doubleValue
            if let current, let duration {
                return YouTubeProgressSnapshot(currentTime: current, duration: duration)
            }
        }

        return nil
    }
}

private enum YouTubeEmbedLoader {
    static let safariUserAgent = """
    Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 \
    (KHTML, like Gecko) Version/18.0 Safari/605.1.15
    """

    static func configure(_ webView: WKWebView) {
        webView.customUserAgent = safariUserAgent
    }

    static func sync(
        _ playbackRequest: YouTubeEmbedPlaybackRequest,
        in webView: WKWebView,
        state: inout YouTubeEmbedWebViewState
    ) {
        let session = YouTubeEmbedSession(videoID: playbackRequest.videoID)

        if state.loadedSession != session {
            state.loadedSession = session
            state.isPlaying = playbackRequest.isPlaying
            state.stopToken = playbackRequest.stopToken

            let html = YouTubeLinkParser.embedPageHTML(
                videoID: session.videoID,
                loops: false,
                isPlaying: playbackRequest.isPlaying
            )
            webView.loadHTMLString(html, baseURL: YouTubeLinkParser.embedOrigin)
            return
        }

        if state.stopToken != playbackRequest.stopToken {
            state.stopToken = playbackRequest.stopToken
            state.isPlaying = false
            evaluate(webView, script: "window.lyrioraStop();")
        }

        if state.isPlaying != playbackRequest.isPlaying {
            state.isPlaying = playbackRequest.isPlaying
            let script = playbackRequest.isPlaying
                ? "window.lyrioraSetPlaying(true);"
                : "window.lyrioraSetPlaying(false);"
            evaluate(webView, script: script)
        }
    }

    private static func evaluate(_ webView: WKWebView, script: String) {
        webView.evaluateJavaScript(script, completionHandler: nil)
    }
}

private struct YouTubeEmbedWebViewState {
    var loadedSession: YouTubeEmbedSession?
    var isPlaying = true
    var stopToken = 0
}

#if canImport(UIKit)
private struct YouTubeEmbedWebViewRepresentable: UIViewRepresentable {
    let request: YouTubeEmbedPlaybackRequest
    var playback: YouTubePlaybackController?

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.isUserInteractionEnabled = false
        YouTubeEmbedLoader.configure(webView)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.playback = playback
        YouTubeEmbedLoader.sync(
            request,
            in: webView,
            state: &context.coordinator.state
        )
        context.coordinator.startProgressPolling(for: webView)
    }

    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
        coordinator.stopProgressPolling()
    }

    final class Coordinator {
        var state = YouTubeEmbedWebViewState()
        weak var playback: YouTubePlaybackController?
        private var progressTimer: Timer?

        func startProgressPolling(for webView: WKWebView) {
            guard playback != nil else {
                stopProgressPolling()
                return
            }

            stopProgressPolling()

            let timer = Timer(timeInterval: 0.25, repeats: true) { [weak self, weak webView] _ in
                guard let self, let webView else { return }
                Task { @MainActor in
                    self.pollProgress(in: webView)
                }
            }
            RunLoop.main.add(timer, forMode: .common)
            progressTimer = timer
        }

        func stopProgressPolling() {
            progressTimer?.invalidate()
            progressTimer = nil
        }

        @MainActor
        private func pollProgress(in webView: WKWebView) {
            if let seekTime = playback?.consumePendingSeek() {
                webView.evaluateJavaScript("window.lyrioraSeekTo(\(seekTime));", completionHandler: nil)
            }

            webView.evaluateJavaScript("window.lyrioraGetProgress();") { [weak self] result, _ in
                Task { @MainActor in
                    guard let self, let playback = self.playback else { return }
                    guard let snapshot = YouTubeProgressParser.snapshot(from: result) else { return }
                    playback.updateProgress(current: snapshot.currentTime, duration: snapshot.duration)
                }
            }
        }
    }
}
#elseif os(macOS)
private struct YouTubeEmbedWebViewRepresentable: NSViewRepresentable {
    let request: YouTubeEmbedPlaybackRequest
    var playback: YouTubePlaybackController?

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeNSView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.setValue(false, forKey: "drawsBackground")
        YouTubeEmbedLoader.configure(webView)
        return webView
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
        context.coordinator.playback = playback
        YouTubeEmbedLoader.sync(
            request,
            in: webView,
            state: &context.coordinator.state
        )
        context.coordinator.startProgressPolling(for: webView)
    }

    static func dismantleNSView(_ nsView: WKWebView, coordinator: Coordinator) {
        coordinator.stopProgressPolling()
    }

    final class Coordinator {
        var state = YouTubeEmbedWebViewState()
        weak var playback: YouTubePlaybackController?
        private var progressTimer: Timer?

        func startProgressPolling(for webView: WKWebView) {
            guard playback != nil else {
                stopProgressPolling()
                return
            }

            stopProgressPolling()

            let timer = Timer(timeInterval: 0.25, repeats: true) { [weak self, weak webView] _ in
                guard let self, let webView else { return }
                Task { @MainActor in
                    self.pollProgress(in: webView)
                }
            }
            RunLoop.main.add(timer, forMode: .common)
            progressTimer = timer
        }

        func stopProgressPolling() {
            progressTimer?.invalidate()
            progressTimer = nil
        }

        @MainActor
        private func pollProgress(in webView: WKWebView) {
            if let seekTime = playback?.consumePendingSeek() {
                webView.evaluateJavaScript("window.lyrioraSeekTo(\(seekTime));", completionHandler: nil)
            }

            webView.evaluateJavaScript("window.lyrioraGetProgress();") { [weak self] result, _ in
                Task { @MainActor in
                    guard let self, let playback = self.playback else { return }
                    guard let snapshot = YouTubeProgressParser.snapshot(from: result) else { return }
                    playback.updateProgress(current: snapshot.currentTime, duration: snapshot.duration)
                }
            }
        }
    }
}
#endif

struct YouTubeThumbnailView: View {
    let videoID: String

    @State private var image: Image?

    var body: some View {
        ZStack {
            Group {
                if let image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.black.opacity(0.35)
                }
            }

            VStack(spacing: 8) {
                Image(systemName: "play.rectangle.fill")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.92))
                Text("YouTube")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
        .task(id: videoID) {
            let url = YouTubeLinkParser.thumbnailURL(for: videoID)
            if let cached = LocalImageCache.entry(for: url) {
                image = cached.image
                return
            }

            guard let (data, _) = try? await URLSession.shared.data(from: url),
                  let platformImage = platformImage(from: data) else { return }

            let swiftImage = Image(platformImage: platformImage)
            LocalImageCache.store(image: swiftImage, size: .zero, for: url)
            image = swiftImage
        }
    }

    #if canImport(UIKit)
    private func platformImage(from data: Data) -> UIImage? {
        UIImage(data: data)
    }
    #elseif os(macOS)
    private func platformImage(from data: Data) -> NSImage? {
        NSImage(data: data)
    }
    #endif
}

#if canImport(UIKit)
private extension Image {
    init(platformImage: UIImage) {
        self.init(uiImage: platformImage)
    }
}
#elseif os(macOS)
private extension Image {
    init(platformImage: NSImage) {
        self.init(nsImage: platformImage)
    }
}
#endif
