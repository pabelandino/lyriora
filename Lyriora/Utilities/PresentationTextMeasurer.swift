//
//  PresentationTextMeasurer.swift
//  Lyriora
//

import CoreGraphics
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif os(macOS)
import AppKit
#endif

enum PresentationTextMeasurer {
    static func fittingFontSize(
        text: String,
        in size: CGSize,
        configuration: PresentationTextConfiguration
    ) -> CGFloat {
        guard size.width > 0, size.height > 0 else {
            return configuration.minFontSize
        }

        var low = configuration.minFontSize
        var high = configuration.maxFontSize
        var best = configuration.minFontSize

        while low <= high {
            let mid = (low + high) / 2

            if textFits(
                text,
                fontSize: mid,
                configuration: configuration,
                in: size
            ) {
                best = mid
                low = mid + 0.5
            } else {
                high = mid - 0.5
            }
        }

        return best
    }

    static func textFits(
        _ text: String,
        fontSize: CGFloat,
        configuration: PresentationTextConfiguration,
        in size: CGSize
    ) -> Bool {
        let measured = measure(
            text: text,
            fontSize: fontSize,
            configuration: configuration,
            maxWidth: size.width
        )

        return measured.width <= size.width && measured.height <= size.height
    }

    static func measure(
        text: String,
        fontSize: CGFloat,
        configuration: PresentationTextConfiguration,
        maxWidth: CGFloat
    ) -> CGSize {
        #if canImport(UIKit)
        let font = configuration.fontFamily.uiFont(size: fontSize, weight: configuration.fontWeight)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let bounds = (text as NSString).boundingRect(
            with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        return CGSize(width: ceil(bounds.width), height: ceil(bounds.height))
        #elseif os(macOS)
        let font = configuration.fontFamily.nsFont(size: fontSize, weight: configuration.fontWeight)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let bounds = (text as NSString).boundingRect(
            with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        return CGSize(width: ceil(bounds.width), height: ceil(bounds.height))
        #else
        return .zero
        #endif
    }
}
