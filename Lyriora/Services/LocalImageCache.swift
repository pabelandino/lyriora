//
//  LocalImageCache.swift
//  Lyriora
//

import CoreGraphics
import Foundation
import SwiftUI

enum LocalImageCache {
    private struct Entry {
        let image: Image
        let size: CGSize
    }

    private static var storage: [URL: Entry] = [:]
    private static let lock = NSLock()

    static func entry(for url: URL) -> (image: Image, size: CGSize)? {
        lock.lock()
        defer { lock.unlock() }
        guard let entry = storage[url] else { return nil }
        return (entry.image, entry.size)
    }

    static func store(image: Image, size: CGSize, for url: URL) {
        lock.lock()
        defer { lock.unlock() }
        storage[url] = Entry(image: image, size: size)
    }
}
