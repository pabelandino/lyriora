//
//  LyricSlideLayoutEngine.swift
//  Lyriora
//

import CoreGraphics
import Foundation

enum LyricSlideLayoutEngine {
    static func makeSlides(
        from sections: [LyricSectionSource],
        style: SlideTextStyle,
        containerSize: CGSize = PresentationLayout.referenceCanvasSize
    ) -> [LyricSlide] {
        let configuration = PresentationTextConfiguration(style: style)
        let configuredMaxLines = max(1, style.maxLinesPerSlide)
        let effectiveMaxLines = effectiveMaxLinesPerSlide(
            style: style,
            configuration: configuration,
            containerSize: containerSize,
            configuredMax: configuredMaxLines
        )

        var slides: [LyricSlide] = []
        var order = 0

        for section in sections {
            let displayLines = displayLines(
                for: section.lines,
                style: style,
                configuration: configuration,
                containerSize: containerSize
            )
            let chunks = chunkLines(displayLines, maxLines: effectiveMaxLines)

            for chunk in chunks {
                slides.append(
                    LyricSlide(
                        order: order,
                        text: chunk.joined(separator: "\n"),
                        tag: section.tag,
                        sourceSectionID: section.id
                    )
                )
                order += 1
            }
        }

        return slides
    }

    static func displayLines(
        for lines: [String],
        style: SlideTextStyle,
        configuration: PresentationTextConfiguration,
        containerSize: CGSize
    ) -> [String] {
        guard !style.isAdaptiveScalingEnabled else {
            return lines
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .filter { !$0.isEmpty }
        }

        let availableWidth = availableTextWidth(
            in: containerSize,
            horizontalPaddingRatio: configuration.horizontalPaddingRatio
        )
        let fontSize = CGFloat(style.maxFontSize)

        return lines.flatMap { line in
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard !trimmed.isEmpty else { return [String]() }
            return splitToFitWidth(
                trimmed,
                maxWidth: availableWidth,
                fontSize: fontSize,
                configuration: configuration
            )
        }
    }

    static func effectiveMaxLinesPerSlide(
        style: SlideTextStyle,
        configuration: PresentationTextConfiguration,
        containerSize: CGSize,
        configuredMax: Int
    ) -> Int {
        guard !style.isAdaptiveScalingEnabled else {
            return max(1, configuredMax)
        }

        let availableHeight = availableTextHeight(
            in: containerSize,
            verticalPaddingRatio: configuration.verticalPaddingRatio
        )
        let fontSize = CGFloat(style.maxFontSize)
        let lineHeight = PresentationTextMeasurer.measureSingleLine(
            "Ag",
            fontSize: fontSize,
            configuration: configuration
        ).height + configuration.lineSpacing

        guard lineHeight > 0 else { return 1 }

        let verticalFit = max(1, Int(floor(availableHeight / lineHeight)))
        return max(1, min(configuredMax, verticalFit))
    }

    private static func availableTextWidth(in containerSize: CGSize, horizontalPaddingRatio: CGFloat) -> CGFloat {
        let padding = containerSize.width * horizontalPaddingRatio
        return max(containerSize.width - (padding * 2), 1)
    }

    private static func availableTextHeight(in containerSize: CGSize, verticalPaddingRatio: CGFloat) -> CGFloat {
        let padding = containerSize.height * verticalPaddingRatio
        return max(containerSize.height - (padding * 2), 1)
    }

    private static func splitToFitWidth(
        _ text: String,
        maxWidth: CGFloat,
        fontSize: CGFloat,
        configuration: PresentationTextConfiguration
    ) -> [String] {
        if PresentationTextMeasurer.measureSingleLine(
            text,
            fontSize: fontSize,
            configuration: configuration
        ).width <= maxWidth {
            return [text]
        }

        let words = text.split(separator: " ", omittingEmptySubsequences: false).map(String.init)
        if words.count > 1 {
            var chunks: [String] = []
            var current = ""

            for word in words {
                let candidate = current.isEmpty ? word : "\(current) \(word)"
                if PresentationTextMeasurer.measureSingleLine(
                    candidate,
                    fontSize: fontSize,
                    configuration: configuration
                ).width <= maxWidth {
                    current = candidate
                } else {
                    if !current.isEmpty {
                        chunks.append(current)
                    }

                    if PresentationTextMeasurer.measureSingleLine(
                        word,
                        fontSize: fontSize,
                        configuration: configuration
                    ).width <= maxWidth {
                        current = word
                    } else {
                        chunks.append(contentsOf: splitCharactersToFit(
                            word,
                            maxWidth: maxWidth,
                            fontSize: fontSize,
                            configuration: configuration
                        ))
                        current = ""
                    }
                }
            }

            if !current.isEmpty {
                chunks.append(current)
            }

            return chunks.isEmpty ? splitCharactersToFit(
                text,
                maxWidth: maxWidth,
                fontSize: fontSize,
                configuration: configuration
            ) : chunks
        }

        return splitCharactersToFit(
            text,
            maxWidth: maxWidth,
            fontSize: fontSize,
            configuration: configuration
        )
    }

    private static func splitCharactersToFit(
        _ text: String,
        maxWidth: CGFloat,
        fontSize: CGFloat,
        configuration: PresentationTextConfiguration
    ) -> [String] {
        guard !text.isEmpty else { return [] }

        var chunks: [String] = []
        var current = ""

        for character in text {
            let candidate = current + String(character)
            if PresentationTextMeasurer.measureSingleLine(
                candidate,
                fontSize: fontSize,
                configuration: configuration
            ).width <= maxWidth {
                current = candidate
            } else {
                if !current.isEmpty {
                    chunks.append(current)
                }
                current = String(character)
            }
        }

        if !current.isEmpty {
            chunks.append(current)
        }

        return chunks
    }

    private static func chunkLines(_ lines: [String], maxLines: Int) -> [[String]] {
        guard !lines.isEmpty else { return [] }

        var chunks: [[String]] = []
        var index = 0

        while index < lines.count {
            let end = min(index + maxLines, lines.count)
            chunks.append(Array(lines[index..<end]))
            index = end
        }

        return chunks
    }
}
