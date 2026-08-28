//
//  LyricEditorChrome.swift
//  Lyriora
//

import SwiftUI

enum LyricEditorChrome {
    static let macHeaderTopInset: CGFloat = 22
    static let macHeaderBottomInset: CGFloat = 6
    static let navCornerRadius: CGFloat = 10
    static let sidebarInset: CGFloat = 16

    static func navSelectionFill(isSelected: Bool) -> Color {
        isSelected ? Color.primary.opacity(0.10) : .clear
    }

    static func navSelectionStroke(isSelected: Bool) -> Color {
        isSelected ? Color.primary.opacity(0.14) : .clear
    }
}

struct LyricEditorNavRow: View {
    let title: String
    let systemImage: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: systemImage)
                    .font(.body.weight(.semibold))
                    .frame(width: 22, alignment: .center)

                Text(title)
                    .font(.body.weight(isSelected ? .semibold : .regular))

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: LyricEditorChrome.navCornerRadius, style: .continuous)
                    .fill(LyricEditorChrome.navSelectionFill(isSelected: isSelected))
            }
            .overlay {
                RoundedRectangle(cornerRadius: LyricEditorChrome.navCornerRadius, style: .continuous)
                    .strokeBorder(LyricEditorChrome.navSelectionStroke(isSelected: isSelected), lineWidth: 1)
            }
            .contentShape(RoundedRectangle(cornerRadius: LyricEditorChrome.navCornerRadius, style: .continuous))
        }
        .buttonStyle(.plain)
        .foregroundStyle(isSelected ? Color.primary : Color.secondary)
    }
}

struct LyricEditorHeaderButton: View {
    @Environment(\.colorScheme) private var colorScheme

    let title: String
    var isEmphasized: Bool = false
    var isEnabled: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(isEmphasized ? .subheadline.weight(.bold) : .subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .padding(.horizontal, isEmphasized ? 18 : 14)
                .padding(.vertical, 6)
                .background {
                    Capsule()
                        .fill(.clear)
                        .glassEffect(.regular, in: .capsule)
                        .glassControlBorder(Capsule())
                }
                .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.45)
        .shadow(
            color: GlassControlChrome.shadowColor(for: colorScheme).opacity(isEmphasized ? 0.9 : 0.55),
            radius: 2,
            y: 1
        )
    }
}

struct LyricEditorHeaderBar: View {
    let title: String
    let canSave: Bool
    let saveHint: String?
    let onCancel: () -> Void
    let onSave: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            HStack {
                LyricEditorHeaderButton(title: "Cancel", action: onCancel)
            }
            .frame(width: 116, alignment: .leading)

            Spacer(minLength: 12)

            VStack(spacing: 2) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                if let saveHint {
                    Text(saveHint)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            .multilineTextAlignment(.center)

            Spacer(minLength: 12)

            HStack {
                LyricEditorHeaderButton(
                    title: "Save",
                    isEmphasized: true,
                    isEnabled: canSave,
                    action: onSave
                )
            }
            .frame(width: 116, alignment: .trailing)
        }
        .padding(.leading, 72)
        .padding(.trailing, 20)
        .frame(maxWidth: .infinity)
    }
}

struct MacLyricEditorHeaderChrome: View {
    let title: String
    let canSave: Bool
    let saveHint: String?
    let onCancel: () -> Void
    let onSave: () -> Void

    var body: some View {
        #if os(macOS)
        VStack(spacing: 0) {
            LyricEditorHeaderBar(
                title: title,
                canSave: canSave,
                saveHint: saveHint,
                onCancel: onCancel,
                onSave: onSave
            )
            .padding(.top, LyricEditorChrome.macHeaderTopInset)
            .padding(.bottom, LyricEditorChrome.macHeaderBottomInset)

            Divider()
        }
        .frame(maxWidth: .infinity)
        .background {
            Color(nsColor: .windowBackgroundColor)
                .ignoresSafeArea(edges: .top)
        }
        .zIndex(1)
        #else
        EmptyView()
        #endif
    }
}
