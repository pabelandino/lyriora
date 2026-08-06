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

    @FocusState private var isThemeNameFocused: Bool

    private var trimmedThemeName: String {
        themeName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Theme name", text: $themeName)
                        .focused($isThemeNameFocused)
                        #if os(iOS)
                        .textInputAutocapitalization(.words)
                        .submitLabel(.done)
                        #endif
                        .onSubmit(saveTheme)
                } footer: {
                    Text(message)
                }
            }
            .navigationTitle("Save as Theme?")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save Theme") {
                        saveTheme()
                    }
                    .disabled(trimmedThemeName.isEmpty)
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button(secondaryButtonTitle) {
                    isPresented = false
                    onSecondary()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            }
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        .task {
            // Delay focus until the sheet transition finishes to avoid keyboard placeholder constraint warnings.
            try? await Task.sleep(for: .milliseconds(400))
            guard isPresented else { return }
            isThemeNameFocused = true
        }
    }

    private func saveTheme() {
        guard !trimmedThemeName.isEmpty else { return }
        isPresented = false
        onSaveTheme()
    }
}
