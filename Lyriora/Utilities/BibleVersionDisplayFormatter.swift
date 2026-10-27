//
//  BibleVersionDisplayFormatter.swift
//  Lyriora
//

import Foundation

enum BibleVersionDisplayFormatter {
    private static let languagePrefixes = [
        "Spanish", "English", "French", "Portuguese", "German", "Italian",
        "Russian", "Chinese", "Korean", "Japanese", "Arabic", "Hindi",
        "Dutch", "Polish", "Romanian", "Tagalog", "Indonesian", "Esperanto"
    ]

    private static let knownAbbreviations: [String: String] = [
        "KJ": "KJV",
        "KJB": "KJV",
        "NKJV": "NKJV",
        "NIV": "NIV",
        "NVI": "NVI",
        "RVR": "RVR",
        "RVR1960": "RVR 1960",
        "ESV": "ESV",
        "NASB": "NASB",
        "NLT": "NLT",
        "MSG": "MSG",
        "AMP": "AMP",
        "CSB": "CSB",
        "HCSB": "HCSB",
        "TLA": "TLA",
        "LBLA": "LBLA",
        "NBLH": "NBLH",
        "DHH": "DHH",
        "PDT": "PDT",
        "RVC": "RVC",
        "NTV": "NTV"
    ]

    static func prettyName(from raw: String, translation: String? = nil) -> String {
        let candidates = [
            formatCandidate(raw),
            translation.map(formatCandidate)
        ].compactMap { $0?.nilIfEmpty }

        for candidate in candidates {
            if let formatted = polished(candidate), !formatted.isEmpty {
                return formatted
            }
        }

        return candidates.first ?? raw
    }

    private static func formatCandidate(_ value: String) -> String {
        var name = value
            .replacingOccurrences(of: ".xml", with: "", options: .caseInsensitive)
            .trimmingCharacters(in: .whitespacesAndNewlines)

        for prefix in languagePrefixes {
            if name.hasPrefix(prefix) {
                name = String(name.dropFirst(prefix.count))
                break
            }
        }

        if name.lowercased().hasSuffix("bible") {
            name = String(name.dropLast(5))
        }

        name = name.replacingOccurrences(of: "_", with: " ")
        name = name.replacingOccurrences(of: "-", with: " ")
        return name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func polished(_ name: String) -> String? {
        guard !name.isEmpty else { return nil }

        if let mapped = knownAbbreviations[name.uppercased()] {
            return mapped
        }

        if let yearMatch = name.range(of: #"([A-Za-z]{2,})(\d{4})"#, options: .regularExpression) {
            let matched = String(name[yearMatch])
            if let regex = try? NSRegularExpression(pattern: #"^([A-Za-z]{2,})(\d{4})$"#),
               let result = regex.firstMatch(in: matched, range: NSRange(matched.startIndex..., in: matched)),
               result.numberOfRanges == 3,
               let lettersRange = Range(result.range(at: 1), in: matched),
               let yearRange = Range(result.range(at: 2), in: matched) {
                let letters = String(matched[lettersRange]).uppercased()
                let year = String(matched[yearRange])
                if let mapped = knownAbbreviations[letters] {
                    return "\(mapped) \(year)"
                }
                return "\(letters) \(year)"
            }
        }

        let spaced = insertSpaces(in: name)
        let upper = spaced.uppercased()
        if let mapped = knownAbbreviations[upper.replacingOccurrences(of: " ", with: "")] {
            return mapped
        }

        return titleCase(spaced)
    }

    private static func insertSpaces(in value: String) -> String {
        var result = ""
        var previous: Character?

        for character in value {
            if let previous,
               previous.isLowercase,
               character.isUppercase {
                result.append(" ")
            } else if let previous,
                      previous.isNumber,
                      character.isLetter {
                result.append(" ")
            }
            result.append(character)
            previous = character
        }

        return result.replacingOccurrences(of: "  ", with: " ")
    }

    private static func titleCase(_ value: String) -> String {
        value.split(separator: " ")
            .map { word in
                let upper = word.uppercased()
                if upper.count <= 4, upper == String(word.uppercased()) {
                    return upper
                }
                return word.prefix(1).uppercased() + word.dropFirst().lowercased()
            }
            .joined(separator: " ")
    }
}

extension BibleVersionManifest {
    var prettyDisplayName: String {
        BibleVersionDisplayFormatter.prettyName(from: displayName, translation: translation)
    }
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
