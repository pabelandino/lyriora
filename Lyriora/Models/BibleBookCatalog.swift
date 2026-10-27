//
//  BibleBookCatalog.swift
//  Lyriora
//

import Foundation

struct BibleBookInfo: Identifiable, Sendable, Hashable {
    let number: Int
    let englishName: String
    let spanishName: String
    let chapterCount: Int
    let searchAliases: [String]

    var id: Int { number }

    func displayName(preferSpanish: Bool = true) -> String {
        preferSpanish ? spanishName : englishName
    }

    func formattedReference(chapter: Int, verse: Int? = nil, preferSpanish: Bool = true) -> String {
        let book = displayName(preferSpanish: preferSpanish)
        if let verse {
            return "\(book) \(chapter):\(verse)"
        }
        return "\(book) \(chapter)"
    }
}

enum BibleBookCatalog {
    static let books: [BibleBookInfo] = [
        book(1, "Genesis", "Génesis", 50, ["gen", "gn"]),
        book(2, "Exodus", "Éxodo", 40, ["exod", "ex"]),
        book(3, "Leviticus", "Levítico", 27, ["lev", "lv"]),
        book(4, "Numbers", "Números", 36, ["num", "nm"]),
        book(5, "Deuteronomy", "Deuteronomio", 34, ["deut", "dt"]),
        book(6, "Joshua", "Josué", 24, ["jos", "js"]),
        book(7, "Judges", "Jueces", 21, ["jue", "jdg"]),
        book(8, "Ruth", "Rut", 4, ["rt"]),
        book(9, "1 Samuel", "1 Samuel", 31, ["1 sam", "1sam"]),
        book(10, "2 Samuel", "2 Samuel", 24, ["2 sam", "2sam"]),
        book(11, "1 Kings", "1 Reyes", 22, ["1 rey", "1 reyes", "1 kin", "1kin"]),
        book(12, "2 Kings", "2 Reyes", 25, ["2 rey", "2 reyes", "2 kin", "2kin"]),
        book(13, "1 Chronicles", "1 Crónicas", 29, ["1 cro", "1 cronicas", "1 chr", "1chr"]),
        book(14, "2 Chronicles", "2 Crónicas", 36, ["2 cro", "2 cronicas", "2 chr", "2chr"]),
        book(15, "Ezra", "Esdras", 10, ["esd"]),
        book(16, "Nehemiah", "Nehemías", 13, ["neh", "ne"]),
        book(17, "Esther", "Ester", 10, ["est"]),
        book(18, "Job", "Job", 42, ["jb"]),
        book(19, "Psalms", "Salmos", 150, ["sal", "ps", "salmo"]),
        book(20, "Proverbs", "Proverbios", 31, ["pro", "pr"]),
        book(21, "Ecclesiastes", "Eclesiastés", 12, ["ecl", "ec"]),
        book(22, "Song of Solomon", "Cantares", 8, ["cant", "so"]),
        book(23, "Isaiah", "Isaías", 66, ["isa", "is"]),
        book(24, "Jeremiah", "Jeremías", 52, ["jer", "jr"]),
        book(25, "Lamentations", "Lamentaciones", 5, ["lam", "lm"]),
        book(26, "Ezekiel", "Ezequiel", 48, ["eze", "ez"]),
        book(27, "Daniel", "Daniel", 12, ["dan", "dn"]),
        book(28, "Hosea", "Oseas", 14, ["hos", "os"]),
        book(29, "Joel", "Joel", 3, ["jl"]),
        book(30, "Amos", "Amós", 9, ["am"]),
        book(31, "Obadiah", "Abdías", 1, ["abd", "ob"]),
        book(32, "Jonah", "Jonás", 4, ["jon", "jonas"]),
        book(33, "Micah", "Miqueas", 7, ["mic", "miq"]),
        book(34, "Nahum", "Nahum", 3, ["nah", "na"]),
        book(35, "Habakkuk", "Habacuc", 3, ["hab", "habacuc"]),
        book(36, "Zephaniah", "Sofonías", 3, ["sof", "zep", "zp"]),
        book(37, "Haggai", "Hageo", 2, ["hag", "hg"]),
        book(38, "Zechariah", "Zacarías", 14, ["zac", "zec", "zc"]),
        book(39, "Malachi", "Malaquías", 4, ["mal", "ml"]),
        book(40, "Matthew", "Mateo", 28, ["mat", "mt"]),
        book(41, "Mark", "Marcos", 16, ["mar", "mk", "mc"]),
        book(42, "Luke", "Lucas", 24, ["luc", "lk", "lc"]),
        book(43, "John", "Juan", 21, ["jn", "jua"]),
        book(44, "Acts", "Hechos", 28, ["hech", "hechos", "act", "hch"]),
        book(45, "Romans", "Romanos", 16, ["rom", "rm"]),
        book(46, "1 Corinthians", "1 Corintios", 16, ["1 cor", "1cor"]),
        book(47, "2 Corinthians", "2 Corintios", 13, ["2 cor", "2cor"]),
        book(48, "Galatians", "Gálatas", 6, ["gal", "gl"]),
        book(49, "Ephesians", "Efesios", 6, ["efe", "eph", "ef"]),
        book(50, "Philippians", "Filipenses", 4, ["fil", "php", "fp"]),
        book(51, "Colossians", "Colosenses", 4, ["col", "cl"]),
        book(52, "1 Thessalonians", "1 Tesalonicenses", 5, ["1 tes", "1tes"]),
        book(53, "2 Thessalonians", "2 Tesalonicenses", 3, ["2 tes", "2tes"]),
        book(54, "1 Timothy", "1 Timoteo", 6, ["1 tim", "1tim"]),
        book(55, "2 Timothy", "2 Timoteo", 4, ["2 tim", "2tim"]),
        book(56, "Titus", "Tito", 3, ["tit", "tt"]),
        book(57, "Philemon", "Filemón", 1, ["file", "phm", "flm"]),
        book(58, "Hebrews", "Hebreos", 13, ["heb", "hb"]),
        book(59, "James", "Santiago", 5, ["san", "jas", "stg"]),
        book(60, "1 Peter", "1 Pedro", 5, ["1 ped", "1ped"]),
        book(61, "2 Peter", "2 Pedro", 3, ["2 ped", "2ped"]),
        book(62, "1 John", "1 Juan", 5, ["1 juan", "1jn"]),
        book(63, "2 John", "2 Juan", 1, ["2 juan", "2jn"]),
        book(64, "3 John", "3 Juan", 1, ["3 juan", "3jn"]),
        book(65, "Jude", "Judas", 1, ["jud", "jd"]),
        book(66, "Revelation", "Apocalipsis", 22, ["apo", "rev", "ap"])
    ]

    static func book(number: Int) -> BibleBookInfo? {
        books.first { $0.number == number }
    }

    static func matchBook(in query: String) -> BibleBookInfo? {
        let normalized = normalize(query)
        guard !normalized.isEmpty else { return nil }

        let ranked = books
            .compactMap { book -> (BibleBookInfo, Int)? in
                let candidates = ([book.englishName, book.spanishName] + book.searchAliases)
                    .map { normalize($0) }
                guard let best = candidates
                    .filter({ normalized.hasPrefix($0) || normalized == $0 })
                    .max(by: { $0.count < $1.count }) else {
                    return nil
                }
                return (book, best.count)
            }
            .sorted { $0.1 > $1.1 }

        return ranked.first?.0
    }

    static func normalize(_ text: String) -> String {
        text
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "  ", with: " ")
    }

    private static func book(
        _ number: Int,
        _ english: String,
        _ spanish: String,
        _ chapters: Int,
        _ aliases: [String]
    ) -> BibleBookInfo {
        BibleBookInfo(
            number: number,
            englishName: english,
            spanishName: spanish,
            chapterCount: chapters,
            searchAliases: aliases
        )
    }
}
