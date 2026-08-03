//
//  DisplayInfoSheet.swift
//  Lyriora
//

import SwiftUI

struct DisplayInfoSheet: View {
    let displayInfo: ExternalDisplayInfo
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("External Display") {
                    LabeledContent("Status") {
                        Text(displayInfo.isConnected ? "Connected" : "Not connected")
                    }

                    LabeledContent("Name") {
                        Text(displayInfo.name)
                    }

                    LabeledContent("Resolution") {
                        Text(displayInfo.resolutionDescription)
                    }
                }
            }
            .navigationTitle("Display Info")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        #if os(macOS)
        .frame(minWidth: 360, minHeight: 220)
        #endif
    }
}
