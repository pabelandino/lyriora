//
//  CenterPanelView.swift
//  Lyriora
//

import SwiftUI

struct CenterPanelView: View {
    @Bindable var viewModel: AppViewModel

    var body: some View {
        VStack(spacing: 16) {
            presentationToolbar

            PresentationPreviewView(
                state: viewModel.presentationState,
                fallbackConfiguration: PresentationTextConfiguration(settings: viewModel.settings.externalDisplay),
                defaultBackgroundSettings: viewModel.settings.defaultBackground,
                backgroundContentMode: viewModel.settings.backgroundContentMode,
                presentationCanvasSize: viewModel.externalDisplayManager.presentationCanvasSize,
                displayInfo: viewModel.externalDisplayManager.displayInfo
            )
            .id(viewModel.externalDisplayManager.layoutRevision)
            .frame(maxWidth: .infinity)

            SlideGridView(
                slides: viewModel.selectedLyricSlides,
                styleProfile: viewModel.selectedLyric?.styleProfile,
                language: viewModel.selectedLyric?.language ?? .unknown,
                selectedSlideIndex: viewModel.selectedSlideIndex,
                presentationState: viewModel.presentationState,
                defaultBackgroundSettings: viewModel.settings.defaultBackground,
                backgroundContentMode: viewModel.settings.backgroundContentMode,
                presentationCanvasSize: viewModel.externalDisplayManager.presentationCanvasSize,
                onSelect: viewModel.selectSlide
            )
            .frame(height: 220)

            displayToolbar
        }
        .overlay(alignment: .topTrailing) {
            BackgroundFitToolbar(
                contentMode: $viewModel.settings.backgroundContentMode,
                isEnabled: viewModel.hasCustomBackgroundSelected && viewModel.showBackground
            ) {
                viewModel.saveSettings()
                viewModel.refreshExternalPresentation()
            }
        }
    }

    private var presentationToolbar: some View {
        HStack(alignment: .top, spacing: 16) {
            GlassCapsuleToolbar {
                GlassIconButton(systemName: "xmark.circle", accessibilityLabel: "Clear all") {
                    viewModel.clearAll()
                }

                GlassIconButton(
                    systemName: "photo",
                    accessibilityLabel: "Clear background",
                    isActive: viewModel.hasCustomBackgroundSelected
                ) {
                    viewModel.clearBackground()
                }

                GlassIconButton(
                    systemName: "doc.text",
                    accessibilityLabel: "Clear lyrics",
                    isActive: viewModel.showLyrics
                ) {
                    viewModel.clearLyrics()
                }
            }

            Spacer(minLength: 0)

            Color.clear
                .frame(
                    width: BackgroundFitToolbar.Layout.reservedSize,
                    height: BackgroundFitToolbar.Layout.reservedSize
                )
                .accessibilityHidden(true)
        }
    }

    private var displayToolbar: some View {
        GlassCapsuleToolbar {
            GlassIconButton(
                systemName: "arrow.up.left.and.arrow.down.right",
                accessibilityLabel: "Rescale external display content",
                isActive: viewModel.externalDisplayManager.isPresentationActive,
                isEnabled: viewModel.externalDisplayManager.isExternalDisplayConnected
                    && viewModel.externalDisplayManager.isPresentationEnabled
            ) {
                viewModel.refreshExternalPresentation()
            }

            GlassIconButton(systemName: "info.circle", accessibilityLabel: "Display information") {
                viewModel.externalDisplayManager.refreshDisplayInfo()
                viewModel.isDisplayInfoSheetPresented = true
            }

            GlassIconButton(
                systemName: "display",
                accessibilityLabel: displayButtonAccessibilityLabel,
                size: .prominent,
                isActive: viewModel.externalDisplayManager.isPresentationEnabled
                    && viewModel.externalDisplayManager.isExternalDisplayConnected,
                isEnabled: viewModel.externalDisplayManager.isExternalDisplayConnected
                    || viewModel.externalDisplayManager.isPresentationEnabled
            ) {
                viewModel.toggleExternalDisplay()
            }

            GlassIconButton(systemName: "gearshape", accessibilityLabel: "Settings") {
                viewModel.isSettingsSheetPresented = true
            }
        }
    }

    private var displayButtonAccessibilityLabel: String {
        if !viewModel.externalDisplayManager.isExternalDisplayConnected {
            return "External display not connected"
        }
        return viewModel.externalDisplayManager.isPresentationEnabled
            ? "Disable external display"
            : "Enable external display"
    }
}
