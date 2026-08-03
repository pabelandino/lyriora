//
//  SettingsSheet.swift
//  Lyriora
//

import SwiftUI

struct SettingsSheet: View {
    @Bindable var viewModel: AppViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var isResetConfirmationPresented = false

    var body: some View {
        NavigationStack {
            Form {
                defaultBackgroundSection

                presentationSection(
                    title: "External Display",
                    description: "Controls how lyrics appear on the connected screen.",
                    settings: $viewModel.settings.externalDisplay
                )

                presentationSection(
                    title: "Preview",
                    description: "Controls how lyrics appear in the center preview.",
                    settings: $viewModel.settings.preview
                )

                Section {
                    Button("Reset to Default Settings", role: .destructive) {
                        isResetConfirmationPresented = true
                    }
                } footer: {
                    Text("Restore all presentation settings to their original values.")
                }
            }
            .navigationTitle("Settings")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        viewModel.saveSettings()
                        dismiss()
                    }
                }
            }
            .onChange(of: viewModel.settings) { _, _ in
                viewModel.saveSettings()
            }
            .alert("Reset Settings?", isPresented: $isResetConfirmationPresented) {
                Button("Cancel", role: .cancel) {}

                Button("Reset Settings", role: .destructive) {
                    viewModel.resetSettings()
                }
            } message: {
                Text("All settings including the default background, external display, and preview options will be restored to their defaults. This action cannot be undone.")
            }
        }
        #if os(macOS)
        .frame(minWidth: 460, minHeight: 620)
        #endif
    }

    private var defaultBackgroundSection: some View {
        Section {
            Picker("Style", selection: $viewModel.settings.defaultBackground.preset) {
                ForEach(DefaultBackgroundPreset.allCases) { preset in
                    Label {
                        Text(preset.label)
                    } icon: {
                        DefaultBackgroundPresetPreview(preset: preset)
                    }
                    .tag(preset)
                }
            }

            DefaultBackgroundPreviewCard(settings: viewModel.settings.defaultBackground)
                .frame(height: 88)
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))

            VStack(alignment: .leading, spacing: 8) {
                Text("Blur: \(Int(viewModel.settings.defaultBackground.blurRadius)) pt")
                Slider(
                    value: $viewModel.settings.defaultBackground.blurRadius,
                    in: 24...80,
                    step: 1
                )
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Overlay: \(Int(viewModel.settings.defaultBackground.overlayOpacity * 100))%")
                Slider(
                    value: $viewModel.settings.defaultBackground.overlayOpacity,
                    in: 0.10...0.50,
                    step: 0.01
                )
            }
        } header: {
            Text("Default Background")
        } footer: {
            Text("Used when no image is selected. Appears blurred across the app, preview, slides, and external display.")
        }
    }

    @ViewBuilder
    private func presentationSection(
        title: String,
        description: String,
        settings: Binding<PresentationTextSettings>
    ) -> some View {
        Section {
            Toggle("Adaptive text scaling", isOn: settings.isAdaptiveScalingEnabled)

            VStack(alignment: .leading, spacing: 8) {
                Text("Maximum font size: \(Int(settings.wrappedValue.maxFontSize)) pt")
                Slider(value: settings.maxFontSize, in: 20...120, step: 1)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Minimum font size: \(Int(settings.wrappedValue.minFontSize)) pt")
                Slider(value: settings.minFontSize, in: 8...48, step: 1)
            }

            Picker("Font weight", selection: settings.fontWeight) {
                ForEach(PresentationFontWeight.allCases) { weight in
                    Text(weight.label).tag(weight)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Padding: \(Int(settings.wrappedValue.paddingRatio * 100))%")
                Slider(value: settings.paddingRatio, in: 0.02...0.16, step: 0.01)
            }
        } header: {
            Text(title)
        } footer: {
            Text(description)
        }
    }
}

private struct DefaultBackgroundPresetPreview: View {
    let preset: DefaultBackgroundPreset

    var body: some View {
        RoundedRectangle(cornerRadius: 4, style: .continuous)
            .fill(preset.linearGradient)
            .frame(width: 28, height: 18)
    }
}

private struct DefaultBackgroundPreviewCard: View {
    let settings: DefaultBackgroundSettings

    var body: some View {
        BlurredBackgroundLayer(
            blurRadius: settings.blurRadius,
            overlayOpacity: settings.overlayOpacity
        ) {
            ConfigurableDefaultGradientView(settings: settings)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
