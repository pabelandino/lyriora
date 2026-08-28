//
//  PresentationState.swift
//  Lyriora
//

import Foundation

struct PresentationState: Equatable, Sendable {
    var showBackground: Bool
    var showLyrics: Bool
    var slideText: String?
    var lyricTitle: String?
    var background: PresentationBackground?
    var slideStyle: SlideTextStyle?
    var slideAnimationProfile: SlideAnimationProfile?
    var wordFontSizeOverrides: [WordFontSizeOverride] = []
    var slideID: UUID?
    var slidePresentationToken: Int = 0
    var videoLoops: Bool = true
    var isVideoPlaying: Bool = true
    var videoStopToken: Int = 0

    static let empty = PresentationState(
        showBackground: false,
        showLyrics: false,
        slideText: nil,
        lyricTitle: nil,
        background: nil,
        slideStyle: nil,
        videoLoops: true,
        isVideoPlaying: true
    )
}
