//
//  TypewriterRevealText.swift
//  Lyriora
//

import SwiftUI

struct TypewriterRevealText: View {
    let text: String
    var progress: Double
    let font: Font
    let color: Color
    var showsCursor: Bool = true

    private var visibleCharacterCount: Int {
        guard !text.isEmpty else { return 0 }
        let scaled = max(0, min(1, progress))
        return min(text.count, Int(round(scaled * Double(text.count))))
    }

    private var cursorVisible: Bool {
        showsCursor && progress > 0 && progress < 1 && visibleCharacterCount < text.count
    }

    var body: some View {
        HStack(spacing: 0) {
            Text(String(text.prefix(visibleCharacterCount)))
                .font(font)
                .foregroundStyle(color)

            if cursorVisible {
                Text("|")
                    .font(font.weight(.light))
                    .foregroundStyle(color.opacity(0.85))
            }
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct TypewriterTransitionModifier: AnimatableModifier {
    let text: String
    var progress: Double
    let font: Font
    let color: Color
    var showsCursor: Bool

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        TypewriterRevealText(
            text: text,
            progress: progress,
            font: font,
            color: color,
            showsCursor: showsCursor
        )
    }
}

extension View {
    func typewriterTransition(
        text: String,
        progress: Double,
        font: Font,
        color: Color,
        showsCursor: Bool = true
    ) -> some View {
        modifier(
            TypewriterTransitionModifier(
                text: text,
                progress: progress,
                font: font,
                color: color,
                showsCursor: showsCursor
            )
        )
    }
}
