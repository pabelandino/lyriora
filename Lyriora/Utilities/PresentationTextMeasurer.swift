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
    static func explicitLines(from text: String) -> [String] {
        text.components(separatedBy: "\n")
    }

    static func fittingFontSize(
        text: String,
        in size: CGSize,
        configuration: PresentationTextConfiguration
    ) -> CGFloat {
        let lines = explicitLines(from: text)
        guard size.width > 0, size.height > 0, !lines.isEmpty else {
            return configuration.minFontSize
        }

        var low = configuration.minFontSize
        var high = configuration.maxFontSize
        var best = configuration.minFontSize

        while low <= high {
            let mid = (low + high) / 2

            if textFits(
                lines: lines,
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
        textFits(
            lines: explicitLines(from: text),
            fontSize: fontSize,
            configuration: configuration,
            in: size
        )
    }

    static func textFits(
        lines: [String],
        fontSize: CGFloat,
        configuration: PresentationTextConfiguration,
        in size: CGSize
    ) -> Bool {
        guard !lines.isEmpty else { return true }

        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard !trimmed.isEmpty else { continue }

            let lineSize = measureSingleLine(
                trimmed,
                fontSize: fontSize,
                configuration: configuration
            )
            if lineSize.width > size.width {
                return false
            }
        }

        return totalHeight(
            for: lines,
            fontSize: fontSize,
            configuration: configuration
        ) <= size.height
    }

    static func totalHeight(
        for lines: [String],
        fontSize: CGFloat,
        configuration: PresentationTextConfiguration
    ) -> CGFloat {
        guard !lines.isEmpty else { return 0 }

        var height: CGFloat = 0
        var renderedLineCount = 0

        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard !trimmed.isEmpty else { continue }

            if renderedLineCount > 0 {
                height += configuration.lineSpacing
            }

            height += measureSingleLine(
                trimmed,
                fontSize: fontSize,
                configuration: configuration
            ).height
            renderedLineCount += 1
        }

        return height
    }

    static func measure(
        text: String,
        fontSize: CGFloat,
        configuration: PresentationTextConfiguration,
        maxWidth: CGFloat
    ) -> CGSize {
        let attributes = measurementAttributes(
            fontSize: fontSize,
            configuration: configuration
        )

        #if canImport(UIKit)
        let bounds = (text as NSString).boundingRect(
            with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        return CGSize(width: ceil(bounds.width), height: ceil(bounds.height))
        #elseif os(macOS)
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

    static func measureSingleLine(
        _ text: String,
        fontSize: CGFloat,
        configuration: PresentationTextConfiguration
    ) -> CGSize {
        measure(
            text: text,
            fontSize: fontSize,
            configuration: configuration,
            maxWidth: .greatestFiniteMagnitude
        )
    }

    private static func measurementAttributes(
        fontSize: CGFloat,
        configuration: PresentationTextConfiguration
    ) -> [NSAttributedString.Key: Any] {
        #if canImport(UIKit)
        let font = configuration.fontFamily.uiFont(size: fontSize, weight: configuration.fontWeight)
        #elseif os(macOS)
        let font = configuration.fontFamily.nsFont(size: fontSize, weight: configuration.fontWeight)
        #endif

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail

        return [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
    }
}
