//
//  SlideStyleControlsView.swift
//  Lyriora
//

import SwiftUI

struct SlideStyleControlsView: View {
    @Binding var style: SlideTextStyle
    var showsMaxLinesStepper = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Picker("Font", selection: $style.fontFamily) {
                ForEach(PresentationFontFamily.allCases) { family in
                    Text(family.label).tag(family)
                }
            }
            .pickerStyle(.menu)

            Toggle("Adaptive font size", isOn: $style.isAdaptiveScalingEnabled)

            if style.isAdaptiveScalingEnabled {
                HStack {
                    Stepper("Min \(Int(style.minFontSize))", value: $style.minFontSize, in: 8...120, step: 1)
                    Stepper("Max \(Int(style.maxFontSize))", value: $style.maxFontSize, in: 8...120, step: 1)
                }
            } else {
                Stepper("Font size: \(Int(style.maxFontSize))", value: $style.maxFontSize, in: 8...120, step: 1)
            }

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
            }
        }
    }
}
