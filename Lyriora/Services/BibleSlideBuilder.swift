//
//  BibleSlideBuilder.swift
//  Lyriora
//

import CoreGraphics
import Foundation

enum BibleSlideBuilder {
    static func initialSlides(
        bookNumber: Int,
        chapter: Int,
        verse: Int?,
        index: BibleVersionIndex,
        style: SlideTextStyle,
        preferSpanish: Bool = true,
        containerSize: CGSize = PresentationLayout.referenceCanvasSize
    ) -> [BiblePresentationSlide] {
        let startVerse = verse ?? index.book(bookNumber)?.chapter(chapter)?.verses.first?.number
        guard let startVerse,
              let slide = firstSlideForVerse(
                bookNumber: bookNumber,
                chapter: chapter,
                verse: startVerse,
                index: index,
                style: style,
                preferSpanish: preferSpanish,
                containerSize: containerSize
              ) else {
            return []
        }
        return [slide]
    }

    static func firstSlideForVerse(
        bookNumber: Int,
        chapter: Int,
        verse: Int,
        index: BibleVersionIndex,
        style: SlideTextStyle,
        preferSpanish: Bool = true,
        containerSize: CGSize = PresentationLayout.referenceCanvasSize
    ) -> BiblePresentationSlide? {
        slideForVerse(
            bookNumber: bookNumber,
            chapter: chapter,
            verse: verse,
            chunkIndex: 0,
            index: index,
            style: style,
            preferSpanish: preferSpanish,
            containerSize: containerSize
        )
    }

    static func nextAppendableSlide(
        after session: BibleReadingSession,
        bibleIndex: BibleVersionIndex,
        style: SlideTextStyle,
        preferSpanish: Bool = true,
        containerSize: CGSize = PresentationLayout.referenceCanvasSize
    ) -> BiblePresentationSlide? {
        guard let lastSlide = session.slides.last else { return nil }

        let chunks = textChunksForVerse(
            bookNumber: lastSlide.location.bookNumber,
            chapter: lastSlide.location.chapter,
            verse: lastSlide.location.verse,
            index: bibleIndex,
            style: style,
            containerSize: containerSize
        )

        let loadedChunksForVerse = session.slides.filter {
            $0.location.bookNumber == lastSlide.location.bookNumber
                && $0.location.chapter == lastSlide.location.chapter
                && $0.location.verse == lastSlide.location.verse
        }.count

        if loadedChunksForVerse < chunks.count {
            return slideForVerse(
                bookNumber: lastSlide.location.bookNumber,
                chapter: lastSlide.location.chapter,
                verse: lastSlide.location.verse,
                chunkIndex: loadedChunksForVerse,
                index: bibleIndex,
                style: style,
                preferSpanish: preferSpanish,
                containerSize: containerSize
            )
        }

        guard let nextVerse = session.nextVerseNumber(in: bibleIndex) else { return nil }

        return firstSlideForVerse(
            bookNumber: session.bookNumber,
            chapter: session.chapter,
            verse: nextVerse,
            index: bibleIndex,
            style: style,
            preferSpanish: preferSpanish,
            containerSize: containerSize
        )
    }

    static func slides(
        for hint: BibleSearchHint,
        index: BibleVersionIndex,
        style: SlideTextStyle,
        containerSize: CGSize = PresentationLayout.referenceCanvasSize
    ) -> [BiblePresentationSlide] {
        switch hint.kind {
        case let .reference(bookNumber, chapter, verse):
            return initialSlides(
                bookNumber: bookNumber,
                chapter: chapter,
                verse: verse,
                index: index,
                style: style,
                containerSize: containerSize
            )
        case let .textMatch(location, _):
            return initialSlides(
                bookNumber: location.bookNumber,
                chapter: location.chapter,
                verse: location.verse,
                index: index,
                style: style,
                containerSize: containerSize
            )
        }
    }

    static func rebuildSlides(
        from session: BibleReadingSession,
        index: BibleVersionIndex,
        style: SlideTextStyle,
        containerSize: CGSize = PresentationLayout.referenceCanvasSize
    ) -> [BiblePresentationSlide] {
        session.slides.compactMap { slide in
            slideForVerse(
                bookNumber: slide.location.bookNumber,
                chapter: slide.location.chapter,
                verse: slide.location.verse,
                chunkIndex: slide.chunkIndex,
                index: index,
                style: style,
                containerSize: containerSize
            )
        }
    }

    private static func slideForVerse(
        bookNumber: Int,
        chapter: Int,
        verse: Int,
        chunkIndex: Int,
        index: BibleVersionIndex,
        style: SlideTextStyle,
        preferSpanish: Bool = true,
        containerSize: CGSize = PresentationLayout.referenceCanvasSize
    ) -> BiblePresentationSlide? {
        guard let bookInfo = BibleBookCatalog.book(number: bookNumber) else { return nil }

        let chunks = textChunksForVerse(
            bookNumber: bookNumber,
            chapter: chapter,
            verse: verse,
            index: index,
            style: style,
            containerSize: containerSize
        )
        guard chunks.indices.contains(chunkIndex) else { return nil }

        let location = BibleVerseLocation(
            bookNumber: bookNumber,
            chapter: chapter,
            verse: verse
        )
        let reference = formattedReference(
            bookInfo: bookInfo,
            chapter: chapter,
            verse: verse,
            chunkIndex: chunkIndex,
            totalChunks: chunks.count,
            preferSpanish: preferSpanish
        )

        return BiblePresentationSlide(
            location: location,
            referenceLabel: reference,
            text: chunks[chunkIndex],
            chunkIndex: chunkIndex,
            totalChunks: chunks.count
        )
    }

    private static func textChunksForVerse(
        bookNumber: Int,
        chapter: Int,
        verse: Int,
        index: BibleVersionIndex,
        style: SlideTextStyle,
        containerSize: CGSize
    ) -> [String] {
        guard let verseText = index.book(bookNumber)?
            .chapter(chapter)?
            .verses
            .first(where: { $0.number == verse })?
            .text else {
            return []
        }

        return LyricSlideLayoutEngine.chunkedSlideTexts(
            from: verseText,
            style: style,
            containerSize: containerSize
        )
    }

    private static func formattedReference(
        bookInfo: BibleBookInfo,
        chapter: Int,
        verse: Int,
        chunkIndex: Int,
        totalChunks: Int,
        preferSpanish: Bool
    ) -> String {
        let base = bookInfo.formattedReference(
            chapter: chapter,
            verse: verse,
            preferSpanish: preferSpanish
        )
        guard totalChunks > 1 else { return base }
        return "\(base) (\(chunkIndex + 1)/\(totalChunks))"
    }
}
