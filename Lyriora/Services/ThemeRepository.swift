//
//  ThemeRepository.swift
//  Lyriora
//

import Foundation

protocol ThemeRepositoryProtocol {
    func loadAll() throws -> [LyricTheme]
    func save(_ theme: LyricTheme) throws
    func delete(_ theme: LyricTheme) throws
}

final class ThemeRepository: ThemeRepositoryProtocol {
    private let fileManager: FileManager
    private let themesURL: URL

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager

        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directory = documents.appendingPathComponent("Themes", isDirectory: true)

        if !fileManager.fileExists(atPath: directory.path) {
            try? fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
        }

        self.themesURL = directory.appendingPathComponent("themes.json")
    }

    func loadAll() throws -> [LyricTheme] {
        guard fileManager.fileExists(atPath: themesURL.path) else {
            return []
        }

        let data = try Data(contentsOf: themesURL)
        let themes = try JSONDecoder().decode([LyricTheme].self, from: data)
        return themes.sorted { $0.updatedAt > $1.updatedAt }
    }

    func save(_ theme: LyricTheme) throws {
        var themes = (try? loadAll()) ?? []

        if let index = themes.firstIndex(where: { $0.id == theme.id }) {
            themes[index] = theme
        } else {
            themes.insert(theme, at: 0)
        }

        let data = try JSONEncoder().encode(themes)
        try data.write(to: themesURL, options: .atomic)
    }

    func delete(_ theme: LyricTheme) throws {
        var themes = try loadAll()
        themes.removeAll { $0.id == theme.id }
        let data = try JSONEncoder().encode(themes)
        try data.write(to: themesURL, options: .atomic)
    }
}
