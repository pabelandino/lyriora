//
//  BlurredBackgroundModifier.swift
//  Lyriora
//

import SwiftUI

struct BlurredBackgroundModifier: ViewModifier {
    let blurRadius: CGFloat
    let overlayOpacity: Double
    let scale: CGFloat

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .blur(radius: blurRadius)
            .overlay {
                Color.black.opacity(overlayOpacity)
            }
    }
}

extension View {
    func blurredBackgroundStyle(
        blurRadius: CGFloat,
        overlayOpacity: Double,
        scale: CGFloat = 1.12
    ) -> some View {
        modifier(
            BlurredBackgroundModifier(
                blurRadius: blurRadius,
                overlayOpacity: overlayOpacity,
                scale: scale
            )
        )
    }
}

struct BlurredBackgroundLayer<Content: View>: View {
    let blurRadius: CGFloat
    let overlayOpacity: Double
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .blurredBackgroundStyle(
                blurRadius: blurRadius,
                overlayOpacity: overlayOpacity
            )
    }
}
