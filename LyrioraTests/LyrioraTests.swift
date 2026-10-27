//
//  LyrioraTests.swift
//  LyrioraTests
//
//  Created by Pabel Andino on 8/3/26.
//

import Testing
@testable import Lyriora

struct LyrioraTests {

    @Test func parseSections_respectsUnicodeLineSeparatorsFromWebClipboard() {
        let lineBreak = "\u{2028}"
        let raw = """
        Verso
        Has cambiado mi lamento en baile\(lineBreak)Me ceñiste todo de alegría
        """

        let result = LyricImportParser.parseSections(raw)

        #expect(result.sections.count == 1)
        #expect(result.sections[0].lines.count == 2)
        #expect(result.sections[0].lines[0] == "Has cambiado mi lamento en baile")
        #expect(result.sections[0].lines[1] == "Me ceñiste todo de alegría")
    }

    @Test func makeSlides_joinsParsedLinesWithStandardNewlines() {
        let lineBreak = "\u{2028}"
        let raw = """
        Verso
        Primera línea\(lineBreak)Segunda línea
        """

        let parsed = LyricImportParser.parse(raw)
        #expect(parsed.slides.count == 1)
        #expect(parsed.slides[0].text == "Primera línea\nSegunda línea")
    }

}
