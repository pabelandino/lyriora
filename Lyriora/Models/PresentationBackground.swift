//
//  PresentationBackground.swift
//  Lyriora
//

import Foundation

struct PresentationBackground: Equatable, Sendable {
    let url: URL
    let kind: MediaAssetKind
    var youtubeVideoID: String?

    var isYouTube: Bool {
        youtubeVideoID != nil
    }
}
