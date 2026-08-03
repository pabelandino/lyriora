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
                textConfiguration: PresentationTextConfiguration(settings: viewModel.settings.preview),
                defaultBackgroundSettings: viewModel.settings.defaultBackground
            )
                .frame(maxHeight: .infinity)

            SlideGridView(
                slides: viewModel.selectedLyric?.slides ?? [],
                selectedSlideIndex: viewModel.selectedSlideIndex,
                presentationState: viewModel.presentationState,
                defaultBackgroundSettings: viewModel.settings.defaultBackground,
                onSelect: viewModel.selectSlide
            )
            .frame(height: 220)

            displayToolbar
        }
    }

    private var presentationToolbar: some View {
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
    }

    private var displayToolbar: some View {
        GlassCapsuleToolbar {
            GlassIconButton(systemName: "info.circle", accessibilityLabel: "Display information") {
                viewModel.externalDisplayManager.refreshDisplayInfo()
                viewModel.isDisplayInfoSheetPresented = true
            }

            GlassIconButton(
                systemName: "display",
                accessibilityLabel: viewModel.externalDisplayManager.isPresentationEnabled
                    ? "Disable external display"
                    : "Enable external display",
                size: .prominent,
                isActive: viewModel.externalDisplayManager.isPresentationEnabled
            ) {
                viewModel.toggleExternalDisplay()
            }

            GlassIconButton(systemName: "gearshape", accessibilityLabel: "Settings") {
                viewModel.isSettingsSheetPresented = true
            }
        }
    }
}
