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
    private(set) var layoutRevision = 0
    private(set) var presentationCanvasSize: CGSize = .zero

    /// User intent: presentation should be shown when a display is available.
    var isPresentationEnabled = false

    /// Whether content is currently visible on an external display.
    private(set) var isPresentationActive = false

    var isExternalDisplayConnected: Bool {
        displayInfo.isConnected
    }

    #if canImport(UIKit)
    private var externalWindow: UIWindow?
    private var containerViewController: ExternalPresentationContainerViewController?
    private weak var externalScene: UIWindowScene?
    private weak var hostedViewModel: AppViewModel?
    private nonisolated(unsafe) var observers: [NSObjectProtocol] = []
    #endif

    #if os(macOS)
    private var externalWindowController: NSWindowController?
    private weak var hostedViewModel: AppViewModel?
    private nonisolated(unsafe) var observers: [NSObjectProtocol] = []
    #endif

    init() {
        #if canImport(UIKit)
        ExternalDisplaySceneCoordinator.shared.register(manager: self)
        registerScreenObservers()
        #elseif os(macOS)
        registerObservers()
        #endif
        refreshDisplayInfo()
    }

    deinit {
        #if canImport(UIKit) || os(macOS)
        for observer in observers {
            NotificationCenter.default.removeObserver(observer)
        }
        #endif
    }

    func refreshDisplayInfo() {
        #if canImport(UIKit)
        if let scene = discoverExternalScene() {
            externalScene = scene
            updateDisplayInfo(from: scene)
            return
        }

        if let screen = discoverExternalScreen() {
            externalScene = nil
            presentationCanvasSize = screen.bounds.size
            displayInfo = ExternalDisplayInfo(
                name: "External Display",
                resolution: screen.bounds.size,
                scale: screen.scale,
                isConnected: true
            )
            return
        }

        externalScene = nil
        displayInfo = .unavailable
        presentationCanvasSize = .zero
        #elseif os(macOS)
        if let screen = externalScreen() {
            displayInfo = ExternalDisplayInfo(
                name: screen.localizedName,
                resolution: screen.frame.size,
                scale: screen.backingScaleFactor,
                isConnected: true
            )
            presentationCanvasSize = screen.frame.size
        } else {
            displayInfo = .unavailable
            presentationCanvasSize = .zero
        }
        #else
        displayInfo = .unavailable
        #endif
    }

    func setPresentationEnabled(_ enabled: Bool, viewModel: AppViewModel) {
        if enabled {
            guard isExternalDisplayConnected else { return }
            hostedViewModel = viewModel
            isPresentationEnabled = true
            presentIfPossible()
        } else {
            isPresentationEnabled = false
            hostedViewModel = nil
            teardownPresentationWindow()
            isPresentationActive = false
        }
    }

    func refreshPresentation() {
        refreshDisplayInfo()
        bumpLayoutRevision()

        guard isPresentationEnabled, hostedViewModel != nil, isExternalDisplayConnected else { return }

        teardownPresentationWindow()
        presentIfPossible()
    }

    #if canImport(UIKit)
    func handleExternalSceneConnected(_ scene: UIWindowScene) {
        externalScene = scene
        ExternalDisplaySceneCoordinator.shared.setActiveScene(scene)
        updateDisplayInfo(from: scene)
        handleDisplayAvailabilityChanged()
    }

    func handleExternalSceneDisconnected(_ scene: UIWindowScene) {
        guard externalScene == nil || externalScene === scene else { return }

        externalScene = nil
        ExternalDisplaySceneCoordinator.shared.clearActiveScene(scene)
        refreshDisplayInfo()
        teardownPresentationWindow()
    }

    func handleExternalSceneGeometryChanged(_ scene: UIWindowScene) {
        guard externalScene === scene || discoverExternalScene() === scene else { return }

        externalScene = scene
        updateDisplayInfo(from: scene)
        bumpLayoutRevision()

        guard isPresentationEnabled, hostedViewModel != nil else { return }

        teardownPresentationWindow()
        presentIfPossible(on: scene)
        scheduleDeferredRelayout(on: scene)
    }

    private func handleDisplayAvailabilityChanged() {
        refreshDisplayInfo()
        bumpLayoutRevision()

        if isExternalDisplayConnected {
            guard isPresentationEnabled, hostedViewModel != nil else { return }
            teardownPresentationWindow()
            presentIfPossible()
        } else {
            teardownPresentationWindow()
        }
    }

    private func presentIfPossible(on scene: UIWindowScene? = nil) {
        guard isPresentationEnabled, let viewModel = hostedViewModel else {
            isPresentationActive = false
            return
        }

        guard isExternalDisplayConnected else {
            isPresentationActive = false
            return
        }

        let targetScene = scene ?? discoverExternalScene()
        guard let targetScene else {
            isPresentationActive = false
            schedulePresentationRetry(viewModel: viewModel)
            return
        }

        if showPresentation(on: targetScene, viewModel: viewModel) {
            isPresentationActive = true
            scheduleDeferredRelayout(on: targetScene)
        } else {
            isPresentationActive = false
            schedulePresentationRetry(viewModel: viewModel)
        }
    }

    @discardableResult
    private func showPresentation(on scene: UIWindowScene, viewModel: AppViewModel) -> Bool {
        hostedViewModel = viewModel
        externalScene = scene

        let bounds = scene.screen.bounds
        guard bounds.width > 1, bounds.height > 1 else {
            return false
        }

        presentationCanvasSize = bounds.size
        updateDisplayInfo(from: scene)

        teardownPresentationWindow()

        let window = UIWindow(windowScene: scene)
        let container = ExternalPresentationContainerViewController()
        container.onBoundsChange = { [weak self] size in
            self?.handleContainerBoundsChange(size)
        }

        updatePresentationContent(in: container, viewModel: viewModel)

        window.rootViewController = container
        window.isHidden = false
        window.makeKeyAndVisible()

        externalWindow = window
        containerViewController = container
        return true
    }

    private func updatePresentationContent(
        in container: ExternalPresentationContainerViewController,
        viewModel: AppViewModel
    ) {
        container.setContent(
            ExternalPresentationView(
                viewModel: viewModel,
                layoutRevision: layoutRevision
            )
        )
    }

    private func handleContainerBoundsChange(_ size: CGSize) {
        guard isPresentationEnabled, hostedViewModel != nil else { return }
        guard size.width > 1, size.height > 1 else { return }
        guard size != presentationCanvasSize else { return }

        presentationCanvasSize = size
        displayInfo = ExternalDisplayInfo(
            name: displayInfo.name,
            resolution: size,
            scale: displayInfo.scale,
            isConnected: true
        )
        bumpLayoutRevision()

        guard let container = containerViewController,
              let viewModel = hostedViewModel else { return }
        updatePresentationContent(in: container, viewModel: viewModel)
    }

    private func scheduleDeferredRelayout(on scene: UIWindowScene) {
        guard let viewModel = hostedViewModel else { return }

        for delayMilliseconds in [0, 150, 400, 800] {
            Task { @MainActor in
                if delayMilliseconds > 0 {
                    try? await Task.sleep(for: .milliseconds(delayMilliseconds))
                }
                guard isPresentationEnabled,
                      hostedViewModel === viewModel,
                      externalScene === scene else { return }

                containerViewController?.view.layoutIfNeeded()
                let containerSize = containerViewController?.view.bounds.size ?? .zero
                let sceneSize = scene.screen.bounds.size
                let resolvedSize = containerSize.width > 1 ? containerSize : sceneSize

                guard resolvedSize.width > 1, resolvedSize.height > 1 else { return }

                if resolvedSize != presentationCanvasSize {
                    presentationCanvasSize = resolvedSize
                    displayInfo = ExternalDisplayInfo(
                        name: displayInfo.name,
                        resolution: resolvedSize,
                        scale: scene.screen.scale,
                        isConnected: true
                    )
                    bumpLayoutRevision()
                }

                if let container = containerViewController {
                    updatePresentationContent(in: container, viewModel: viewModel)
                } else {
                    _ = showPresentation(on: scene, viewModel: viewModel)
                }
            }
        }
    }

    private func schedulePresentationRetry(viewModel: AppViewModel, attempt: Int = 0) {
        guard hostedViewModel === viewModel, isPresentationEnabled else { return }
        guard attempt < 8 else {
            isPresentationActive = false
            return
        }

        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(350))
            guard hostedViewModel === viewModel, isPresentationEnabled else { return }

            refreshDisplayInfo()

            if let scene = discoverExternalScene(),
               showPresentation(on: scene, viewModel: viewModel) {
                isPresentationActive = true
                scheduleDeferredRelayout(on: scene)
                return
            }

            schedulePresentationRetry(viewModel: viewModel, attempt: attempt + 1)
        }
    }

    private func discoverExternalScene() -> UIWindowScene? {
        if let externalScene {
            return externalScene
        }

        if let coordinatorScene = ExternalDisplaySceneCoordinator.shared.activeScene {
            return coordinatorScene
        }

        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }

        if let externalScene = scenes.first(where: { $0.session.role == .windowExternalDisplayNonInteractive }) {
            return externalScene
        }

        return scenes.first { $0.screen != UIScreen.main }
    }

    private func discoverExternalScreen() -> UIScreen? {
        if let scene = discoverExternalScene() {
            return scene.screen
        }

        return UIScreen.screens.first { $0 != UIScreen.main }
    }

    private func updateDisplayInfo(from scene: UIWindowScene) {
        let screen = scene.screen
        let bounds = screen.bounds.size
        presentationCanvasSize = bounds
        displayInfo = ExternalDisplayInfo(
            name: "External Display",
            resolution: bounds,
            scale: screen.scale,
            isConnected: true
        )
    }

    private func registerScreenObservers() {
        let screenConnect = NotificationCenter.default.addObserver(
            forName: UIScreen.didConnectNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.handleDisplayAvailabilityChanged()
            }
        }

        let screenDisconnect = NotificationCenter.default.addObserver(
            forName: UIScreen.didDisconnectNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.externalScene = nil
                ExternalDisplaySceneCoordinator.shared.clearAllScenes()
                self?.handleDisplayAvailabilityChanged()
            }
        }

        let screenModeChange = NotificationCenter.default.addObserver(
            forName: UIScreen.modeDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                guard let self else { return }
                guard let scene = self.discoverExternalScene() else {
                    self.refreshDisplayInfo()
                    return
                }
                self.handleExternalSceneGeometryChanged(scene)
            }
        }

        let sceneActivate = NotificationCenter.default.addObserver(
            forName: UIScene.didActivateNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            Task { @MainActor in
                guard let scene = notification.object as? UIWindowScene,
                      scene.screen != UIScreen.main else { return }
                self?.handleExternalSceneConnected(scene)
            }
        }

        let sceneConnect = NotificationCenter.default.addObserver(
            forName: UIScene.willConnectNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            Task { @MainActor in
                guard let scene = notification.object as? UIWindowScene,
                      scene.screen != UIScreen.main else { return }
                self?.handleExternalSceneConnected(scene)
            }
        }

        observers = [screenConnect, screenDisconnect, screenModeChange, sceneActivate, sceneConnect]
    }

    private func teardownPresentationWindow() {
        containerViewController?.reset()
        containerViewController = nil
        externalWindow?.isHidden = true
        externalWindow?.rootViewController = nil
        externalWindow = nil
        isPresentationActive = false
    }
    #endif

    #if os(macOS)
    private func presentIfPossible() {
        guard isPresentationEnabled, let viewModel = hostedViewModel else {
            isPresentationActive = false
            return
        }

        if showPresentation(viewModel: viewModel) {
            isPresentationActive = true
        } else {
            isPresentationActive = false
        }
    }

    @discardableResult
    private func showPresentation(viewModel: AppViewModel) -> Bool {
        hostedViewModel = viewModel

        let window: NSWindow
        if let existingWindow = externalWindowController?.window {
            window = existingWindow
        } else {
            window = NSWindow(
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

        if let screen = externalScreen() {
            window.setFrame(screen.frame, display: true)
            presentationCanvasSize = screen.frame.size
        }

        window.contentView = NSHostingView(
            rootView: ExternalPresentationView(
                viewModel: viewModel,
                layoutRevision: layoutRevision
            )
        )
        externalWindowController?.showWindow(nil)
        return true
    }

    private func teardownPresentationWindow() {
        externalWindowController?.close()
        externalWindowController = nil
        isPresentationActive = false
    }

    private func externalScreen() -> NSScreen? {
        NSScreen.screens.dropFirst().first
    }

    private func registerObservers() {
        let screenChange = NotificationCenter.default.addObserver(
            forName: NSApplication.didChangeScreenParametersNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.handleExternalDisplayChange()
            }
        }

        observers = [screenChange]
    }

    private func handleExternalDisplayChange() {
        refreshDisplayInfo()
        bumpLayoutRevision()

        guard isPresentationEnabled else {
            teardownPresentationWindow()
            return
        }

        if displayInfo.isConnected {
            refreshPresentation()
        } else {
            teardownPresentationWindow()
        }
    }
    #endif

    private func bumpLayoutRevision() {
        layoutRevision &+= 1
    }
}
