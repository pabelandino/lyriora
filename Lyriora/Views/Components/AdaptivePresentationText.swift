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
            let insets = configuration.contentInsets(for: geometry.size)
            let availableSize = configuration.availableTextSize(in: geometry.size)

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
            .padding(insets)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
