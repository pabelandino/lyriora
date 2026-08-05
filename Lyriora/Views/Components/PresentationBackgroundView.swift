//
//  PresentationBackgroundView.swift
//  Lyriora
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif os(macOS)
import AppKit
#endif

struct PresentationBackgroundView: View {
    let background: PresentationBackground?
    var defaultBackgroundSettings: DefaultBackgroundSettings = .default
    var contentMode: BackgroundContentMode = .fill
    var canvasSize: CGSize = PresentationLayout.referenceCanvasSize

    var body: some View {
        GeometryReader { geometry in
            backgroundContent
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
        }
    }

    @ViewBuilder
    private var backgroundContent: some View {
        if let background {
            switch background.kind {
            case .image:
                LocalFileImageBackground(
                    url: background.url,
                    defaultBackgroundSettings: defaultBackgroundSettings,
                    contentMode: contentMode,
                    canvasSize: canvasSize
                )
            case .video:
                LoopingVideoBackground(
                    url: background.url,
                    contentMode: contentMode,
                    canvasSize: canvasSize
                )
            }
        } else {
            ConfigurableDefaultGradientView(settings: defaultBackgroundSettings)
        }
    }
}

struct LocalFileImageBackground: View {
    let url: URL
    var defaultBackgroundSettings: DefaultBackgroundSettings = .default
    var contentMode: BackgroundContentMode = .fill
    var canvasSize: CGSize = PresentationLayout.referenceCanvasSize

    @State private var image: Image?
    @State private var mediaSize: CGSize = .zero

    private var resolvedMode: ResolvedBackgroundContentMode {
        contentMode.resolved(mediaSize: mediaSize, canvasSize: canvasSize)
    }

    var body: some View {
        ZStack {
            Color.black

            if let image {
                switch resolvedMode {
                case .fill:
                    image
                        .resizable()
                        .scaledToFill()
                case .fit:
                    image
                        .resizable()
                        .scaledToFit()
                }
            } else {
                ConfigurableDefaultGradientView(settings: defaultBackgroundSettings)
            }
        }
        .task(id: url) {
            image = Self.loadImage(from: url)
            mediaSize = Self.loadImageSize(from: url) ?? .zero
        }
    }

    static func loadImage(from url: URL) -> Image? {
        #if canImport(UIKit)
        guard let uiImage = UIImage(contentsOfFile: url.path) else { return nil }
        return Image(uiImage: uiImage)
        #elseif os(macOS)
        guard let nsImage = NSImage(contentsOf: url) else { return nil }
        return Image(nsImage: nsImage)
        #else
        return nil
        #endif
    }

    static func loadImageSize(from url: URL) -> CGSize? {
        #if canImport(UIKit)
        guard let uiImage = UIImage(contentsOfFile: url.path) else { return nil }
        return uiImage.size
        #elseif os(macOS)
        guard let nsImage = NSImage(contentsOf: url) else { return nil }
        return nsImage.size
        #else
        return nil
        #endif
    }
}
