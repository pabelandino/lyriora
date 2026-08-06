//
//  PresentationLayout.swift
//  Lyriora
//

import CoreGraphics

enum PresentationLayout {
    /// Reference canvas used when estimating how many lines fit per slide.
    static let referenceCanvasSize = CGSize(width: 1920, height: 1080)

    /// Reference canvas for Text Style editor preview (16:9).
    static let textStylePreviewCanvasSize = CGSize(width: 1280, height: 720)

    static func resolvedCanvasSize(_ size: CGSize) -> CGSize {
        guard size.width > 1, size.height > 1 else {
            return referenceCanvasSize
        }
        return size
    }

    static func scaleToFit(contentSize: CGSize, in containerSize: CGSize) -> CGFloat {
        guard contentSize.width > 0,
              contentSize.height > 0,
              containerSize.width > 0,
              containerSize.height > 0 else {
            return 1
        }
        return min(
            containerSize.width / contentSize.width,
            containerSize.height / contentSize.height
        )
    }

    static func fittedSize(contentSize: CGSize, in containerSize: CGSize) -> CGSize {
        let scale = scaleToFit(contentSize: contentSize, in: containerSize)
        return CGSize(
            width: contentSize.width * scale,
            height: contentSize.height * scale
        )
    }

    static func aspectRatio(for size: CGSize) -> CGFloat {
        guard size.height > 0 else { return 16.0 / 9.0 }
        return size.width / size.height
    }
}
