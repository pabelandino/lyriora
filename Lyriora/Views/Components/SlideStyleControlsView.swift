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
