//
//  BibleVersionRepository.swift
//  Lyriora
//

import Foundation
import UniformTypeIdentifiers

protocol BibleVersionRepositoryProtocol {
    func loadManifests() throws -> [BibleVersionManifest]
    func saveManifests(_ manifests: [BibleVersionManifest]) throws
    func importXML(from sourceURL: URL, suggestedName: String?) throws -> (BibleVersionManifest, BibleVersionIndex)
    func loadIndex(for manifest: BibleVersionManifest) throws -> BibleVersionIndex
    func delete(_ manifest: BibleVersionManifest) throws
    func xmlURL(for manifest: BibleVersionManifest) -> URL
}

final class BibleVersionRepository: BibleVersionRepositoryProtocol {
    static let xmlType = UTType(filenameExtension: "xml") ?? .xml

    /// Broad enough for Files/Safari/iCloud downloads on iPad where XML may be untyped.
    static var importableContentTypes: [UTType] {
        var types: [UTType] = [.xml, .text, .plainText, .utf8PlainText, .data]
        if let xmlExt = UTType(filenameExtension: "xml") {
            types.append(xmlExt)
        }
        if let publicXML = UTType("public.xml") {
            types.append(publicXML)
        }
        return types
    }

    private let fileManager: FileManager
    private let versionsDirectory: URL
    private let manifestURL: URL

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager

        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.versionsDirectory = documents.appendingPathComponent("BibleVersions", isDirectory: true)
        self.manifestURL = versionsDirectory.appendingPathComponent("manifest.json")

        if !fileManager.fileExists(atPath: versionsDirectory.path) {
            try? fileManager.createDirectory(at: versionsDirectory, withIntermediateDirectories: true)
        }
    }

    func loadManifests() throws -> [BibleVersionManifest] {
        guard fileManager.fileExists(atPath: manifestURL.path) else { return [] }
        let data = try Data(contentsOf: manifestURL)
        return try JSONDecoder().decode([BibleVersionManifest].self, from: data)
            .sorted { $0.importedAt > $1.importedAt }
    }

    func saveManifests(_ manifests: [BibleVersionManifest]) throws {
        let data = try JSONEncoder().encode(manifests)
        try data.write(to: manifestURL, options: .atomic)
    }

    func importXML(from sourceURL: URL, suggestedName: String?) throws -> (BibleVersionManifest, BibleVersionIndex) {
        let data = try Self.readImportedData(from: sourceURL, fileManager: fileManager)
        let index = try BibleXMLParser.parse(data: data)

        let id = UUID()
        let xmlFileName = "\(id.uuidString).xml"
        let indexFileName = "\(id.uuidString).index.json"
        let destination = versionsDirectory.appendingPathComponent(xmlFileName)

        if fileManager.fileExists(atPath: destination.path) {
            try fileManager.removeItem(at: destination)
        }
        try data.write(to: destination, options: .atomic)

        let indexURL = versionsDirectory.appendingPathComponent(indexFileName)
        let indexData = try JSONEncoder().encode(index)
        try indexData.write(to: indexURL, options: .atomic)

        let displayName = BibleVersionDisplayFormatter.prettyName(
            from: suggestedName?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty
                ?? index.translation,
            translation: index.translation
        )

        let manifest = BibleVersionManifest(
            id: id,
            displayName: displayName,
            translation: index.translation,
            fileName: xmlFileName,
            importedAt: .now
        )

        return (manifest, index)
    }

    func loadIndex(for manifest: BibleVersionManifest) throws -> BibleVersionIndex {
        let indexURL = versionsDirectory.appendingPathComponent("\(manifest.id.uuidString).index.json")
        if fileManager.fileExists(atPath: indexURL.path) {
            let data = try Data(contentsOf: indexURL)
            return try JSONDecoder().decode(BibleVersionIndex.self, from: data)
        }

        let xmlURL = xmlURL(for: manifest)
        let data = try Data(contentsOf: xmlURL)
        let index = try BibleXMLParser.parse(data: data)
        let indexData = try JSONEncoder().encode(index)
        try indexData.write(to: indexURL, options: .atomic)
        return index
    }

    func delete(_ manifest: BibleVersionManifest) throws {
        let xmlURL = xmlURL(for: manifest)
        let indexURL = versionsDirectory.appendingPathComponent("\(manifest.id.uuidString).index.json")
        if fileManager.fileExists(atPath: xmlURL.path) {
            try fileManager.removeItem(at: xmlURL)
        }
        if fileManager.fileExists(atPath: indexURL.path) {
            try fileManager.removeItem(at: indexURL)
        }
    }

    func xmlURL(for manifest: BibleVersionManifest) -> URL {
        versionsDirectory.appendingPathComponent(manifest.fileName)
    }

    private static func readImportedData(from sourceURL: URL, fileManager: FileManager) throws -> Data {
        let didAccess = sourceURL.startAccessingSecurityScopedResource()
        defer {
            if didAccess {
                sourceURL.stopAccessingSecurityScopedResource()
            }
        }

        #if os(iOS)
        if sourceURL.isFileURL, fileManager.isReadableFile(atPath: sourceURL.path) {
            return try Data(contentsOf: sourceURL)
        }

        let temporaryURL = fileManager.temporaryDirectory
            .appendingPathComponent("bible-import-\(UUID().uuidString).xml")
        defer { try? fileManager.removeItem(at: temporaryURL) }

        if fileManager.fileExists(atPath: temporaryURL.path) {
            try fileManager.removeItem(at: temporaryURL)
        }
        try fileManager.copyItem(at: sourceURL, to: temporaryURL)
        return try Data(contentsOf: temporaryURL)
        #else
        return try Data(contentsOf: sourceURL)
        #endif
    }
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
