//
//  ExternalDisplayManager.swift
//  Lyriora
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

@MainActor
@Observable
final class ExternalDisplayManager {
    private(set) var displayInfo: ExternalDisplayInfo = .unavailable
    var isPresentationEnabled = false

    #if canImport(UIKit)
    private var externalWindow: UIWindow?
    private weak var hostedViewModel: AppViewModel?
    private nonisolated(unsafe) var observers: [NSObjectProtocol] = []
    #endif

    #if os(macOS)
    private var externalWindowController: NSWindowController?
    private weak var hostedViewModel: AppViewModel?
    #endif

    init() {
        refreshDisplayInfo()
        #if canImport(UIKit)
        registerObservers()
        #endif
    }

    deinit {
        #if canImport(UIKit)
        for observer in observers {
            NotificationCenter.default.removeObserver(observer)
        }
        #endif
    }

    func refreshDisplayInfo() {
        #if canImport(UIKit)
        if let windowScene = Self.externalWindowScene() {
            let screen = windowScene.screen
            displayInfo = ExternalDisplayInfo(
                name: "External Display",
                resolution: screen.bounds.size,
                scale: screen.scale,
                isConnected: true
            )
        } else {
            displayInfo = .unavailable
        }
        #elseif os(macOS)
        if let screen = NSScreen.screens.dropFirst().first ?? NSScreen.screens.first {
            displayInfo = ExternalDisplayInfo(
                name: screen.localizedName,
                resolution: screen.frame.size,
                scale: screen.backingScaleFactor,
                isConnected: NSScreen.screens.count > 1
            )
        } else {
            displayInfo = .unavailable
        }
        #else
        displayInfo = .unavailable
        #endif
    }

    func setPresentationEnabled(_ enabled: Bool, viewModel: AppViewModel) {
        if enabled {
            hostedViewModel = viewModel
            isPresentationEnabled = true

            if !showPresentation(viewModel: viewModel) {
                #if canImport(UIKit)
                schedulePresentationRetry(viewModel: viewModel)
                #endif
            }
        } else {
            isPresentationEnabled = false
            hidePresentation()
        }
    }

    @discardableResult
    private func showPresentation(viewModel: AppViewModel) -> Bool {
        hostedViewModel = viewModel

        #if canImport(UIKit)
        guard let windowScene = Self.externalWindowScene() else {
            return false
        }

        if externalWindow?.windowScene !== windowScene {
            externalWindow = nil
        }

        let window: UIWindow
        if let existingWindow = externalWindow {
            window = existingWindow
        } else {
            window = UIWindow(windowScene: windowScene)
            externalWindow = window
        }

        window.frame = windowScene.screen.bounds
        let hostingController = UIHostingController(
            rootView: ExternalPresentationView(viewModel: viewModel)
        )
        hostingController.view.backgroundColor = .black
        window.rootViewController = hostingController
        window.isHidden = false
        window.makeKeyAndVisible()
        return true
        #elseif os(macOS)
        if externalWindowController == nil {
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 1280, height: 720),
                styleMask: [.borderless, .fullSizeContentView],
                backing: .buffered,
                defer: false
            )
            window.level = .screenSaver
            window.backgroundColor = .black
            window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
            externalWindowController = NSWindowController(window: window)
        }

        if let screen = NSScreen.screens.dropFirst().first ?? NSScreen.screens.first {
            externalWindowController?.window?.setFrame(screen.frame, display: true)
        }

        externalWindowController?.window?.contentView = NSHostingView(
            rootView: ExternalPresentationView(viewModel: viewModel)
        )
        externalWindowController?.showWindow(nil)
        return true
        #else
        return false
        #endif
    }

    private func hidePresentation() {
        hostedViewModel = nil

        #if canImport(UIKit)
        externalWindow?.isHidden = true
        externalWindow?.rootViewController = nil
        #elseif os(macOS)
        externalWindowController?.close()
        externalWindowController = nil
        #endif
    }

    #if canImport(UIKit)
    private static func externalWindowScene() -> UIWindowScene? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.screen != UIScreen.main }
    }

    private func schedulePresentationRetry(viewModel: AppViewModel, attempt: Int = 0) {
        guard hostedViewModel === viewModel else { return }
        guard attempt < 5 else {
            isPresentationEnabled = false
            return
        }

        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(300))
            guard hostedViewModel === viewModel, isPresentationEnabled else { return }

            refreshDisplayInfo()
            if showPresentation(viewModel: viewModel) {
                return
            }

            schedulePresentationRetry(viewModel: viewModel, attempt: attempt + 1)
        }
    }

    private func registerObservers() {
        let screenConnect = NotificationCenter.default.addObserver(
            forName: UIScreen.didConnectNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.handleExternalDisplayChange()
        }

        let screenDisconnect = NotificationCenter.default.addObserver(
            forName: UIScreen.didDisconnectNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.handleExternalDisplayDisconnected()
        }

        let sceneActivate = NotificationCenter.default.addObserver(
            forName: UIScene.didActivateNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            guard let scene = notification.object as? UIWindowScene,
                  scene.screen != UIScreen.main else { return }
            self?.handleExternalDisplayChange()
        }

        observers = [screenConnect, screenDisconnect, sceneActivate]
    }

    private func handleExternalDisplayChange() {
        refreshDisplayInfo()

        guard let viewModel = hostedViewModel else { return }
        if showPresentation(viewModel: viewModel) {
            isPresentationEnabled = true
        }
    }

    private func handleExternalDisplayDisconnected() {
        refreshDisplayInfo()
        externalWindow = nil
        hidePresentation()
        isPresentationEnabled = false
    }
    #endif
}
