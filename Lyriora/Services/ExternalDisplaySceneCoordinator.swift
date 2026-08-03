//
//  ExternalDisplaySceneCoordinator.swift
//  Lyriora
//

import Foundation

#if canImport(UIKit)
import UIKit

@MainActor
final class ExternalDisplaySceneCoordinator {
    static let shared = ExternalDisplaySceneCoordinator()

    weak var manager: ExternalDisplayManager?
    private(set) weak var activeScene: UIWindowScene?

    private init() {}

    func register(manager: ExternalDisplayManager) {
        self.manager = manager

        if let activeScene {
            manager.handleExternalSceneConnected(activeScene)
        }
    }

    func setActiveScene(_ scene: UIWindowScene) {
        activeScene = scene
    }

    func clearActiveScene(_ scene: UIWindowScene) {
        if activeScene === scene {
            activeScene = nil
        }
    }

    func clearAllScenes() {
        activeScene = nil
    }

    func sceneConnected(_ scene: UIWindowScene) {
        activeScene = scene
        manager?.handleExternalSceneConnected(scene)
    }

    func sceneDisconnected(_ scene: UIWindowScene) {
        clearActiveScene(scene)
        manager?.handleExternalSceneDisconnected(scene)
    }

    func sceneGeometryDidChange(_ scene: UIWindowScene) {
        guard activeScene === scene else { return }
        manager?.handleExternalSceneGeometryChanged(scene)
    }
}
#endif
