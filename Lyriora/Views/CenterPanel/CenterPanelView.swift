//
//  CenterPanelView.swift
//  Lyriora
//

import SwiftUI

struct CenterPanelView: View {
    @Bindable var viewModel: AppViewModel
    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout

    var body: some View {
        VStack(spacing: workspaceCompactLayout ? 6 : 16) {
            presentationToolbar

            PresentationPreviewView(
                viewModel: viewModel,
                state: viewModel.presentationState,
                fallbackConfiguration: PresentationTextConfiguration(settings: viewModel.settings.externalDisplay),
                defaultBackgroundSettings: viewModel.settings.defaultBackground,
                backgroundContentMode: viewModel.settings.backgroundContentMode,
                presentationCanvasSize: viewModel.externalDisplayManager.presentationCanvasSize,
                displayInfo: viewModel.externalDisplayManager.displayInfo
            )
            .id(viewModel.externalDisplayManager.layoutRevision)
            .frame(maxWidth: .infinity, maxHeight: workspaceCompactLayout ? .infinity : nil)
            .layoutPriority(workspaceCompactLayout ? 1 : 0)
            .transaction { transaction in
                transaction.disablesAnimations = true
            }

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
            .frame(height: workspaceCompactLayout ? 84 : 220)
            .transaction { transaction in
                transaction.disablesAnimations = true
            }

            if !workspaceCompactLayout {
                WorkspaceDisplayToolbar(viewModel: viewModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(alignment: .topTrailing) {
            BackgroundFitToolbar(
                contentMode: $viewModel.settings.backgroundContentMode,
                isEnabled: viewModel.hasCustomBackgroundSelected && viewModel.showBackground,
                onChange: {
                    viewModel.saveSettings()
                    viewModel.refreshExternalPresentation()
                }
            )
        }
    }

    private var presentationToolbar: some View {
        HStack(alignment: .center, spacing: workspaceCompactLayout ? 8 : 16) {
            PresentationActionsToolbar(
                showsVideoControls: viewModel.showsVideoPlaybackControls,
                playbackMode: viewModel.videoPlaybackMode,
                isVideoPlaying: viewModel.isVideoPlaying,
                hasCustomBackgroundSelected: viewModel.hasCustomBackgroundSelected,
                showLyrics: viewModel.showLyrics,
                onClearAll: viewModel.clearAll,
                onClearBackground: viewModel.clearBackground,
                onClearLyrics: viewModel.clearLyrics,
                onToggleVideoMode: viewModel.toggleVideoPlaybackMode,
                onToggleVideoPlayback: viewModel.toggleVideoPlayback,
                onStopVideo: viewModel.stopVideo
            )

            Spacer(minLength: 0)

            Color.clear
                .frame(
                    width: BackgroundFitToolbar.Layout.reservedSize,
                    height: BackgroundFitToolbar.Layout.reservedSize
                )
                .accessibilityHidden(true)
        }
    }
}

struct WorkspaceDisplayToolbar: View {
    @Bindable var viewModel: AppViewModel

    var body: some View {
        GlassCapsuleToolbar {
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
