//
//  TransitionSpeedControl.swift
//  Lyriora
//

import SwiftUI

struct TransitionSpeedControl: View {
    @Binding var speed: Double
    var wordCount: Int = 1
    var wordStagger: Bool = false
    var isEnabled: Bool = true
    var onEditingEnded: (() -> Void)? = nil

    private var durationLabel: String {
        SlideTransitionTiming.formattedEnterDuration(
            wordCount: wordCount,
            speed: speed,
            wordStagger: wordStagger
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            LabeledContent("Speed") {
                Text(durationLabel)
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }

            Slider(
                value: $speed,
                in: 0.25...3,
                onEditingChanged: { isEditing in
                    if !isEditing {
                        onEditingEnded?()
                    }
                }
            )
            .disabled(!isEnabled)

            HStack {
                Text("Slower")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("Higher = faster")
                    .font(.caption2.weight(.medium))
                    .foregroundStyle(.secondary)
                Spacer()
                Text("Faster")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
