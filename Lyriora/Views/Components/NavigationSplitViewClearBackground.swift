//
//  NavigationSplitViewClearBackground.swift
//  Lyriora
//

import SwiftUI

#if os(iOS)
import UIKit

extension View {
    func clearNavigationSplitViewBackground() -> some View {
        background(NavigationSplitViewBackgroundClearer())
    }
}

private struct NavigationSplitViewBackgroundClearer: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        ClearerAnchorView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        (uiView as? ClearerAnchorView)?.apply()
    }

    private final class ClearerAnchorView: UIView {
        override func didMoveToWindow() {
            super.didMoveToWindow()
            apply()
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            apply()
        }

        func apply() {
            guard let rootViewController = window?.rootViewController else { return }
            clearBackgrounds(in: rootViewController)
        }

        private func clearBackgrounds(in viewController: UIViewController) {
            if let splitViewController = viewController as? UISplitViewController {
                splitViewController.view.backgroundColor = .clear
                splitViewController.viewControllers.forEach { child in
                    child.view.backgroundColor = .clear
                    if let navigationController = child as? UINavigationController {
                        navigationController.view.backgroundColor = .clear
                        navigationController.viewControllers.forEach { $0.view.backgroundColor = .clear }
                    }
                }
            }

            for child in viewController.children {
                clearBackgrounds(in: child)
            }

            if let presented = viewController.presentedViewController {
                clearBackgrounds(in: presented)
            }
        }
    }
}
#endif
