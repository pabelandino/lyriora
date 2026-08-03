//
//  MainView.swift
//  Lyriora
//

import SwiftUI

struct MainView: View {
    @Bindable var viewModel: AppViewModel

    var body: some View {
        ZStack {
            AppBackgroundView(
                background: viewModel.activePresentationBackground,
                defaultBackgroundSettings: viewModel.settings.defaultBackground,
                blurBackground: false
            )

            HStack(spacing: 20) {
                MediaLibraryPanelView(viewModel: viewModel)
                    .frame(width: 280)

                CenterPanelView(viewModel: viewModel)
                    .frame(maxWidth: .infinity)

                LyricsLibraryPanelView(viewModel: viewModel)
                    .frame(width: 300)
            }
            .padding(24)
        }
        .onAppear {
            viewModel.loadInitialData()
            viewModel.externalDisplayManager.refreshDisplayInfo()
        }
        .sheet(isPresented: $viewModel.isNewLyricSheetPresented) {
            NewLyricSheet(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.isDisplayInfoSheetPresented) {
            DisplayInfoSheet(
                displayInfo: viewModel.externalDisplayManager.displayInfo,
                isPresentationEnabled: viewModel.externalDisplayManager.isPresentationEnabled,
                isPresentationActive: viewModel.externalDisplayManager.isPresentationActive,
                onRefreshPresentation: viewModel.refreshExternalPresentation
            )
        }
        .sheet(isPresented: $viewModel.isSettingsSheetPresented) {
            SettingsSheet(viewModel: viewModel)
        }
    }
}

#Preview {
    MainView(viewModel: AppViewModel())
}
