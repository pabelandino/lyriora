//
//  VideoAssetMetadataLoader.swift
//  Lyriora
//

import AVFoundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif os(macOS)
import AppKit
#endif

enum VideoAssetMetadataLoader {
    struct Metadata: Sendable {
        var thumbnail: Image?
        var duration: TimeInterval?
    }

    static func load(from url: URL) async -> Metadata {
        async let duration = loadDuration(from: url)
        async let thumbnail = loadThumbnail(from: url)
        return Metadata(
            thumbnail: await thumbnail,
            duration: await duration
        )
    }

    static func loadDuration(from url: URL) async -> TimeInterval? {
        let asset = AVURLAsset(url: url)

        do {
            let duration = try await asset.load(.duration)
            let seconds = CMTimeGetSeconds(duration)
            guard seconds.isFinite, seconds > 0 else { return nil }
            return seconds
        } catch {
            return nil
        }
    }

    static func loadThumbnail(
        from url: URL,
        maximumSize: CGSize = CGSize(width: 480, height: 270)
    ) async -> Image? {
        let asset = AVURLAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.maximumSize = maximumSize

        for seconds in [0.5, 0.0] {
            let time = CMTime(seconds: seconds, preferredTimescale: 600)

            do {
                let cgImage = try await generateImage(generator: generator, at: time)
                return makeImage(from: cgImage)
            } catch {
                continue
            }
        }

        return nil
    }

    private static func generateImage(
        generator: AVAssetImageGenerator,
        at time: CMTime
    ) async throws -> CGImage {
        try await withCheckedThrowingContinuation { continuation in
            generator.generateCGImagesAsynchronously(forTimes: [NSValue(time: time)]) { _, cgImage, _, result, error in
                switch result {
                case .succeeded:
                    if let cgImage {
                        continuation.resume(returning: cgImage)
                    } else {
                        continuation.resume(throwing: error ?? MetadataError.thumbnailFailed)
                    }
                case .failed:
                    continuation.resume(throwing: error ?? MetadataError.thumbnailFailed)
                case .cancelled:
                    continuation.resume(throwing: MetadataError.cancelled)
                @unknown default:
                    continuation.resume(throwing: MetadataError.thumbnailFailed)
                }
            }
        }
    }

    private static func makeImage(from cgImage: CGImage) -> Image {
        #if canImport(UIKit)
        Image(uiImage: UIImage(cgImage: cgImage))
        #elseif os(macOS)
        Image(nsImage: NSImage(
            cgImage: cgImage,
            size: NSSize(width: cgImage.width, height: cgImage.height)
        ))
        #else
        Image(decorative: cgImage, scale: 1)
        #endif
    }

    private enum MetadataError: Error {
        case thumbnailFailed
        case cancelled
    }
}

enum VideoDurationFormatter {
    static func string(for duration: TimeInterval) -> String {
        playbackTime(for: duration)
    }

    static func playbackTime(for time: TimeInterval) -> String {
        let totalSeconds = max(0, Int(time.rounded()))
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        }
        return String(format: "%d:%02d", minutes, seconds)
    }
}
