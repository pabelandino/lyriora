//
//  WorkspaceCompactLayout.swift
//  Lyriora
//

import SwiftUI

#if os(iOS)
import UIKit
#endif

private struct WorkspaceCompactLayoutKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var workspaceCompactLayout: Bool {
        get { self[WorkspaceCompactLayoutKey.self] }
        set { self[WorkspaceCompactLayoutKey.self] = newValue }
    }
}

#if os(iOS)
enum WorkspaceDevice {
    static var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }

    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}
#endif
