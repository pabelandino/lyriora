//
//  MacFileImportPanel.swift
//  Lyriora
//

#if os(macOS)
import AppKit
import UniformTypeIdentifiers

enum MacFileImportPanel {
    @MainActor
    static func pickFiles(
        contentTypes: [UTType],
        allowsMultipleSelection: Bool
    ) -> [URL] {
        let panel = NSOpenPanel()
        panel.title = "Choose Files"
        panel.allowedContentTypes = contentTypes
        panel.allowsMultipleSelection = allowsMultipleSelection
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        guard panel.runModal() == .OK else { return [] }
        return panel.urls
    }
}
#endif
