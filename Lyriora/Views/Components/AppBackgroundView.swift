//
//  AppBackgroundView.swift
//  Lyriora
//

import SwiftUI

struct AppBackgroundView: View {
    let background: PresentationBackground?
    let defaultBackgroundSettings: DefaultBackgroundSettings
    /// When true, blurs the shell background so it reads as ambient context behind glass panels.
    var blurBackground: Bool = true

    private var layerIdentity: String {
        background?.url.absoluteString ?? "default-\(defaultBackgroundSettings.preset.rawValue)"
    }

    var body: some View {
        ZStack {
            if let background {
                Group {
                    if blurBackground {
                        BlurredBackgroundLayer(
                            blurRadius: defaultBackgroundSettings.blurRadius,
                            overlayOpacity: defaultBackgroundSettings.overlayOpacity
                        ) {
                            PresentationBackgroundView(
                                background: background,
                                defaultBackgroundSettings: defaultBackgroundSettings
                            )
                        }
                    } else {
                        PresentationBackgroundView(
                            background: background,
                            defaultBackgroundSettings: defaultBackgroundSettings
                        )
                    }
                }
                .transition(.opacity)
                .id(layerIdentity)
            } else if blurBackground {
                BlurredBackgroundLayer(
                    blurRadius: defaultBackgroundSettings.blurRadius,
                    overlayOpacity: defaultBackgroundSettings.overlayOpacity
                ) {
                    ConfigurableDefaultGradientView(settings: defaultBackgroundSettings)
                }
                .transition(.opacity)
                .id(layerIdentity)
            } else {
                ConfigurableDefaultGradientView(settings: defaultBackgroundSettings)
                    .transition(.opacity)
                    .id(layerIdentity)
            }

            if !blurBackground {
                Color.black.opacity(defaultBackgroundSettings.overlayOpacity * 0.15)
                    .transition(.opacity)
                    .id("\(layerIdentity)-dim")
            }
        }
        .animation(AppBackgroundAnimation.transition, value: layerIdentity)
        .ignoresSafeArea()
    }
}

enum AppBackgroundAnimation {
    static let transitionDuration: Double = 1.4

    static var transition: Animation {
        .easeInOut(duration: transitionDuration)
    }
}

struct PresentationBackgroundLayer: View {
    let background: PresentationBackground?
    let defaultBackgroundSettings: DefaultBackgroundSettings
    var blurDefaultBackground: Bool = true
    var showsDefaultWhenEmpty: Bool = true

    private var layerIdentity: String {
        background?.url.absoluteString ?? "default-\(defaultBackgroundSettings.preset.rawValue)-\(showsDefaultWhenEmpty)"
    }

    var body: some View {
        Group {
            if let background {
                PresentationBackgroundView(
                    background: background,
                    defaultBackgroundSettings: defaultBackgroundSettings
                )
                .transition(.opacity)
                .id(layerIdentity)
            } else if showsDefaultWhenEmpty {
                if blurDefaultBackground {
                    BlurredBackgroundLayer(
                        blurRadius: defaultBackgroundSettings.blurRadius,
                        overlayOpacity: defaultBackgroundSettings.overlayOpacity
                    ) {
                        ConfigurableDefaultGradientView(settings: defaultBackgroundSettings)
                    }
                    .transition(.opacity)
                    .id(layerIdentity)
                } else {
                    ConfigurableDefaultGradientView(settings: defaultBackgroundSettings)
                        .transition(.opacity)
                        .id(layerIdentity)
                }
            } else {
                Color.clear
                    .transition(.opacity)
                    .id(layerIdentity)
            }
        }
        .animation(AppBackgroundAnimation.transition, value: layerIdentity)
    }
}

struct ToggleablePresentationBackgroundLayer: View {
    let isVisible: Bool
    let background: PresentationBackground?
    let defaultBackgroundSettings: DefaultBackgroundSettings
    var blurDefaultBackground: Bool = true
    var showsDefaultWhenEmpty: Bool = true

    var body: some View {
        Group {
            if isVisible {
                PresentationBackgroundLayer(
                    background: background,
                    defaultBackgroundSettings: defaultBackgroundSettings,
                    blurDefaultBackground: blurDefaultBackground,
                    showsDefaultWhenEmpty: showsDefaultWhenEmpty
                )
            } else {
                Color.black.opacity(0.35)
            }
        }
    }
}
