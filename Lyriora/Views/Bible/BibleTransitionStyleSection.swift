//
//  BibleTransitionStyleSection.swift
//  Lyriora
//

import SwiftUI

struct BibleTransitionStyleSection: View {
    @Binding var animationProfile: SlideAnimationProfile

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transition")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            Text("Enter/exit animation when you present a verse.")
                .font(.caption)
                .foregroundStyle(.tertiary)

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 96), spacing: 8)],
                spacing: 8
            ) {
                ForEach(TextAnimationKind.basicCases) { kind in
                    transitionChip(
                        kind,
                        isActive: animationProfile.transitionKind == kind
                    ) {
                        animationProfile.transitionKind = kind
                        animationProfile.resetEffects()
                    }
                }
            }

            if animationProfile.hasTransition {
                VStack(alignment: .leading, spacing: 10) {
                    Toggle("Word by word reveal", isOn: $animationProfile.transitionWordStagger)

                    LabeledContent("Intensity") {
                        Slider(value: $animationProfile.transitionIntensity, in: 0.2...2)
                    }

                    LabeledContent("Speed") {
                        Slider(value: $animationProfile.transitionSpeed, in: 0.25...3)
                    }
                }
                .padding(.top, 4)
            }
        }
    }

    private func transitionChip(
        _ kind: TextAnimationKind,
        isActive: Bool,
        apply: @escaping () -> Void
    ) -> some View {
        Button(action: apply) {
            VStack(spacing: 6) {
                Image(systemName: kind.systemImage)
                    .font(.body.weight(.semibold))
                Text(kind.displayName)
                    .font(.caption2.weight(.medium))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)
            }
            .frame(maxWidth: .infinity, minHeight: 58)
            .padding(8)
            .foregroundStyle(isActive ? Color.accentColor : Color.primary)
            .background(
                isActive ? Color.accentColor.opacity(0.14) : Color.primary.opacity(0.05),
                in: RoundedRectangle(cornerRadius: 12, style: .continuous)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(
                        isActive ? Color.accentColor.opacity(0.45) : Color.primary.opacity(0.08),
                        lineWidth: 1
                    )
            }
        }
        .buttonStyle(.plain)
    }
}

struct BibleThemeQuickPicker: View {
    let themes: [LyricTheme]
    let selectedThemeID: UUID?
    let defaultBackgroundSettings: DefaultBackgroundSettings
    let onSelect: (LyricTheme) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Saved styles")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            if themes.isEmpty {
                Text("Save a theme from the lyric editor to reuse it here.")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(themes) { theme in
                            Button {
                                onSelect(theme)
                            } label: {
                                VStack(spacing: 6) {
                                    ThemeMiniPreview(
                                        style: theme.style,
                                        sampleText: "Aa",
                                        cornerRadius: 10,
                                        height: 52,
                                        defaultBackgroundSettings: defaultBackgroundSettings
                                    )
                                    .frame(width: 72)

                                    Text(theme.name)
                                        .font(.caption2.weight(.medium))
                                        .foregroundStyle(.primary)
                                        .lineLimit(1)
                                        .frame(width: 72)
                                }
                                .padding(10)
                                .background {
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .fill(
                                            theme.id == selectedThemeID
                                                ? Color.accentColor.opacity(0.12)
                                                : Color.primary.opacity(0.05)
                                        )
                                }
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .strokeBorder(
                                            theme.id == selectedThemeID
                                                ? Color.accentColor.opacity(0.4)
                                                : Color.primary.opacity(0.08),
                                            lineWidth: 1
                                        )
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 2)
                }
            }
        }
    }
}
