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
                    defaultBackgroundSettings: defaultBackgroundSettings
                )
            case .video:
                LoopingVideoBackground(url: background.url)
            }
        } else {
            ConfigurableDefaultGradientView(settings: defaultBackgroundSettings)
        }
    }
}

struct LocalFileImageBackground: View {
    let url: URL
    var defaultBackgroundSettings: DefaultBackgroundSettings = .default
    @State private var image: Image?

    var body: some View {
        Group {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                ConfigurableDefaultGradientView(settings: defaultBackgroundSettings)
            }
        }
        .task(id: url) {
            image = Self.loadImage(from: url)
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
}
