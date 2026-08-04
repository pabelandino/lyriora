//
//  KeyboardDismissal.swift
//  Lyriora
//

import Foundation

enum KeyboardDismissal {
    static func dismissIfNeeded() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
        #elseif os(macOS)
        NSApp.keyWindow?.makeFirstResponder(nil)
        #endif
    }
}

#if canImport(UIKit)
import UIKit
#elseif os(macOS)
import AppKit
#endif
