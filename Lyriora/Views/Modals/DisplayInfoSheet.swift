//
//  DisplayInfoSheet.swift
//  Lyriora
//

import SwiftUI

struct DisplayInfoSheet: View {
    let displayInfo: ExternalDisplayInfo
    let isPresentationEnabled: Bool
    let isPresentationActive: Bool
    let onRefreshPresentation: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("External Display") {
                    LabeledContent("Status") {
                        Text(statusDescription)
                    }

                    LabeledContent("Name") {
                        Text(displayInfo.name)
                    }

                    LabeledContent("Resolution") {
                        Text(displayInfo.resolutionDescription)
                    }

                    if isPresentationEnabled {
                        LabeledContent("Presentation") {
                            Text(isPresentationActive ? "Showing content" : "Waiting for display")
                        }
                    }
                }

                Section {
                    Button {
                        onRefreshPresentation()
                    } label: {
                        Label("Rescale Content", systemImage: "arrow.up.left.and.arrow.down.right")
                    }
                    .disabled(!displayInfo.isConnected || !isPresentationEnabled)
                } footer: {
                    Text("Use this if the external display was reconnected or its resolution changed and content no longer fills the screen.")
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
        .frame(minWidth: 360, minHeight: 280)
        #endif
    }

    private var statusDescription: String {
        if displayInfo.isConnected {
            return "Connected"
        }
        if isPresentationEnabled {
            return "Not connected (will resume when available)"
        }
        return "Not connected"
    }
}
