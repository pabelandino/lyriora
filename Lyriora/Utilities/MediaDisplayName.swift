//
//  MediaDisplayName.swift
//  Lyriora
//

import Foundation

enum MediaDisplayName {
    static func resolve(
        proposed: String?,
        kind: MediaAssetKind,
        existingNames: Set<String>
    ) -> String {
        if let cleaned = cleanedHumanName(proposed),
           !looksLikeGeneratedIdentifier(cleaned) {
            return uniqueName(cleaned, existing: existingNames)
        }

        return genericName(kind: kind, existing: existingNames)
    }

    static func cleanedHumanName(_ proposed: String?) -> String? {
        let trimmed = proposed?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !trimmed.isEmpty else { return nil }
        return (trimmed as NSString).deletingPathExtension
    }

    static func looksLikeGeneratedIdentifier(_ name: String) -> Bool {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return true }

        if UUID(uuidString: trimmed) != nil {
            return true
        }

        let normalized = trimmed
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "_", with: "")

        guard normalized.count == 32 else { return false }
        return normalized.unicodeScalars.allSatisfy { CharacterSet.hexadecimals.contains($0) }
    }

    static func genericName(kind: MediaAssetKind, existing: Set<String>) -> String {
        let prefix = kind == .image ? "Image" : "Video"
        var index = 1

        while existing.contains("\(prefix) \(index)") {
            index += 1
        }

        return "\(prefix) \(index)"
    }

    private static func uniqueName(_ base: String, existing: Set<String>) -> String {
        guard existing.contains(base) else { return base }

        var index = 2
        while existing.contains("\(base) \(index)") {
            index += 1
        }

        return "\(base) \(index)"
    }
}

private extension CharacterSet {
    static let hexadecimals = CharacterSet(charactersIn: "0123456789ABCDEFabcdef")
}
