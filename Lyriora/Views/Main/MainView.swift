//
//  MainView.swift
//  Lyriora
//

import SwiftUI

struct MainView: View {
    @Bindable var viewModel: AppViewModel

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var mediaSidebarVisibility = NavigationSplitViewVisibility.automatic
    #endif

    var body: some View {
        ZStack {
            AppBackgroundView(
                background: viewModel.activePresentationBackground,
                defaultBackgroundSettings: viewModel.settings.defaultBackground,
                blurBackground: true
            )

            adaptiveWorkspace
        }
        .onAppear {
            viewModel.loadInitialData()
            viewModel.startSimplePlaySyncService()
            viewModel.externalDisplayManager.refreshDisplayInfo()
        }
        #if !os(macOS)
        .fullScreenCover(item: $viewModel.lyricEditorLaunch) { launch in
            NavigationStack {
                LyricEditorView(
                    viewModel: viewModel,
                    existingLyricID: launch.existingLyricID
                )
            }
            .tint(.primary)
        }
        #endif
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
        .sheet(isPresented: $viewModel.isPlaylistPickerPresented) {
            PlaylistPickerSheet(
                viewModel: viewModel,
                kind: viewModel.playlistPickerKind
            )
        }
        .sheet(isPresented: $viewModel.isPlaylistEditorPresented) {
            PlaylistEditorSheet(
                viewModel: viewModel,
                kind: viewModel.playlistPickerKind,
                playlistID: viewModel.playlistEditorTargetID
            )
        }
    }

    @ViewBuilder
    private var adaptiveWorkspace: some View {
        #if os(iOS)
        GeometryReader { geometry in
            Group {
                if WorkspaceDevice.isPhone {
                    if geometry.size.height > geometry.size.width {
                        iPhonePortraitPrompt
                    } else {
                        iPhoneLandscapeWorkspace
                    }
                } else if geometry.size.height > geometry.size.width {
                    iPadPortraitWorkspace
                } else {
                    landscapeWorkspace
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        #else
        landscapeWorkspace
        #endif
    }

    private var landscapeWorkspace: some View {
        HStack(spacing: WorkspaceLayout.panelSpacing) {
            MediaLibraryPanelView(viewModel: viewModel)
                .frame(width: WorkspaceLayout.leftPanelWidth)

            CenterPanelView(viewModel: viewModel)
                .frame(maxWidth: .infinity)

            LyricsLibraryPanelView(viewModel: viewModel)
                .frame(width: WorkspaceLayout.rightPanelWidth)
        }
        .padding(WorkspaceLayout.outerPadding)
    }

    #if os(iOS)
    private var iPhoneLandscapeWorkspace: some View {
        NavigationSplitView(columnVisibility: $mediaSidebarVisibility) {
            mediaSidebarColumn(
                horizontalInset: WorkspaceLayout.iPhoneSidebarContentInset,
                verticalInset: WorkspaceLayout.iPhoneOuterPadding,
                width: WorkspaceLayout.iPhoneSidebarWidth
            )
        } detail: {
            iPhoneLandscapeDetailWorkspace
                .toolbar(removing: .sidebarToggle)
                .toolbar(.hidden, for: .navigationBar)
                .ignoresSafeArea(edges: .top)
        }
        .navigationSplitViewStyle(.balanced)
        .toolbarBackground(.hidden, for: .navigationBar)
        .background(Color.clear)
        .clearNavigationSplitViewBackground()
        .environment(\.workspaceCompactLayout, true)
        .onAppear(perform: configureIPhoneSidebarVisibility)
    }

    private var iPhoneLandscapeDetailWorkspace: some View {
        GeometryReader { geometry in
            HStack(alignment: .top, spacing: WorkspaceLayout.iPhonePanelSpacing) {
                CenterPanelView(viewModel: viewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .safeAreaInset(edge: .bottom, spacing: WorkspaceLayout.iPhonePanelSpacing) {
                        WorkspaceDisplayToolbar(viewModel: viewModel)
                    }

                LyricsLibraryPanelView(viewModel: viewModel)
                    .frame(width: WorkspaceLayout.iPhoneLyricsPanelWidth)
                    .frame(maxHeight: .infinity)
            }
            .padding(WorkspaceLayout.iPhoneOuterPadding)
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
        }
    }

    private var iPadPortraitWorkspace: some View {
        NavigationSplitView(columnVisibility: $mediaSidebarVisibility) {
            mediaSidebarColumn(
                horizontalInset: WorkspaceLayout.portraitSidebarContentInset,
                verticalInset: WorkspaceLayout.portraitSidebarVerticalInset,
                width: WorkspaceLayout.portraitSidebarWidth
            )
        } detail: {
            iPadPortraitDetailWorkspace
        }
        .navigationSplitViewStyle(.balanced)
        .toolbarBackground(.hidden, for: .navigationBar)
        .background(Color.clear)
        .clearNavigationSplitViewBackground()
    }

    private func mediaSidebarColumn(
        horizontalInset: CGFloat,
        verticalInset: CGFloat,
        width: CGFloat
    ) -> some View {
        MediaLibraryPanelView(viewModel: viewModel)
            .padding(.horizontal, horizontalInset)
            .padding(.vertical, verticalInset)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationSplitViewColumnWidth(min: width, ideal: width, max: width + 20)
    }

    private func configureIPhoneSidebarVisibility() {
        mediaSidebarVisibility = horizontalSizeClass == .regular ? .all : .detailOnly
    }

    private var iPhonePortraitPrompt: some View {
        VStack(spacing: 16) {
            Image(systemName: "iphone.landscape")
                .font(.system(size: 52, weight: .medium))
                .foregroundStyle(.secondary)

            Text("Rotate iPhone to Landscape")
                .font(.title3.weight(.semibold))

            Text("Lyriora is designed for landscape on iPhone.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(32)
    }

    private var iPadPortraitDetailWorkspace: some View {
        VStack(spacing: WorkspaceLayout.panelSpacing) {
            CenterPanelView(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            LyricsLibraryPanelView(viewModel: viewModel)
                .frame(maxWidth: .infinity)
                .frame(minHeight: 160, maxHeight: 220)
        }
        .frame(maxWidth: WorkspaceLayout.portraitContentMaxWidth)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, WorkspaceLayout.portraitOuterPadding)
        .padding(.vertical, WorkspaceLayout.outerPadding)
        .background(Color.clear)
    }
    #endif
}

private enum WorkspaceLayout {
    static let leftPanelWidth: CGFloat = 236
    static let rightPanelWidth: CGFloat = 256
    static let panelSpacing: CGFloat = 16
    static let outerPadding: CGFloat = 20
    static let portraitSidebarWidth: CGFloat = 232
    static let portraitSidebarContentInset: CGFloat = 14
    static let portraitSidebarVerticalInset: CGFloat = 8
    static let portraitContentMaxWidth: CGFloat = 460
    static let portraitOuterPadding: CGFloat = 12
    static let iPhoneSidebarWidth: CGFloat = 228
    static let iPhoneSidebarContentInset: CGFloat = 10
    static var iPhoneLyricsPanelWidth: CGFloat {
        iPhoneSidebarWidth - iPhoneSidebarContentInset * 2
    }
    static let iPhonePanelSpacing: CGFloat = 8
    static let iPhoneOuterPadding: CGFloat = 8
}

#Preview {
    MainView(viewModel: AppViewModel())
}
