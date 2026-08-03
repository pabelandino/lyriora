//
//  NewLyricSheet.swift
//  Lyriora
//

import SwiftUI

struct NewLyricSheet: View {
    @Bindable var viewModel: AppViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var content = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("Slide title", text: $title)
                }

                Section {
                    TextEditor(text: $content)
                        .frame(minHeight: 220)
                } header: {
                    Text("Lyrics")
                } footer: {
                    Text("Separate slides with a blank line or a line containing only ---.")
                }
            }
            .navigationTitle("New Lyric")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.createLyric(title: title, content: content)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                              || content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        #if os(macOS)
        .frame(minWidth: 480, minHeight: 420)
        #endif
    }
}
