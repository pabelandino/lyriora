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
        }
    }
}
