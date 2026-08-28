//
//  YouTubeMetadataLoader.swift
//  Lyriora
//

import Foundation

enum YouTubeMetadataLoader {
    private struct OEmbedResponse: Decodable {
        let title: String
    }

    static func fetchTitle(for url: URL) async -> String? {
        guard let videoID = YouTubeLinkParser.videoID(from: url) else { return nil }

        var components = URLComponents(string: "https://www.youtube.com/oembed")!
        components.queryItems = [
            URLQueryItem(name: "url", value: "https://www.youtube.com/watch?v=\(videoID)"),
            URLQueryItem(name: "format", value: "json")
        ]

        guard let oembedURL = components.url else { return nil }

        do {
            let (data, response) = try await URLSession.shared.data(from: oembedURL)
            guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                return nil
            }

            let decoded = try JSONDecoder().decode(OEmbedResponse.self, from: data)
            let trimmed = decoded.title.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty ? nil : trimmed
        } catch {
            return nil
        }
    }
}
