//
//  AdaptivePresentationText.swift
//  Lyriora
//

import SwiftUI

struct AdaptivePresentationText: View {
    let text: String
    let configuration: PresentationTextConfiguration

    private var lines: [String] {
        PresentationTextMeasurer.explicitLines(from: text)
    }

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

            ExplicitLinePresentationText(
                lines: lines,
                fontSize: fontSize,
                configuration: configuration,
                availableSize: availableSize,
                scalesToFitWidth: configuration.isAdaptiveScalingEnabled
            )
            .padding(padding)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
