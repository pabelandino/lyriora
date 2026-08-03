//
//  LyricClipboardImporter.swift
//  Lyriora
//

import Foundation

#if canImport(UIKit)
import UIKit
#elseif os(macOS)
import AppKit
#endif

enum LyricClipboardImporter {
    static func readText() throws -> String {
        #if canImport(UIKit)
        let pasteboard = UIPasteboard.general
        if pasteboard.hasImages, pasteboard.string == nil {
            throw LyricImportError.notText
        }
        if pasteboard.hasURLs, pasteboard.string == nil {
            throw LyricImportError.notText
        }
        guard let text = pasteboard.string else {
            throw LyricImportError.notText
        }
        #elseif os(macOS)
        let pasteboard = NSPasteboard.general
        if let urls = pasteboard.readObjects(forClasses: [NSURL.self]) as? [URL], !urls.isEmpty,
           pasteboard.string(forType: .string) == nil {
            throw LyricImportError.notText
        }
        guard let text = pasteboard.string(forType: .string) else {
            throw LyricImportError.notText
        }
        #else
        throw LyricImportError.notText
        let text = ""
        #endif

        guard LyricImportParser.isLikelyText(text) else {
            throw LyricImportError.unsupportedContent
        }

        return text
    }
}
