//
//  ExternalDisplaySceneDelegate.swift
//  Lyriora
//

#if canImport(UIKit)
import UIKit

final class ExternalDisplaySceneDelegate: UIResponder, UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene,
              session.role == .windowExternalDisplayNonInteractive
                || session.role.rawValue == "UIWindowSceneSessionRoleExternalDisplay" else {
            return
        }

        Task { @MainActor in
            ExternalDisplaySceneCoordinator.shared.sceneConnected(windowScene)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else { return }

        Task { @MainActor in
            ExternalDisplaySceneCoordinator.shared.sceneDisconnected(windowScene)
        }
    }

    func scene(
        _ scene: UIScene,
        didUpdate previousCoordinateSpace: any UICoordinateSpace,
        interfaceOrientation: UIInterfaceOrientation,
        traitCollection: UITraitCollection
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        Task { @MainActor in
            ExternalDisplaySceneCoordinator.shared.sceneGeometryDidChange(windowScene)
        }
    }
}
#endif
