//
//  ProTextSegmentView.swift
//  Lyriora
//

import SwiftUI

struct ProTextSegmentView: View {
    let text: String
    let font: Font
    let color: Color
    let kind: TextAnimationKind
    let time: TimeInterval
    let segmentIndex: Int
    let intensity: Double
    let speed: Double

    var body: some View {
        let phase = time * speed
        let power = intensity

        switch kind {
        case .neonGlow, .gradientNeon:
            neonText(phase: phase, power: power)
        case .echoTrail, .vibrateEcho:
            echoText(phase: phase, power: power)
        case .chromaticShift:
            chromaticText(phase: phase, power: power)
        case .outlineStack:
            outlineStackText(phase: phase, power: power)
        case .kineticSlam:
            kineticSlamText(phase: phase, power: power)
        case .glitchSlice:
            glitchText(phase: phase, power: power, hudStyle: false)
        case .hudGlitch:
            glitchText(phase: phase, power: power, hudStyle: true)
        default:
            Text(text)
                .font(font)
                .foregroundStyle(color)
        }
    }

    @ViewBuilder
    private func neonText(phase: TimeInterval, power: Double) -> some View {
        let glow = 0.45 + 0.35 * power * (0.5 + 0.5 * sin(phase * 3))

        ZStack {
            Text(text)
                .font(font)
                .foregroundStyle(Color.orange.opacity(0.55))
                .blur(radius: 8 * glow)
                .scaleEffect(1.04)

            if kind == .gradientNeon {
                Text(text)
                    .font(font.bold())
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.yellow, .orange, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: .yellow.opacity(glow), radius: 10 * power, y: 0)
                    .shadow(color: .orange.opacity(glow * 0.7), radius: 18 * power, y: 0)
            } else {
                Text(text)
                    .font(font.bold())
                    .foregroundStyle(.yellow)
                    .shadow(color: .yellow.opacity(glow), radius: 10 * power, y: 0)
                    .shadow(color: .orange.opacity(glow * 0.7), radius: 18 * power, y: 0)
            }
        }
    }

    @ViewBuilder
    private func echoText(phase: TimeInterval, power: Double) -> some View {
        let layers = kind == .vibrateEcho ? 5 : 3
        ZStack {
            ForEach(0..<layers, id: \.self) { layer in
                let offset = echoOffset(layer: layer, phase: phase, power: power)
                Text(text)
                    .font(font)
                    .foregroundStyle(color.opacity((0.18 + Double(layers - layer)) * 0.12))
                    .offset(offset)
            }

            Text(text)
                .font(font.weight(.heavy))
                .foregroundStyle(color)
        }
    }

    @ViewBuilder
    private func chromaticText(phase: TimeInterval, power: Double) -> some View {
        let shift = (4 + 8 * power) * sin(phase * 4)
        ZStack {
            Text(text)
                .font(font.weight(.bold))
                .foregroundStyle(.red.opacity(0.75))
                .offset(x: shift, y: 0)
            Text(text)
                .font(font.weight(.bold))
                .foregroundStyle(.cyan.opacity(0.75))
                .offset(x: -shift, y: 0)
            Text(text)
                .font(font.weight(.bold))
                .foregroundStyle(color)
        }
    }

    @ViewBuilder
    private func outlineStackText(phase: TimeInterval, power: Double) -> some View {
        let pulse = 0.5 + 0.5 * sin(phase * 2.5)
        ZStack {
            Text(text)
                .font(font.weight(.black))
                .foregroundStyle(.clear)
                .overlay {
                    Text(text)
                        .font(font.weight(.black))
                        .foregroundStyle(.red.opacity(0.85))
                        .offset(x: 2 * power, y: 2 * power)
                }

            Text(text)
                .font(font.weight(.black))
                .foregroundStyle(.clear)
                .overlay {
                    Text(text)
                        .font(font.weight(.black))
                        .foregroundStyle(.yellow.opacity(0.35 + 0.45 * pulse))
                }
                .scaleEffect(1 + 0.06 * power * pulse)

            Text(text)
                .font(font.weight(.heavy))
                .foregroundStyle(color)
        }
    }

    @ViewBuilder
    private func glitchText(phase: TimeInterval, power: Double, hudStyle: Bool) -> some View {
        let gate = sin(phase * 8 + Double(segmentIndex)) > (hudStyle ? 0.55 : 0.72)
        let sliceShift = sin(phase * 14 + Double(segmentIndex) * 1.7) * (hudStyle ? 10 : 14) * power
        let rgbShift = (3 + 6 * power) * sin(phase * 5 + Double(segmentIndex))

        ZStack {
            if gate {
                Text(text)
                    .font(font.weight(.heavy))
                    .foregroundStyle(.cyan.opacity(hudStyle ? 0.7 : 0.55))
                    .offset(x: rgbShift, y: hudStyle ? 1 : 0)
                    .blendMode(.screen)

                Text(text)
                    .font(font.weight(.heavy))
                    .foregroundStyle(.red.opacity(hudStyle ? 0.7 : 0.55))
                    .offset(x: -rgbShift, y: hudStyle ? -1 : 0)
                    .blendMode(.screen)

                Text(text)
                    .font(font.weight(.heavy))
                    .foregroundStyle(color)
                    .offset(x: sliceShift)
            } else {
                Text(text)
                    .font(font.weight(.heavy))
                    .foregroundStyle(color)
            }

            if hudStyle, gate {
                Text(text)
                    .font(font.weight(.heavy))
                    .foregroundStyle(.white.opacity(0.12))
                    .offset(x: sliceShift * 0.4, y: 1)
                    .blur(radius: 0.3)
            }
        }
    }

    @ViewBuilder
    private func kineticSlamText(phase: TimeInterval, power: Double) -> some View {
        let slam = abs(sin(phase * 2))
        Text(text)
            .font(font.weight(.black))
            .foregroundStyle(color)
            .scaleEffect(1 + 0.35 * power * slam, anchor: .center)
            .rotationEffect(.degrees(sin(phase * 3) * 4 * power))
            .offset(y: -10 * power * slam)
    }

    private func echoOffset(layer: Int, phase: TimeInterval, power: Double) -> CGSize {
        if kind == .vibrateEcho {
            let x = sin(phase * 10 + Double(layer)) * 3 * power
            let y = cos(phase * 8 + Double(layer)) * 2 * power
            return CGSize(width: x + Double(layer) * power, height: y - Double(layer) * power * 0.6)
        }

        return CGSize(
            width: Double(layer + 1) * 2.5 * power,
            height: -Double(layer + 1) * 1.5 * power
        )
    }
}
