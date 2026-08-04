//
//  EditorAdaptivePresentationText.swift
//  Lyriora
//

import SwiftUI

/// Renders adaptive presentation text for editor previews using an explicit container size.
/// Avoids `GeometryReader`, which collapses width when nested inside glass/sticky layouts.
struct EditorAdaptivePresentationText: View {
    let text: String
    let configuration: PresentationTextConfiguration
    let containerSize: CGSize
    /// When true, renders at the configured font size instead of auto-shrinking to fit.
    var usesExactFontSize: Bool = true

    private var lines: [String] {
        PresentationTextMeasurer.explicitLines(from: text)
    }

    var body: some View {
        let padding = min(containerSize.width, containerSize.height) * configuration.paddingRatio
        let availableSize = CGSize(
            width: max(containerSize.width - (padding * 2), 1),
            height: max(containerSize.height - (padding * 2), 1)
        )

        let fontSize: CGFloat = {
            if usesExactFontSize || !configuration.isAdaptiveScalingEnabled {
                return configuration.maxFontSize
            }
            return PresentationTextMeasurer.fittingFontSize(
                text: text,
                in: availableSize,
                configuration: configuration
            )
        }()

        ExplicitLinePresentationText(
            lines: lines,
            fontSize: fontSize,
            configuration: configuration,
            availableSize: availableSize,
            scalesToFitWidth: !usesExactFontSize && configuration.isAdaptiveScalingEnabled
        )
        .id(fontSize)
        .padding(padding)
        .frame(width: containerSize.width, height: containerSize.height, alignment: .center)
    }
}

struct ExplicitLinePresentationText: View {
    let lines: [String]
    let fontSize: CGFloat
    let configuration: PresentationTextConfiguration
    let availableSize: CGSize
    var scalesToFitWidth: Bool = false

    var body: some View {
        VStack(spacing: configuration.lineSpacing) {
            ForEach(Array(lines.enumerated()), id: \.offset) { _, line in
                lineView(line)
            }
        }
        .frame(width: availableSize.width, height: availableSize.height, alignment: .center)
        .shadow(
            color: configuration.shadowEnabled
                ? configuration.shadowColor.opacity(configuration.shadowOpacity)
                : .clear,
            radius: configuration.shadowRadius,
            y: configuration.shadowYOffset
        )
    }

    @ViewBuilder
    private func lineView(_ line: String) -> some View {
        let content = Text(line.trimmingCharacters(in: .whitespaces).isEmpty ? " " : line)
            .font(configuration.font(size: fontSize))
            .multilineTextAlignment(.center)
            .foregroundStyle(configuration.textColor)
            .lineLimit(1)
            .frame(maxWidth: availableSize.width)

        if scalesToFitWidth {
            content.minimumScaleFactor(0.5)
        } else {
            content
        }
    }
}

private struct PreviewContainerSizeKey: EnvironmentKey {
    static let defaultValue: CGSize? = nil
}

extension EnvironmentValues {
    var previewContainerSize: CGSize? {
        get { self[PreviewContainerSizeKey.self] }
        set { self[PreviewContainerSizeKey.self] = newValue }
    }
}
