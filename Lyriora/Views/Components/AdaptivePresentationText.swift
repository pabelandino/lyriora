//
//  AdaptivePresentationText.swift
//  Lyriora
//

import SwiftUI

struct AdaptivePresentationText: View {
    let text: String
    let configuration: PresentationTextConfiguration
    var animationProfile: SlideAnimationProfile = SlideAnimationProfile()
    var slideID: UUID = AdaptivePresentationText.placeholderSlideID
    var presentationToken: Int = 0
    var isAnimating: Bool = true
    var animationQuality: PresentationAnimationQuality = .preview

    static let placeholderSlideID = UUID()

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

            Group {
                if animationProfile.hasAnimations {
                    SlideTransitionTextContainer(
                        slideID: slideID,
                        text: text,
                        playsTransition: animationProfile.hasTransition,
                        transitionSpeed: animationProfile.transitionSpeed,
                        transitionWordStagger: animationProfile.transitionWordStagger,
                        presentationToken: presentationToken
                    ) { transitionState, displayedText in
                        AnimatedPresentationText(
                            text: displayedText,
                            configuration: configuration,
                            availableSize: availableSize,
                            fontSize: fontSize,
                            animationProfile: animationProfile,
                            transitionState: transitionState,
                            isAnimating: isAnimating,
                            animationQuality: animationQuality,
                            scalesToFitWidth: configuration.isAdaptiveScalingEnabled
                        )
                    }
                } else {
                    ExplicitLinePresentationText(
                        lines: lines,
                        fontSize: fontSize,
                        configuration: configuration,
                        availableSize: availableSize,
                        scalesToFitWidth: configuration.isAdaptiveScalingEnabled
                    )
                }
            }
            .padding(insets)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
