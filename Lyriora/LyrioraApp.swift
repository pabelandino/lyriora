//
//  LyrioraApp.swift
//  Lyriora
//

import SwiftUI

@main
struct LyrioraApp: App {
    @State private var viewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
                #if os(macOS)
                .macHiddenTitleBarWindow()
                #endif
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 1320, height: 880)
        #endif

        #if os(macOS)
        WindowGroup(id: "lyric-editor", for: LyricEditorLaunch.self) { $launch in
            if let launch {
                LyricEditorView(
                    viewModel: viewModel,
                    existingLyricID: launch.existingLyricID
                )
                .macHiddenTitleBarWindow()
            }
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 1100, height: 780)
        #endif
    }
}
