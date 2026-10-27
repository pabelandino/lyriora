//
//  BibleVersion.swift
//  Lyriora
//

import Foundation

struct BibleVersionManifest: Identifiable, Codable, Equatable, Sendable {
    let id: UUID
    var displayName: String
    var translation: String
    var fileName: String
    var importedAt: Date

    init(
        id: UUID = UUID(),
        displayName: String,
        translation: String,
        fileName: String,
        importedAt: Date = .now
    ) {
        self.id = id
        self.displayName = displayName
        self.translation = translation
        self.fileName = fileName
        self.importedAt = importedAt
    }
}

struct BibleVerseIndex: Codable, Equatable, Sendable {
    let number: Int
    let text: String
}

struct BibleChapterIndex: Codable, Equatable, Sendable {
    let number: Int
    let verses: [BibleVerseIndex]

    var verseCount: Int { verses.count }
}

struct BibleBookIndex: Codable, Equatable, Sendable {
    let number: Int
    let chapters: [BibleChapterIndex]

    func chapter(_ number: Int) -> BibleChapterIndex? {
        chapters.first { $0.number == number }
    }
}

struct BibleVersionIndex: Codable, Equatable, Sendable {
    let translation: String
    let link: String?
    let status: String?
    let books: [BibleBookIndex]

    func book(_ number: Int) -> BibleBookIndex? {
        books.first { $0.number == number }
    }
}

struct BibleVerseLocation: Equatable, Sendable, Hashable {
    let bookNumber: Int
    let chapter: Int
    let verse: Int

    func referenceLabel(preferSpanish: Bool = true) -> String {
        guard let book = BibleBookCatalog.book(number: bookNumber) else {
            return "\(bookNumber) \(chapter):\(verse)"
        }
        return book.formattedReference(chapter: chapter, verse: verse, preferSpanish: preferSpanish)
    }
}

struct BiblePresentationSlide: Identifiable, Equatable, Sendable {
    let id: UUID
    let location: BibleVerseLocation
    let referenceLabel: String
    let text: String
    let chunkIndex: Int
    let totalChunks: Int

    init(
        id: UUID = UUID(),
        location: BibleVerseLocation,
        referenceLabel: String,
        text: String,
        chunkIndex: Int = 0,
        totalChunks: Int = 1
    ) {
        self.id = id
        self.location = location
        self.referenceLabel = referenceLabel
        self.text = text
        self.chunkIndex = chunkIndex
        self.totalChunks = totalChunks
    }
}

struct BibleReadingSession: Equatable, Sendable {
    let versionID: UUID
    let versionName: String
    let bookNumber: Int
    let chapter: Int
    var slides: [BiblePresentationSlide]
    var previewSlideIndex: Int
    var stripFocusIndex: Int

    var previewSlide: BiblePresentationSlide? {
        guard slides.indices.contains(previewSlideIndex) else { return nil }
        return slides[previewSlideIndex]
    }

    var canGoPreviousInStrip: Bool { stripFocusIndex > 0 }

    func canGoNextInStrip(
        in index: BibleVersionIndex,
        style: SlideTextStyle,
        containerSize: CGSize = PresentationLayout.referenceCanvasSize
    ) -> Bool {
        if stripFocusIndex + 1 < slides.count { return true }
        return BibleSlideBuilder.nextAppendableSlide(
            after: self,
            bibleIndex: index,
            style: style,
            containerSize: containerSize
        ) != nil
    }

    func nextVerseNumber(in index: BibleVersionIndex) -> Int? {
        guard let lastVerse = slides.last?.location.verse else { return nil }
        let candidate = lastVerse + 1
        let exists = index.book(bookNumber)?
            .chapter(chapter)?
            .verses
            .contains(where: { $0.number == candidate }) ?? false
        return exists ? candidate : nil
    }

    mutating func focusStrip(at index: Int) {
        guard slides.indices.contains(index) else { return }
        stripFocusIndex = index
    }

    mutating func presentSlide(at index: Int) {
        guard slides.indices.contains(index) else { return }
        previewSlideIndex = index
        stripFocusIndex = index
    }
}

enum BibleSearchHintKind: Equatable, Sendable {
    case reference(bookNumber: Int, chapter: Int, verse: Int?)
    case textMatch(location: BibleVerseLocation, snippet: String)
}

struct BibleSearchHint: Identifiable, Equatable, Sendable {
    let id: UUID
    let title: String
    let subtitle: String?
    let kind: BibleSearchHintKind

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String? = nil,
        kind: BibleSearchHintKind
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.kind = kind
    }
}

struct BiblePresentationSettings: Codable, Equatable, Sendable {
    var style: SlideTextStyle
    var animationProfile: SlideAnimationProfile
    var selectedVersionID: UUID?
    var selectedThemeID: UUID?

    static let `default` = BiblePresentationSettings(
        style: .default,
        animationProfile: SlideAnimationProfile(),
        selectedVersionID: nil,
        selectedThemeID: nil
    )
}
