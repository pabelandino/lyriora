//
//  SlideStyleControlsView.swift
//  Lyriora
//

import SwiftUI

struct SlideStyleControlsView: View {
    @Binding var style: SlideTextStyle
    var showsMaxLinesStepper = false
    var showsGlobalTypography = true
    var selectedWordTarget: TextAnimationTarget? = nil
    var wordFontSizeOverrides: Binding<[WordFontSizeOverride]>? = nil
    var onMaxLinesPerSlideChange: (() -> Void)? = nil
    var onFontSizeChange: (() -> Void)? = nil
    var onLayoutStyleChange: (() -> Void)? = nil

    private var fontSizeBinding: Binding<Double> {
        Binding(
            get: { style.fontSize },
            set: { newValue in
                let snapped = (newValue / 2).rounded() * 2
                style.fontSize = min(max(snapped, 8), 240)
                style.isAdaptiveScalingEnabled = false
                onFontSizeChange?()
                onLayoutStyleChange?()
            }
        )
    }

    private var horizontalMarginBinding: Binding<Double> {
        Binding(
            get: { style.horizontalPaddingRatio * 100 },
            set: { newValue in
                style.horizontalPaddingRatio = newValue / 100
                style.paddingRatio = (style.horizontalPaddingRatio + style.verticalPaddingRatio) / 2
                onLayoutStyleChange?()
            }
        )
    }

    private var verticalMarginBinding: Binding<Double> {
        Binding(
            get: { style.verticalPaddingRatio * 100 },
            set: { newValue in
                style.verticalPaddingRatio = newValue / 100
                style.paddingRatio = (style.horizontalPaddingRatio + style.verticalPaddingRatio) / 2
                onLayoutStyleChange?()
            }
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if showsGlobalTypography {
                GroupBox("Typography") {
                    VStack(alignment: .leading, spacing: 14) {
                        PresentationFontPicker(selection: $style.fontFamily)

                        Stepper(
                            "Slide font size: \(Int(style.fontSize))",
                            value: fontSizeBinding,
                            in: 8...240,
                            step: 2
                        )

                        Picker("Weight", selection: $style.fontWeight) {
                            ForEach(PresentationFontWeight.allCases) { weight in
                                Text(weight.label).tag(weight)
                            }
                        }
                        .pickerStyle(.segmented)

                        ColorPicker("Text color", selection: Binding(
                            get: { style.textColor.color },
                            set: { style.textColor = CodableColor(from: $0) }
                        ))

                        wordSizeSection
                    }
                }

                GroupBox("Layout") {
                    layoutControls
                }

                GroupBox("Shadow") {
                    shadowControls
                }
            } else if wordFontSizeOverrides != nil {
                GroupBox("Word Size") {
                    wordSizeSection
                }
            }
        }
    }

    @ViewBuilder
    private var layoutControls: some View {
        VStack(alignment: .leading, spacing: 14) {
            Stepper(
                "Horizontal margin: \(Int(style.horizontalPaddingRatio * 100))%",
                value: horizontalMarginBinding,
                in: 0...20,
                step: 1
            )

            Stepper(
                "Vertical margin: \(Int(style.verticalPaddingRatio * 100))%",
                value: verticalMarginBinding,
                in: 0...20,
                step: 1
            )

            Stepper("Line spacing: \(Int(style.lineSpacing))", value: $style.lineSpacing, in: 0...24, step: 1)
                .onChange(of: style.lineSpacing) { _, _ in
                    onLayoutStyleChange?()
                }

            if showsMaxLinesStepper {
                Stepper(
                    "Max lines per slide: \(style.maxLinesPerSlide)",
                    value: $style.maxLinesPerSlide,
                    in: 1...8
                )
                .onChange(of: style.maxLinesPerSlide) { _, _ in
                    onMaxLinesPerSlideChange?()
                }
            }
        }
    }

    @ViewBuilder
    private var shadowControls: some View {
        VStack(alignment: .leading, spacing: 14) {
            Toggle("Shadow", isOn: $style.shadowEnabled)

            if style.shadowEnabled {
                Stepper("Shadow radius: \(Int(style.shadowRadius))", value: $style.shadowRadius, in: 0...24, step: 1)
            }
        }
    }

    @ViewBuilder
    private var wordSizeSection: some View {
        if wordFontSizeOverrides != nil {
            if showsGlobalTypography {
                Divider()
            }

            if case .word(let line, let word) = selectedWordTarget {
                selectedWordSizeControls(line: line, word: word)
            } else {
                Text("Tap a word in the preview to set an individual font size.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    @ViewBuilder
    private func selectedWordSizeControls(line: Int, word: Int) -> some View {
        let overrides = wordFontSizeOverrides?.wrappedValue ?? []
        let existing = WordFontSizeResolver.override(for: line, word: word, in: overrides)
        let displaySize = existing?.fontSize ?? style.fontSize
        let hasCustomSize = existing != nil

        VStack(alignment: .leading, spacing: 10) {
            Text("Selected word")
                .font(.subheadline.weight(.semibold))

            Text(TextAnimationTarget.word(line: line, word: word).label)
                .font(.caption)
                .foregroundStyle(.secondary)

            Stepper(
                "Word font size: \(Int(displaySize))",
                value: wordFontSizeBinding(line: line, word: word, fallback: style.fontSize),
                in: 8...240,
                step: 2
            )

            if hasCustomSize {
                Button("Reset word to slide size", role: .destructive) {
                    guard var overrides = wordFontSizeOverrides?.wrappedValue else { return }
                    WordFontSizeResolver.remove(line: line, word: word, from: &overrides)
                    wordFontSizeOverrides?.wrappedValue = overrides
                }
                .font(.caption)
            }
        }
    }

    private func wordFontSizeBinding(line: Int, word: Int, fallback: Double) -> Binding<Double> {
        Binding(
            get: {
                WordFontSizeResolver.override(for: line, word: word, in: wordFontSizeOverrides?.wrappedValue ?? [])?.fontSize
                    ?? fallback
            },
            set: { newValue in
                guard var overrides = wordFontSizeOverrides?.wrappedValue else { return }
                let snapped = (newValue / 2).rounded() * 2
                let clamped = min(max(snapped, 8), 240)
                WordFontSizeResolver.upsert(line: line, word: word, fontSize: clamped, in: &overrides)
                wordFontSizeOverrides?.wrappedValue = overrides
                onLayoutStyleChange?()
            }
        )
    }
}
