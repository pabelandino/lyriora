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
    private var lastKnownExternalBounds: CGSize = .zero
    private nonisolated(unsafe) var displayMonitorTask: Task<Void, Never>?
    private nonisolated(unsafe) var observers: [NSObjectProtocol] = []
    #endif

    #if os(macOS)
    private var externalWindowController: NSWindowController?
    private weak var hostedViewModel: AppViewModel?
    private nonisolated(unsafe) var observers: [NSObjectProtocol] = []

    private final class ExternalPresentationWindow: NSWindow {
        override var canBecomeKey: Bool { false }
        override var canBecomeMain: Bool { false }
    }
    #endif

    init() {
        #if canImport(UIKit)
        ExternalDisplaySceneCoordinator.shared.register(manager: self)
        registerScreenObservers()
        startDisplayMonitorIfNeeded()
        #elseif os(macOS)
        registerObservers()
        #endif
        refreshDisplayInfo()
    }

    deinit {
        #if canImport(UIKit)
        displayMonitorTask?.cancel()
        #endif
        #if canImport(UIKit) || os(macOS)
        for observer in observers {
            NotificationCenter.default.removeObserver(observer)
        }
        #endif
    }

    func refreshDisplayInfo() {
        #if canImport(UIKit)
        invalidateCachedExternalSceneIfNeeded()

        if let metrics = currentExternalMetrics() {
            applyMetrics(metrics)
            return
        }

        if let liveContainerSize = liveContainerSize() {
            presentationCanvasSize = liveContainerSize
            displayInfo = ExternalDisplayInfo(
                name: "External Display",
                resolution: liveContainerSize,
                scale: displayInfo.scale > 0 ? displayInfo.scale : 1,
                isConnected: true
            )
            lastKnownExternalBounds = liveContainerSize
            return
        }

        externalScene = nil
        displayInfo = .unavailable
        presentationCanvasSize = .zero
        lastKnownExternalBounds = .zero
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

        #if canImport(UIKit)
        startDisplayMonitorIfNeeded()
        #endif
    }

    func refreshPresentation() {
        #if canImport(UIKit)
        invalidateCachedExternalSceneIfNeeded()
        #endif
        refreshDisplayInfo()
        bumpLayoutRevision()

        guard isPresentationEnabled, hostedViewModel != nil, isExternalDisplayConnected else { return }

        teardownPresentationWindow()
        presentIfPossible()
    }

    #if canImport(UIKit)
    func handleExternalSceneConnected(_ scene: UIWindowScene) {
        configureConnectedExternalScreens()
        invalidateCachedExternalSceneIfNeeded()
        externalScene = preferredExternalScene() ?? scene
        ExternalDisplaySceneCoordinator.shared.setActiveScene(externalScene ?? scene)
        refreshDisplayInfo()
        handleDisplayAvailabilityChanged()
    }

    func handleExternalSceneDisconnected(_ scene: UIWindowScene) {
        externalScene = nil
        ExternalDisplaySceneCoordinator.shared.clearActiveScene(scene)
        lastKnownExternalBounds = .zero
        refreshDisplayInfo()
        teardownPresentationWindow()
    }

    func handleExternalSceneGeometryChanged(_ scene: UIWindowScene) {
        invalidateCachedExternalSceneIfNeeded()
        externalScene = preferredExternalScene() ?? scene
        refreshDisplayInfo()

        guard externalBoundsChanged() else { return }

        bumpLayoutRevision()

        guard isPresentationEnabled, hostedViewModel != nil else { return }

        teardownPresentationWindow()
        presentIfPossible()
    }

    private func handleDisplayAvailabilityChanged() {
        invalidateCachedExternalSceneIfNeeded()
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

        let targetScene = scene ?? preferredExternalScene()
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
        configureConnectedExternalScreens()

        teardownPresentationWindow()

        let window = UIWindow(windowScene: scene)
        window.frame = scene.coordinateSpace.bounds
        let container = ExternalPresentationContainerViewController()
        container.onBoundsChange = { [weak self] size in
            self?.handleContainerBoundsChange(size)
        }

        updatePresentationContent(in: container, viewModel: viewModel)

        window.rootViewController = container
        window.isHidden = false
        window.makeKeyAndVisible()
        window.layoutIfNeeded()
        container.view.layoutIfNeeded()

        externalWindow = window
        containerViewController = container

        guard currentExternalMetrics(for: scene) != nil else {
            teardownPresentationWindow()
            return false
        }

        applyLivePresentationMetrics(for: scene)
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
        lastKnownExternalBounds = size
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

        for delayMilliseconds in [0, 150, 400, 800, 1_500] {
            Task { @MainActor in
                if delayMilliseconds > 0 {
                    try? await Task.sleep(for: .milliseconds(delayMilliseconds))
                }
                guard isPresentationEnabled, hostedViewModel === viewModel else { return }

                invalidateCachedExternalSceneIfNeeded()
                applyLivePresentationMetrics(for: scene)

                guard isPresentationEnabled, hostedViewModel === viewModel else { return }
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

            invalidateCachedExternalSceneIfNeeded()
            refreshDisplayInfo()

            if let scene = preferredExternalScene(),
               showPresentation(on: scene, viewModel: viewModel) {
                isPresentationActive = true
                scheduleDeferredRelayout(on: scene)
                return
            }

            schedulePresentationRetry(viewModel: viewModel, attempt: attempt + 1)
        }
    }

    private func preferredExternalScene() -> UIWindowScene? {
        ExternalDisplayDiscovery.preferredExternalScene()
            ?? ExternalDisplaySceneCoordinator.shared.activeScene
    }

    private func currentExternalMetrics(for scene: UIWindowScene? = nil) -> ExternalDisplayMetrics? {
        ExternalDisplayDiscovery.resolvedMetrics(
            for: scene ?? preferredExternalScene(),
            window: externalWindow,
            containerBounds: liveContainerSize()
        )
    }

    private func applyLivePresentationMetrics(for scene: UIWindowScene) {
        externalWindow?.layoutIfNeeded()
        containerViewController?.view.layoutIfNeeded()

        guard let metrics = ExternalDisplayDiscovery.resolvedMetrics(
            for: scene,
            window: externalWindow,
            containerBounds: liveContainerSize()
        ) else { return }

        let didChange = metrics.bounds != presentationCanvasSize
        applyMetrics(metrics)

        if didChange, isPresentationEnabled, hostedViewModel != nil {
            bumpLayoutRevision()
            if let container = containerViewController, let viewModel = hostedViewModel {
                updatePresentationContent(in: container, viewModel: viewModel)
            }
        }
    }

    private func configureConnectedExternalScreens() {
        ExternalDisplayDiscovery.configureExternalScreensForFullBounds()
    }

    private func applyMetrics(_ metrics: ExternalDisplayMetrics) {
        presentationCanvasSize = metrics.bounds
        lastKnownExternalBounds = metrics.bounds
        displayInfo = ExternalDisplayInfo(
            name: "External Display",
            resolution: metrics.bounds,
            scale: metrics.scale,
            isConnected: true
        )
    }

    private func liveContainerSize() -> CGSize? {
        guard let size = containerViewController?.view.bounds.size,
              size.width > 1,
              size.height > 1 else {
            return nil
        }
        return size
    }

    private func externalBoundsChanged() -> Bool {
        guard let metrics = currentExternalMetrics() else {
            return lastKnownExternalBounds != .zero
        }
        return metrics.bounds != lastKnownExternalBounds
    }

    private func invalidateCachedExternalSceneIfNeeded() {
        guard let cachedScene = externalScene else { return }

        let preferredScreen = ExternalDisplayDiscovery.preferredExternalScreen()
        let preferredScene = ExternalDisplayDiscovery.preferredExternalScene(matching: preferredScreen)

        if preferredScene == nil {
            externalScene = nil
            return
        }

        if preferredScene !== cachedScene {
            externalScene = preferredScene
            return
        }

        if let preferredScreen,
           cachedScene.screen !== preferredScreen {
            externalScene = preferredScene
        }
    }

    private func syncExternalDisplayState() {
        let wasConnected = isExternalDisplayConnected
        let previousBounds = lastKnownExternalBounds

        invalidateCachedExternalSceneIfNeeded()
        refreshDisplayInfo()

        let isConnectedNow = isExternalDisplayConnected
        let boundsChanged = presentationCanvasSize != previousBounds && presentationCanvasSize != .zero

        if !wasConnected && isConnectedNow {
            handleDisplayAvailabilityChanged()
            return
        }

        if wasConnected && !isConnectedNow {
            externalScene = nil
            ExternalDisplaySceneCoordinator.shared.clearAllScenes()
            teardownPresentationWindow()
            return
        }

        if boundsChanged {
            if let scene = preferredExternalScene() ?? externalScene {
                handleExternalSceneGeometryChanged(scene)
            } else if isPresentationEnabled, hostedViewModel != nil {
                bumpLayoutRevision()
                teardownPresentationWindow()
                presentIfPossible()
            }
            return
        }

        if isPresentationEnabled,
           isConnectedNow,
           !isPresentationActive,
           hostedViewModel != nil {
            presentIfPossible()
        }
    }

    private func startDisplayMonitorIfNeeded() {
        guard displayMonitorTask == nil else { return }

        displayMonitorTask = Task { @MainActor in
            while !Task.isCancelled {
                syncExternalDisplayState()
                try? await Task.sleep(for: .seconds(displayMonitorInterval))
            }
        }
    }

    private var displayMonitorInterval: TimeInterval {
        #if targetEnvironment(simulator)
        1.0
        #else
        2.0
        #endif
    }

    private func registerScreenObservers() {
        let screenConnect = NotificationCenter.default.addObserver(
            forName: UIScreen.didConnectNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.configureConnectedExternalScreens()
                self?.externalScene = nil
                ExternalDisplaySceneCoordinator.shared.clearAllScenes()
                try? await Task.sleep(for: .milliseconds(150))
                self?.handleDisplayAvailabilityChanged()
                self?.startDisplayMonitorIfNeeded()
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
                self?.startDisplayMonitorIfNeeded()
            }
        }

        let screenModeChange = NotificationCenter.default.addObserver(
            forName: UIScreen.modeDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.externalScene = nil
                self?.syncExternalDisplayState()
            }
        }

        let sceneActivate = NotificationCenter.default.addObserver(
            forName: UIScene.didActivateNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            Task { @MainActor in
                guard let scene = notification.object as? UIWindowScene,
                      ExternalDisplayDiscovery.isExternalWindowScene(scene) else { return }
                self?.handleExternalSceneConnected(scene)
                self?.startDisplayMonitorIfNeeded()
            }
        }

        let sceneConnect = NotificationCenter.default.addObserver(
            forName: UIScene.willConnectNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            Task { @MainActor in
                guard let scene = notification.object as? UIWindowScene,
                      ExternalDisplayDiscovery.isExternalWindowScene(scene) else { return }
                self?.handleExternalSceneConnected(scene)
                self?.startDisplayMonitorIfNeeded()
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
            window = ExternalPresentationWindow(
                contentRect: NSRect(x: 0, y: 0, width: 1280, height: 720),
                styleMask: [.borderless, .fullSizeContentView],
                backing: .buffered,
                defer: false
            )
            window.level = .screenSaver
            window.backgroundColor = .black
            window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
            window.isReleasedWhenClosed = false
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
        window.orderFrontRegardless()
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
