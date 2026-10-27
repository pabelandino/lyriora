//
//  BibleXMLParser.swift
//  Lyriora
//

import Foundation

enum BibleXMLParserError: LocalizedError {
    case invalidFormat
    case parseFailed(String)

    var errorDescription: String? {
        switch self {
        case .invalidFormat:
            "The file is not a valid Beblia Bible XML document."
        case .parseFailed(let detail):
            "Failed to parse Bible XML: \(detail)"
        }
    }
}

enum BibleXMLParser {
    static func parse(data: Data) throws -> BibleVersionIndex {
        let delegate = ParserDelegate()
        let parser = XMLParser(data: data)
        parser.delegate = delegate

        guard parser.parse() else {
            if let error = parser.parserError {
                throw BibleXMLParserError.parseFailed(error.localizedDescription)
            }
            throw BibleXMLParserError.invalidFormat
        }

        guard !delegate.books.isEmpty else {
            throw BibleXMLParserError.invalidFormat
        }

        return BibleVersionIndex(
            translation: delegate.translation,
            link: delegate.link,
            status: delegate.status,
            books: delegate.books.sorted { $0.number < $1.number }
        )
    }
}

private final class ParserDelegate: NSObject, XMLParserDelegate {
    var translation = ""
    var link: String?
    var status: String?
    private(set) var books: [BibleBookIndex] = []

    private var currentBookNumber: Int?
    private var currentChapters: [BibleChapterIndex] = []
    private var currentChapterNumber: Int?
    private var currentVerses: [BibleVerseIndex] = []
    private var currentVerseNumber: Int?
    private var currentVerseText = ""

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]
    ) {
        switch elementName {
        case "bible":
            translation = attributeDict["translation"] ?? "Bible"
            link = attributeDict["link"]
            status = attributeDict["status"]
        case "book":
            flushChapter()
            flushBook()
            currentBookNumber = Int(attributeDict["number"] ?? "")
            currentChapters = []
        case "chapter":
            flushChapter()
            currentChapterNumber = Int(attributeDict["number"] ?? "")
            currentVerses = []
        case "verse":
            currentVerseNumber = Int(attributeDict["number"] ?? "")
            currentVerseText = ""
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentVerseText += string
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        switch elementName {
        case "verse":
            guard let number = currentVerseNumber else { return }
            let text = currentVerseText
                .replacingOccurrences(of: "\n", with: " ")
                .replacingOccurrences(of: "  ", with: " ")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if !text.isEmpty {
                currentVerses.append(BibleVerseIndex(number: number, text: text))
            }
            currentVerseNumber = nil
            currentVerseText = ""
        case "chapter":
            flushChapter()
        case "book":
            flushChapter()
            flushBook()
        default:
            break
        }
    }

    private func flushChapter() {
        guard let chapterNumber = currentChapterNumber else { return }
        if !currentVerses.isEmpty {
            currentChapters.append(
                BibleChapterIndex(
                    number: chapterNumber,
                    verses: currentVerses.sorted { $0.number < $1.number }
                )
            )
        }
        currentChapterNumber = nil
        currentVerses = []
    }

    private func flushBook() {
        guard let bookNumber = currentBookNumber else { return }
        if !currentChapters.isEmpty {
            books.append(
                BibleBookIndex(
                    number: bookNumber,
                    chapters: currentChapters.sorted { $0.number < $1.number }
                )
            )
        }
        currentBookNumber = nil
        currentChapters = []
    }
}
