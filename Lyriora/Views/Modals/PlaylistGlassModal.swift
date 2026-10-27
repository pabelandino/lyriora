//
//  PlaylistGlassModal.swift
//  Lyriora
//

import SwiftUI

enum PlaylistModalMetrics {
    static let outerPadding: CGFloat = 20
    static let innerPadding: CGFloat = 16
    static let cornerRadius: CGFloat = 28
    static let rowCornerRadius: CGFloat = 16
    static let columnCornerRadius: CGFloat = 22
    static let rowSpacing: CGFloat = 8
}

struct PlaylistModalShell<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            PlaylistModalScrim()

            content()
                .padding(PlaylistModalMetrics.outerPadding)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct PlaylistModalScrim: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .glassEffect(.regular, in: .rect(cornerRadius: 0, style: .continuous))

            Color.black.opacity(colorScheme == .dark ? 0.08 : 0.03)
        }
        .ignoresSafeArea()
    }
}

struct PlaylistModalHeader: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let onClose: () -> Void
    var primaryAction: (() -> Void)?
    var primarySystemImage: String = "plus"

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.22),
                                Color.white.opacity(0.06)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 44, height: 44)
                    .glassEffect(.regular, in: .circle)
                    .glassControlBorder(Circle())

                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.primary)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.primary)

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 8)

            if let primaryAction {
                Button(action: primaryAction) {
                    GlassCircleIcon(systemName: primarySystemImage, diameter: 38, symbolSize: 16)
                }
                .buttonStyle(.plain)
            }

            Button(action: onClose) {
                GlassCircleIcon(systemName: "xmark", diameter: 38, symbolSize: 14)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Close")
        }
    }
}

struct PlaylistGlassSearchField: View {
    @Binding var text: String
    let placeholder: String

    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(GlassControlChrome.iconForeground(for: colorScheme))
                .frame(width: 32, height: 32)

            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
                .font(.subheadline)
                .focused($isFocused)
                .autocorrectionDisabled()

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .glassEffect(.regular.interactive(), in: .capsule)
        .shadow(color: GlassControlChrome.shadowColor(for: colorScheme), radius: 2, y: 1)
        .glassControlBorder(Capsule())
    }
}

struct PlaylistGlassSectionLabel: View {
    let title: String
    var count: Int?

    var body: some View {
        HStack(spacing: 8) {
            Text(title.uppercased())
                .font(.caption.weight(.bold))
                .foregroundStyle(.secondary)
                .tracking(0.6)

            Spacer()

            if let count {
                Text("\(count)")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .glassEffect(.regular, in: .capsule)
            }
        }
        .padding(.horizontal, 4)
    }
}

struct PlaylistGlassColumn<Content: View>: View {
    let title: String
    var badge: String?
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline.weight(.semibold))

                Spacer()

                if let badge {
                    Text(badge)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .glassEffect(.regular, in: .capsule)
                }
            }

            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: PlaylistModalMetrics.columnCornerRadius, style: .continuous)
                .fill(.clear)
                .glassEffect(.regular, in: .rect(cornerRadius: PlaylistModalMetrics.columnCornerRadius, style: .continuous))
                .glassControlBorder(RoundedRectangle(cornerRadius: PlaylistModalMetrics.columnCornerRadius, style: .continuous))
        }
    }
}

struct PlaylistGlassRowButton: View {
    let title: String
    var subtitle: String?
    var trailingText: String?
    var isSelected: Bool = false
    var accentGradient: LinearGradient?
    var leading: AnyView?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let leading {
                    leading
                } else if let accentGradient {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(accentGradient)
                        .frame(width: 8, height: 44)
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    if let subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }

                Spacer(minLength: 8)

                if let trailingText {
                    Text(trailingText)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .glassEffect(.regular, in: .capsule)
                }

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.green)
                        .shadow(color: .green.opacity(0.35), radius: 6)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: PlaylistModalMetrics.rowCornerRadius, style: .continuous)
                    .fill(.clear)
                    .glassEffect(
                        isSelected ? .regular.interactive() : .regular,
                        in: .rect(cornerRadius: PlaylistModalMetrics.rowCornerRadius, style: .continuous)
                    )
                    .glassControlBorder(RoundedRectangle(cornerRadius: PlaylistModalMetrics.rowCornerRadius, style: .continuous))
            }
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: PlaylistModalMetrics.rowCornerRadius, style: .continuous)
                        .strokeBorder(.white.opacity(0.55), lineWidth: 1.5)
                }
            }
        }
        .buttonStyle(.plain)
        .animation(GlassMorphAnimation.standard, value: isSelected)
    }
}

struct PlaylistGlassNameField: View {
    @Binding var name: String

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Playlist name")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)

            TextField("Sunday Service", text: $name)
                .font(.title2.weight(.bold))
                .textFieldStyle(.plain)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 16, style: .continuous))
                .glassControlBorder(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: GlassControlChrome.shadowColor(for: colorScheme), radius: 3, y: 1)
        }
    }
}

struct PlaylistModalActionBar: View {
    let cancelTitle: String
    let confirmTitle: String
    var isConfirmDisabled: Bool = false
    let onCancel: () -> Void
    let onConfirm: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onCancel) {
                Text(cancelTitle)
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.plain)
            .glassEffect(.regular.interactive(), in: .capsule)
            .glassControlBorder(Capsule())

            Button(action: onConfirm) {
                Text(confirmTitle)
                    .font(.subheadline.weight(.bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.plain)
            .foregroundStyle(isConfirmDisabled ? .secondary : .primary)
            .disabled(isConfirmDisabled)
            .glassEffect(.regular.interactive(), in: .capsule)
            .glassControlBorder(Capsule())
            .opacity(isConfirmDisabled ? 0.55 : 1)
        }
    }
}

struct PlaylistGlassEmptyState: View {
    let title: String
    let systemImage: String
    var message: String?

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: systemImage)
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(.tertiary)

            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            if let message {
                Text(message)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
    }
}

extension View {
    func playlistItemGlassRow(isHighlighted: Bool = false) -> some View {
        padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: PlaylistModalMetrics.rowCornerRadius, style: .continuous)
                    .fill(.clear)
                    .glassEffect(
                        isHighlighted ? .regular.interactive() : .regular,
                        in: .rect(cornerRadius: PlaylistModalMetrics.rowCornerRadius, style: .continuous)
                    )
                    .glassControlBorder(RoundedRectangle(cornerRadius: PlaylistModalMetrics.rowCornerRadius, style: .continuous))
            }
    }
}
