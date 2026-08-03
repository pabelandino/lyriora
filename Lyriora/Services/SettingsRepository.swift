//
//  SettingsRepository.swift
//  Lyriora
//

import Foundation

protocol SettingsRepositoryProtocol {
    func load() throws -> AppSettings
    func save(_ settings: AppSettings) throws
}

final class SettingsRepository: SettingsRepositoryProtocol {
    private let fileManager: FileManager
    private let settingsURL: URL

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager

        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let settingsDirectory = documents.appendingPathComponent("Settings", isDirectory: true)

        if !fileManager.fileExists(atPath: settingsDirectory.path) {
            try? fileManager.createDirectory(at: settingsDirectory, withIntermediateDirectories: true)
        }

        self.settingsURL = settingsDirectory.appendingPathComponent("app.settings.json")
    }

    func load() throws -> AppSettings {
        guard fileManager.fileExists(atPath: settingsURL.path) else {
            return .default
        }

        let data = try Data(contentsOf: settingsURL)
        return try JSONDecoder().decode(AppSettings.self, from: data)
    }

    func save(_ settings: AppSettings) throws {
        let data = try JSONEncoder().encode(settings)
        try data.write(to: settingsURL, options: .atomic)
    }
}
