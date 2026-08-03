//
//  AdaptivePresentationText.swift
//  Lyriora
//

import SwiftUI

struct AdaptivePresentationText: View {
    let text: String
    let configuration: PresentationTextConfiguration

    var body: some View {
        GeometryReader { geometry in
            let padding = min(geometry.size.width, geometry.size.height) * configuration.paddingRatio
            let availableSize = CGSize(
                width: max(geometry.size.width - (padding * 2), 1),
                height: max(geometry.size.height - (padding * 2), 1)
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
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: availableSize.width, alignment: .center)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(padding)
                .shadow(
                    color: configuration.shadowEnabled
                        ? configuration.shadowColor.opacity(configuration.shadowOpacity)
                        : .clear,
                    radius: configuration.shadowRadius,
                    y: configuration.shadowYOffset
                )
        }
    }
}
