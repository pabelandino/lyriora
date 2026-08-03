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
                .font(.system(size: fontSize, weight: configuration.fontWeight, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: availableSize.width, alignment: .center)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(padding)
                .shadow(color: .black.opacity(0.4), radius: 8, y: 4)
        }
    }
}
