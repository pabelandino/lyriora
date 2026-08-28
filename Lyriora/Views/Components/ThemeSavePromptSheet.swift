//
//  ThemeSavePromptSheet.swift
//  Lyriora
//

import SwiftUI

/// Sheet-based theme naming prompt. Avoids UIAlertController text-field warnings and keyboard constraint conflicts.
struct ThemeSavePromptSheet: View {
    @Binding var isPresented: Bool
    @Binding var themeName: String

    let message: String
    let secondaryButtonTitle: String
    let onSaveTheme: () -> Void
    let onSecondary: () -> Void

    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isThemeNameFocused: Bool

    private var trimmedThemeName: String {
        themeName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            header

            themeNameField

            Spacer(minLength: 0)

            VStack(spacing: 14) {
                PlaylistModalActionBar(
                    cancelTitle: "Cancel",
                    confirmTitle: "Save Theme",
                    isConfirmDisabled: trimmedThemeName.isEmpty,
                    onCancel: { isPresented = false },
                    onConfirm: saveTheme
                )

                Button {
                    isPresented = false
                    onSecondary()
                } label: {
                    Text(secondaryButtonTitle)
                        .font(.subheadline.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 4)
                }
                .buttonStyle(.plain)
                .foregroundStyle(.secondary)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        #if os(iOS)
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        #else
        .frame(width: 440, height: 340)
        #endif
        .task {
            try? await Task.sleep(for: .milliseconds(400))
            guard isPresented else { return }
            isThemeNameFocused = true
        }
    }

    @ViewBuilder
    private var header: some View {
        HStack(alignment: .top, spacing: 14) {
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
                    .frame(width: 48, height: 48)
                    .glassEffect(.regular, in: .circle)
                    .glassControlBorder(Circle())

                Image(systemName: "paintpalette.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.primary)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Save as Theme?")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.primary)

                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
    }

    @ViewBuilder
    private var themeNameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Theme name")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)

            TextField("My Theme", text: $themeName)
                .font(.title3.weight(.semibold))
                .textFieldStyle(.plain)
                .focused($isThemeNameFocused)
                #if os(iOS)
                .textInputAutocapitalization(.words)
                .submitLabel(.done)
                #endif
                .onSubmit(saveTheme)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 16, style: .continuous))
                .glassControlBorder(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: GlassControlChrome.shadowColor(for: colorScheme), radius: 3, y: 1)
        }
    }

    private func saveTheme() {
        guard !trimmedThemeName.isEmpty else { return }
        isPresented = false
        onSaveTheme()
    }
}
