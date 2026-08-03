//
//  PresentationPreviewView.swift
//  Lyriora
//

import SwiftUI

struct PresentationPreviewView: View {
    let state: PresentationState
    let textConfiguration: PresentationTextConfiguration
    let defaultBackgroundSettings: DefaultBackgroundSettings

    private let cornerRadius: CGFloat = 28

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        ZStack {
            ToggleablePresentationBackgroundLayer(
                isVisible: state.showBackground,
                background: state.background,
                defaultBackgroundSettings: defaultBackgroundSettings
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            lyricsOverlay
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipShape(shape)
        .glassEffect(.regular, in: .rect(cornerRadius: cornerRadius))
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

    var body: some View {
        PresentationContentView(
            state: viewModel.presentationState,
            textConfiguration: PresentationTextConfiguration(settings: viewModel.settings.externalDisplay),
            defaultBackgroundSettings: viewModel.settings.defaultBackground
        )
        .ignoresSafeArea()
    }
}

struct PresentationContentView: View {
    let state: PresentationState
    let textConfiguration: PresentationTextConfiguration
    let defaultBackgroundSettings: DefaultBackgroundSettings

    var body: some View {
        ZStack {
            Color.black

            if state.showBackground {
                PresentationBackgroundLayer(
                    background: state.background,
                    defaultBackgroundSettings: defaultBackgroundSettings
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            }

            if state.showLyrics, let slideText = state.slideText {
                AdaptivePresentationText(
                    text: slideText,
                    configuration: textConfiguration
                )
            }
        }
    }
}
