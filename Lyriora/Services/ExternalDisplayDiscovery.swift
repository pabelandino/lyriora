//
//  ExternalDisplayDiscovery.swift
//  Lyriora
//

#if canImport(UIKit)
import UIKit

enum ExternalDisplayDiscovery {
    static func externalScreens() -> [UIScreen] {
        UIScreen.screens.filter { $0 != UIScreen.main }
    }

    static func preferredExternalScreen() -> UIScreen? {
        if let scene = preferredExternalScene() {
            return scene.screen
        }

        return externalScreens().max { lhs, rhs in
            area(lhs.bounds.size) < area(rhs.bounds.size)
        }
    }

    static func configureExternalScreensForFullBounds() {
        for screen in externalScreens() {
            screen.overscanCompensation = .none
        }
    }

    static func externalWindowScenes() -> [UIWindowScene] {
        UIApplication.shared.connectedScenes.compactMap { scene in
            guard let windowScene = scene as? UIWindowScene else { return nil }
            guard isExternalWindowScene(windowScene) else { return nil }
            return windowScene
        }
    }

    static func preferredExternalScene(matching screen: UIScreen? = nil) -> UIWindowScene? {
        let scenes = externalWindowScenes()
        guard !scenes.isEmpty else { return nil }

        if let screen,
           let matchingScene = scenes.first(where: { $0.screen === screen }) {
            return matchingScene
        }

        return scenes.max { lhs, rhs in
            sceneArea(lhs) < sceneArea(rhs)
        }
    }

    static func resolvedMetrics(
        for scene: UIWindowScene? = nil,
        window: UIWindow? = nil,
        containerBounds: CGSize? = nil
    ) -> ExternalDisplayMetrics? {
        configureExternalScreensForFullBounds()

        var candidates: [ExternalDisplayMetrics] = []

        let scenes = scene.map { [$0] } ?? externalWindowScenes()
        for windowScene in scenes {
            candidates.append(contentsOf: metricsCandidates(for: windowScene))
        }

        for screen in externalScreens() {
            candidates.append(
                ExternalDisplayMetrics(
                    screen: screen,
                    bounds: screen.bounds.size,
                    scale: screen.scale,
                    source: .screenBounds
                )
            )
        }

        if let window {
            candidates.append(contentsOf: metricsCandidates(for: window))
        }

        if let containerBounds, containerBounds.width > 1, containerBounds.height > 1 {
            let scale = scene?.screen.scale ?? preferredExternalScene()?.screen.scale ?? 1
            candidates.append(
                ExternalDisplayMetrics(
                    screen: scene?.screen ?? preferredExternalScreen() ?? UIScreen.main,
                    bounds: containerBounds,
                    scale: scale,
                    source: .liveContainer
                )
            )
        }

        return candidates
            .filter { $0.bounds.width > 1 && $0.bounds.height > 1 }
            .max { lhs, rhs in
                lhs.bounds.width * lhs.bounds.height < rhs.bounds.width * rhs.bounds.height
            }
    }

    static func isExternalWindowScene(_ windowScene: UIWindowScene) -> Bool {
        if windowScene.session.role == .windowExternalDisplayNonInteractive {
            return true
        }

        if windowScene.session.role.rawValue == "UIWindowSceneSessionRoleExternalDisplay" {
            return true
        }

        return windowScene.screen != UIScreen.main
    }

    private static func metricsCandidates(for windowScene: UIWindowScene) -> [ExternalDisplayMetrics] {
        let scale = windowScene.screen.scale
        let screen = windowScene.screen

        return [
            ExternalDisplayMetrics(
                screen: screen,
                bounds: windowScene.coordinateSpace.bounds.size,
                scale: scale,
                source: .sceneCoordinateSpace
            ),
            ExternalDisplayMetrics(
                screen: screen,
                bounds: windowScene.screen.bounds.size,
                scale: scale,
                source: .screenBounds
            )
        ]
    }

    private static func metricsCandidates(for window: UIWindow) -> [ExternalDisplayMetrics] {
        let scale = window.windowScene?.screen.scale ?? 1
        let screen = window.windowScene?.screen ?? preferredExternalScreen() ?? UIScreen.main

        return [
            ExternalDisplayMetrics(
                screen: screen,
                bounds: window.bounds.size,
                scale: scale,
                source: .liveWindow
            ),
            ExternalDisplayMetrics(
                screen: screen,
                bounds: window.frame.size,
                scale: scale,
                source: .liveWindow
            )
        ]
    }

    private static func sceneArea(_ windowScene: UIWindowScene) -> CGFloat {
        let coordinateSize = windowScene.coordinateSpace.bounds.size
        let screenSize = windowScene.screen.bounds.size
        return max(area(coordinateSize), area(screenSize))
    }

    private static func area(_ size: CGSize) -> CGFloat {
        size.width * size.height
    }
}

struct ExternalDisplayMetrics: Equatable {
    enum Source: Equatable {
        case sceneCoordinateSpace
        case screenBounds
        case liveWindow
        case liveContainer
    }

    let screen: UIScreen
    let bounds: CGSize
    let scale: CGFloat
    let source: Source

    init(
        screen: UIScreen,
        bounds: CGSize,
        scale: CGFloat,
        source: Source = .screenBounds
    ) {
        self.screen = screen
        self.bounds = bounds
        self.scale = scale
        self.source = source
    }

    static func == (lhs: ExternalDisplayMetrics, rhs: ExternalDisplayMetrics) -> Bool {
        lhs.bounds == rhs.bounds && lhs.scale == rhs.scale
    }
}
#endif
