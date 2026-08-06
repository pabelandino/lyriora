//
//  ThemePreviewCard.swift
//  Lyriora
//

import SwiftUI

struct ThemeMiniPreview: View {
    let style: SlideTextStyle
    var sampleText: String = "Aa"
    var cornerRadius: CGFloat = 8
    var height: CGFloat = 44
    var defaultBackgroundSettings: DefaultBackgroundSettings = .default

    var body: some View {
        ZStack {
            PresentationBackgroundLayer(
                background: nil,
                defaultBackgroundSettings: defaultBackgroundSettings,
                blurDefaultBackground: false
            )

            Text(sampleText)
                .font(style.fontFamily.font(size: min(height * 0.45, 20), weight: style.fontWeight))
                .foregroundStyle(style.textColor.color)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .shadow(
                    color: style.shadowEnabled
                        ? style.shadowColor.color.opacity(style.shadowOpacity)
                        : .clear,
                    radius: style.shadowRadius * 0.4,
                    y: style.shadowYOffset * 0.4
                )
        }
        .frame(height: height)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}

struct ThemePickerRow: View {
    let theme: LyricTheme
    var isSelected: Bool = false
    var defaultBackgroundSettings: DefaultBackgroundSettings = .default

    var body: some View {
        HStack(spacing: 12) {
            ThemeMiniPreview(
                style: theme.style,
                height: 40,
                defaultBackgroundSettings: defaultBackgroundSettings
            )
            .frame(width: 56)

            VStack(alignment: .leading, spacing: 2) {
                Text(theme.name)
                    .font(.body.weight(.medium))
                    .foregroundStyle(.primary)

                Text(theme.style.fontFamily.label)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 8)

            if isSelected {
                Image(systemName: "checkmark")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Color.accentColor)
            }
        }
        .padding(.vertical, 4)
    }
}

struct ThemePickerCard: View {
    let theme: LyricTheme
    var isSelected: Bool = false
    var defaultBackgroundSettings: DefaultBackgroundSettings = .default

    var body: some View {
        HStack(spacing: 12) {
            ThemeMiniPreview(
                style: theme.style,
                height: 48,
                defaultBackgroundSettings: defaultBackgroundSettings
            )
            .frame(width: 56)

            VStack(alignment: .leading, spacing: 3) {
                Text(theme.name)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                Text(theme.style.fontFamily.label)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer(minLength: 0)

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(Color.accentColor)
            }
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(isSelected ? Color.accentColor.opacity(0.10) : Color.primary.opacity(0.05))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(
                    isSelected ? Color.accentColor.opacity(0.35) : Color.primary.opacity(0.08),
                    lineWidth: 1
                )
        }
    }
}

struct ThemePickerMenu: View {
    let themes: [LyricTheme]
    @Binding var selectedThemeID: UUID?
    var defaultBackgroundSettings: DefaultBackgroundSettings = .default
    let onSelect: (LyricTheme) -> Void

    @State private var isPickerPresented = false

    private var selectedTheme: LyricTheme? {
        guard let selectedThemeID else { return nil }
        return themes.first { $0.id == selectedThemeID }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Theme")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            if themes.isEmpty {
                Text("No saved themes yet. Customize typography below and save as a Theme when you leave.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Button {
                    isPickerPresented = true
                } label: {
                    themePickerLabel
                }
                .buttonStyle(.plain)
                .popover(isPresented: $isPickerPresented, arrowEdge: .bottom) {
                    themePickerPopover
                }
                #if os(iOS)
                .presentationCompactAdaptation(.popover)
                #endif
            }
        }
    }

    @ViewBuilder
    private var themePickerLabel: some View {
        HStack(spacing: 12) {
            if let selectedTheme {
                ThemeMiniPreview(
                    style: selectedTheme.style,
                    height: 36,
                    defaultBackgroundSettings: defaultBackgroundSettings
                )
                .frame(width: 48)

                VStack(alignment: .leading, spacing: 2) {
                    Text(selectedTheme.name)
                        .font(.body.weight(.medium))
                        .foregroundStyle(.primary)

                    Text(selectedTheme.style.fontFamily.label)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } else {
                ThemeMiniPreview(
                    style: .default,
                    height: 36,
                    defaultBackgroundSettings: defaultBackgroundSettings
                )
                .frame(width: 48)

                Text("Select a theme")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.up.chevron.down")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(12)
        .background(Color.primary.opacity(0.05), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.08), lineWidth: 1)
        }
    }

    @ViewBuilder
    private var themePickerPopover: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(themes) { theme in
                    Button {
                        selectedThemeID = theme.id
                        onSelect(theme)
                        isPickerPresented = false
                    } label: {
                        ThemePickerCard(
                            theme: theme,
                            isSelected: theme.id == selectedThemeID,
                            defaultBackgroundSettings: defaultBackgroundSettings
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(12)
        }
        .frame(minWidth: 280, maxHeight: 320)
    }
}

struct ThemePreviewCard: View {
    let theme: LyricTheme
    var isSelected: Bool = false
    let onSelect: () -> Void

    private let cornerRadius: CGFloat = 10

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 8) {
                ThemeMiniPreview(style: theme.style, cornerRadius: cornerRadius, height: 56)

                Text(theme.name)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                Text(theme.style.fontFamily.label)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            .padding(10)
            .frame(width: 120)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(isSelected ? Color.accentColor.opacity(0.12) : Color.primary.opacity(0.05))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(isSelected ? Color.accentColor : Color.clear, lineWidth: 2)
            }
        }
        .buttonStyle(.plain)
    }
}

struct ThemeGalleryView: View {
    let themes: [LyricTheme]
    @Binding var selectedThemeID: UUID?
    let onSelect: (LyricTheme) -> Void

    var body: some View {
        ThemePickerMenu(
            themes: themes,
            selectedThemeID: $selectedThemeID,
            onSelect: onSelect
        )
    }
}
