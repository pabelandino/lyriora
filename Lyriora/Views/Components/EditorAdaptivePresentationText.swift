//
//  EditorAdaptivePresentationText.swift
//  Lyriora
//

import SwiftUI

enum EditorPreviewSizing {
    /// Renders at the configured point size.
    case exact
    /// Scales typography to approximate on-screen output inside a small preview container.
    case scaledApproximation
}

/// Renders adaptive presentation text for editor previews using an explicit container size.
/// Avoids `GeometryReader`, which collapses width when nested inside glass/sticky layouts.
struct EditorAdaptivePresentationText: View {
    let text: String
    let configuration: PresentationTextConfiguration
    let containerSize: CGSize
    var sizing: EditorPreviewSizing = .scaledApproximation

    private var lines: [String] {
        PresentationTextMeasurer.explicitLines(from: text)
    }

    private var resolvedConfiguration: PresentationTextConfiguration {
        switch sizing {
        case .exact:
            configuration
        case .scaledApproximation:
            configuration.scaledApproximation(for: containerSize)
        }
    }

    var body: some View {
        let activeConfiguration = resolvedConfiguration
        let insets = activeConfiguration.contentInsets(for: containerSize)
        let availableSize = activeConfiguration.availableTextSize(in: containerSize)

        let fontSize: CGFloat = {
            switch sizing {
            case .exact:
                if !activeConfiguration.isAdaptiveScalingEnabled {
                    return activeConfiguration.maxFontSize
                }
                return PresentationTextMeasurer.fittingFontSize(
                    text: text,
                    in: availableSize,
                    configuration: activeConfiguration
                )
            case .scaledApproximation:
                return PresentationTextMeasurer.fittingFontSize(
                    text: text,
                    in: availableSize,
                    configuration: activeConfiguration
                )
            }
        }()

        ExplicitLinePresentationText(
            lines: lines,
            fontSize: fontSize,
            configuration: activeConfiguration,
            availableSize: availableSize,
            scalesToFitWidth: activeConfiguration.isAdaptiveScalingEnabled
        )
        .id("\(fontSize)-\(sizing)-\(containerSize.width)-\(containerSize.height)")
        .padding(insets)
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
