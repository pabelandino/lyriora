//
//  PresentationFontPicker.swift
//  Lyriora
//

import SwiftUI

private enum PresentationFontPickerMetrics {
    static let macPopoverWidth: CGFloat = 320
    static let macPopoverHeight: CGFloat = 420
}

struct PresentationFontPicker: View {
    @Binding var selection: PresentationFontFamily
    @State private var isPickerPresented = false

    var body: some View {
        LabeledContent("Font") {
            Button {
                isPickerPresented = true
            } label: {
                HStack(spacing: 8) {
                    Text(selection.label)
                        .font(selection.font(size: 15, weight: .regular))
                        .lineLimit(1)
                    Spacer(minLength: 8)
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            #if os(macOS)
            .popover(isPresented: $isPickerPresented, arrowEdge: .bottom) {
                PresentationFontPickerSheet(selection: $selection)
                    .frame(
                        width: PresentationFontPickerMetrics.macPopoverWidth,
                        height: PresentationFontPickerMetrics.macPopoverHeight
                    )
            }
            #else
            .sheet(isPresented: $isPickerPresented) {
                PresentationFontPickerSheet(selection: $selection)
            }
            #endif
        }
    }
}

struct PresentationFontPickerSheet: View {
    @Binding var selection: PresentationFontFamily
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(PresentationFontFamily.allCases) { family in
                        fontRow(for: family)

                        if family.id != PresentationFontFamily.allCases.last?.id {
                            Divider()
                                .padding(.leading, 16)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Font")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        #if os(iOS)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        #else
        .frame(
            minWidth: PresentationFontPickerMetrics.macPopoverWidth,
            minHeight: PresentationFontPickerMetrics.macPopoverHeight
        )
        #endif
    }

    @ViewBuilder
    private func fontRow(for family: PresentationFontFamily) -> some View {
        Button {
            selection = family
            dismiss()
        } label: {
            HStack(spacing: 12) {
                Text(family.label)
                    .font(family.font(size: 18, weight: .regular))
                    .foregroundStyle(.primary)

                Spacer(minLength: 8)

                if selection == family {
                    Image(systemName: "checkmark")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
