//
//  SlideStyleControlsView.swift
//  Lyriora
//

import SwiftUI

struct SlideStyleControlsView: View {
    @Binding var style: SlideTextStyle
    var showsMaxLinesStepper = false
    var onMaxLinesPerSlideChange: (() -> Void)? = nil
    var onFontSizeChange: (() -> Void)? = nil

    private var fontSizeBinding: Binding<Double> {
        Binding(
            get: { style.fontSize },
            set: { newValue in
                style.fontSize = newValue
                style.isAdaptiveScalingEnabled = false
                onFontSizeChange?()
            }
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Picker("Font", selection: $style.fontFamily) {
                ForEach(PresentationFontFamily.allCases) { family in
                    Text(family.label).tag(family)
                }
            }
            .pickerStyle(.menu)

            Stepper(
                "Font size: \(Int(style.fontSize))",
                value: fontSizeBinding,
                in: 8...240,
                step: 1
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

            Stepper("Line spacing: \(Int(style.lineSpacing))", value: $style.lineSpacing, in: 0...24, step: 1)

            Toggle("Shadow", isOn: $style.shadowEnabled)

            if style.shadowEnabled {
                Stepper("Shadow radius: \(Int(style.shadowRadius))", value: $style.shadowRadius, in: 0...24, step: 1)
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
}
