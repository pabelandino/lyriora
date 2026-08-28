//
//  MacWindowConfigurator.swift
//  Lyriora
//

#if os(macOS)
import AppKit
import SwiftUI

/// Applies a transparent, hidden title bar so content extends under the traffic-light controls.
struct MacWindowConfigurator: NSViewRepresentable {
    var allowsBackgroundDrag: Bool = true

    func makeNSView(context: Context) -> NSView {
        let view = NSView(frame: .zero)
        configureWindow(for: view)
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        configureWindow(for: nsView)
    }

    private func configureWindow(for view: NSView) {
        DispatchQueue.main.async {
            guard let window = view.window else { return }

            window.titlebarAppearsTransparent = true
            window.titleVisibility = .hidden
            window.styleMask.insert(.fullSizeContentView)
            window.isMovableByWindowBackground = allowsBackgroundDrag
            window.toolbar = nil
        }
    }
}

extension View {
    func macHiddenTitleBarWindow(allowsBackgroundDrag: Bool = true) -> some View {
        background(MacWindowConfigurator(allowsBackgroundDrag: allowsBackgroundDrag))
    }
}
#endif
