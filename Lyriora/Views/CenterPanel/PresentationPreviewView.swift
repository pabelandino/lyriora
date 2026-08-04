//
//  PresentationPreviewView.swift
//  Lyriora
//

import SwiftUI

struct PresentationPreviewView: View {
    let state: PresentationState
    let fallbackConfiguration: PresentationTextConfiguration
    let defaultBackgroundSettings: DefaultBackgroundSettings

    private let cornerRadius: CGFloat = 28

    private var textConfiguration: PresentationTextConfiguration {
        if let style = state.slideStyle {
            return style.presentationConfiguration(isPreview: true)
        }
        return fallbackConfiguration
    }

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        ZStack {
            ToggleablePresentationBackgroundLayer(
                isVisible: state.showBackground,
                background: state.background,
                defaultBackgroundSettings: defaultBackgroundSettings,
                blurDefaultBackground: false,
                showsDefaultWhenEmpty: false
            )

            lyricsOverlay
        }
        .clipShape(shape)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .glassEffect(.regular, in: .rect(cornerRadius: cornerRadius, style: .continuous))
    }

    @ViewBuilder
    private var lyricsOverlay: some View {
        if state.showLyrics, let slideText = state.slideText {
            AdaptivePresentationText(
                text: slideText,
                configuration: textConfiguration
            )
        } else if state.showLyrics {
            Text("Select a slide to preview")
                .font(.title3.weight(.medium))
                .foregroundStyle(.white.opacity(0.7))
        }
    }
}

struct ExternalPresentationView: View {
    @Bindable var viewModel: AppViewModel
    var layoutRevision: Int

    var body: some View {
        PresentationContentView(
            state: viewModel.presentationState,
            fallbackConfiguration: PresentationTextConfiguration(settings: viewModel.settings.externalDisplay),
            defaultBackgroundSettings: viewModel.settings.defaultBackground
        )
        .id(layoutRevision)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
    }
}

struct PresentationContentView: View {
    let state: PresentationState
    let fallbackConfiguration: PresentationTextConfiguration
    let defaultBackgroundSettings: DefaultBackgroundSettings

    private var textConfiguration: PresentationTextConfiguration {
        if let style = state.slideStyle {
            return style.presentationConfiguration(isPreview: false)
        }
        return fallbackConfiguration
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black

                if state.showBackground, let background = state.background {
                    PresentationBackgroundView(
                        background: background,
                        defaultBackgroundSettings: defaultBackgroundSettings
                    )
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }

                if state.showLyrics, let slideText = state.slideText {
                    AdaptivePresentationText(
                        text: slideText,
                        configuration: textConfiguration
                    )
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}
