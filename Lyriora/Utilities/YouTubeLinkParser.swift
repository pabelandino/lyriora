//
//  YouTubeLinkParser.swift
//  Lyriora
//

import Foundation

enum YouTubeLinkParser {
    static func normalizedURL(from string: String) -> URL? {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }

        if let url = URL(string: trimmed), url.scheme != nil {
            return url
        }

        if trimmed.contains(".") {
            return URL(string: "https://\(trimmed)")
        }

        return nil
    }

    static func videoID(from string: String) -> String? {
        guard let url = normalizedURL(from: string) else { return nil }
        return videoID(from: url)
    }

    static func videoID(from url: URL) -> String? {
        let host = url.host?.lowercased() ?? ""
        let path = url.path

        if host.contains("youtu.be") {
            let id = path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            return sanitizedVideoID(id)
        }

        if host.contains("youtube.com") || host.contains("youtube-nocookie.com") {
            if path.hasPrefix("/embed/") {
                let id = String(path.dropFirst("/embed/".count))
                return sanitizedVideoID(id)
            }

            if path.hasPrefix("/shorts/") {
                let id = String(path.dropFirst("/shorts/".count))
                return sanitizedVideoID(id)
            }

            if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
               let queryID = components.queryItems?.first(where: { $0.name == "v" })?.value {
                return sanitizedVideoID(queryID)
            }
        }

        return nil
    }

    static func thumbnailURL(for videoID: String) -> URL {
        URL(string: "https://img.youtube.com/vi/\(videoID)/hqdefault.jpg")!
    }

    /// HTTPS origin used as the WKWebView base URL so YouTube can validate embed requests.
    static var embedOrigin: URL {
        let host = (Bundle.main.bundleIdentifier ?? "lyriora.app")
            .lowercased()
            .replacingOccurrences(of: "_", with: "-")
        return URL(string: "https://\(host)")!
    }

    static func embedPageHTML(videoID: String, loops: Bool, isPlaying: Bool) -> String {
        let origin = embedOrigin.absoluteString
        let autoplay = isPlaying ? 1 : 0
        let loopPlayerVars: String
        if loops {
            loopPlayerVars = """
                            loop: 1,
                            playlist: '\(videoID)',
            """
        } else {
            loopPlayerVars = ""
        }

        return """
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
            <meta name="referrer" content="strict-origin-when-cross-origin">
            <style>
                html, body {
                    margin: 0;
                    width: 100%;
                    height: 100%;
                    background: #000;
                    overflow: hidden;
                }
                #player {
                    position: fixed;
                    inset: 0;
                    width: 100%;
                    height: 100%;
                }
            </style>
        </head>
        <body>
            <div id="player"></div>
            <script>
                var player;
                var initialPlaying = \(autoplay) === 1;

                function onYouTubeIframeAPIReady() {
                    player = new YT.Player('player', {
                        width: '100%',
                        height: '100%',
                        videoId: '\(videoID)',
                        playerVars: {
                            autoplay: \(autoplay),
                            playsinline: 1,
                            controls: 0,
                            rel: 0,
                            modestbranding: 1,
                            iv_load_policy: 3,
                            fs: 0,
                            disablekb: 1,
                            enablejsapi: 1,
                            origin: '\(origin)',
                            \(loopPlayerVars)
                        },
                        events: {
                            onReady: function(event) {
                                if (initialPlaying) {
                                    event.target.playVideo();
                                } else {
                                    event.target.pauseVideo();
                                }
                            }
                        }
                    });
                }

                window.lyrioraSetPlaying = function(playing) {
                    if (!player || typeof player.playVideo !== 'function') { return; }
                    if (playing) {
                        player.playVideo();
                    } else {
                        player.pauseVideo();
                    }
                };

                window.lyrioraStop = function() {
                    if (!player || typeof player.pauseVideo !== 'function') { return; }
                    player.pauseVideo();
                    player.seekTo(0, true);
                };

                window.lyrioraGetProgress = function() {
                    if (!player || typeof player.getCurrentTime !== 'function') {
                        return { currentTime: 0, duration: 0 };
                    }
                    return {
                        currentTime: player.getCurrentTime(),
                        duration: player.getDuration()
                    };
                };

                window.lyrioraSeekTo = function(seconds) {
                    if (!player || typeof player.seekTo !== 'function') { return; }
                    player.seekTo(seconds, true);
                };
            </script>
            <script src="https://www.youtube.com/iframe_api" referrerpolicy="strict-origin-when-cross-origin"></script>
        </body>
        </html>
        """
    }

    private static func sanitizedVideoID(_ raw: String) -> String? {
        let id = raw.split(separator: "?").first.map(String.init) ?? raw
        let trimmed = id.trimmingCharacters(in: .whitespacesAndNewlines)
        guard (11...12).contains(trimmed.count) else { return nil }
        let allowed = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_")
        guard trimmed.unicodeScalars.allSatisfy({ allowed.contains($0) }) else { return nil }
        return trimmed
    }
}

extension MediaAsset {
    var isYouTubeLink: Bool {
        kind == .video && fileName.hasSuffix(".ytlink")
    }
}
