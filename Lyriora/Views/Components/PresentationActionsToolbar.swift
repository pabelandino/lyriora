//
//  PresentationActionsToolbar.swift
//  Lyriora
//

import SwiftUI

struct PresentationActionsToolbar: View {
    var showsVideoControls: Bool
    var playbackMode: VideoPlaybackMode
    var isVideoPlaying: Bool
    var hasCustomBackgroundSelected: Bool
    var showLyrics: Bool
    var onClearAll: () -> Void
    var onClearBackground: () -> Void
    var onClearLyrics: () -> Void
    var onToggleVideoMode: () -> Void
    var onToggleVideoPlayback: () -> Void
    var onStopVideo: () -> Void

    @Namespace private var glassNamespace

    var body: some View {
        GlassEffectContainer(spacing: Constants.morphSpacing) {
            HStack(spacing: Constants.morphSpacing) {
                clearActionsCapsule
                    .glassEffectID("presentation-clear-toolbar", in: glassNamespace)

                if showsVideoControls {
                    videoControlsCapsule
                        .glassEffectID("video-playback-toolbar", in: glassNamespace)
                }
            }
        }
        .animation(GlassMorphAnimation.standard, value: showsVideoControls)
        .compositingGroup()
    }

    private var clearActionsCapsule: some View {
        HStack(spacing: GlassToolbarMetrics.itemSpacing) {
            GlassIconButton(systemName: "xmark.circle", accessibilityLabel: "Clear all") {
                onClearAll()
            }

            GlassIconButton(
                systemName: "photo",
                accessibilityLabel: "Clear background",
                isActive: hasCustomBackgroundSelected
            ) {
                onClearBackground()
            }

            GlassIconButton(
                systemName: "doc.text",
                accessibilityLabel: "Clear lyrics",
                isActive: showLyrics
            ) {
                onClearLyrics()
            }
        }
        .padding(.horizontal, GlassToolbarMetrics.horizontalPadding)
        .padding(.vertical, GlassToolbarMetrics.verticalPadding)
        .glassEffect(.regular.interactive(), in: .capsule)
    }

    private var videoControlsCapsule: some View {
        HStack(spacing: GlassToolbarMetrics.itemSpacing) {
            GlassIconButton(
                systemName: playbackMode == .loop ? "repeat" : "repeat.1",
                accessibilityLabel: playbackMode == .loop
                    ? "Loop video"
                    : "Play video once",
                isActive: playbackMode == .loop,
                action: onToggleVideoMode
            )

            GlassIconButton(
                systemName: isVideoPlaying ? "pause.fill" : "play.fill",
                accessibilityLabel: isVideoPlaying ? "Pause video" : "Play video",
                isActive: isVideoPlaying,
                action: onToggleVideoPlayback
            )

            GlassIconButton(
                systemName: "stop.fill",
                accessibilityLabel: "Stop video",
                action: onStopVideo
            )
        }
        .padding(.horizontal, GlassToolbarMetrics.horizontalPadding)
        .padding(.vertical, GlassToolbarMetrics.verticalPadding)
        .glassEffect(.regular.interactive(), in: .capsule)
    }
}

private enum Constants {
    static let morphSpacing: CGFloat = 14
}
