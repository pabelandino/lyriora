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

    var body: some View {
        let padding = min(containerSize.width, containerSize.height) * configuration.paddingRatio
        let availableSize = CGSize(
            width: max(containerSize.width - (padding * 2), 1),
            height: max(containerSize.height - (padding * 2), 1)
        )

        let fontSize = configuration.isAdaptiveScalingEnabled
            ? PresentationTextMeasurer.fittingFontSize(
                text: text,
                in: availableSize,
                configuration: configuration
            )
            : configuration.maxFontSize

        Text(text)
            .font(configuration.font(size: fontSize))
            .multilineTextAlignment(.center)
            .foregroundStyle(configuration.textColor)
            .lineSpacing(configuration.lineSpacing)
            .lineLimit(nil)
            .minimumScaleFactor(0.5)
            .frame(width: availableSize.width, height: availableSize.height, alignment: .center)
            .padding(padding)
            .frame(width: containerSize.width, height: containerSize.height, alignment: .center)
            .shadow(
                color: configuration.shadowEnabled
                    ? configuration.shadowColor.opacity(configuration.shadowOpacity)
                    : .clear,
                radius: configuration.shadowRadius,
                y: configuration.shadowYOffset
            )
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
