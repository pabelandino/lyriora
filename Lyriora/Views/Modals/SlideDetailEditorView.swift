//
//  SlideDetailEditorView.swift
//  Lyriora
//

import SwiftUI

struct SlideDetailEditorView: View {
    @Binding var slide: LyricSlide
    @Binding var styleProfile: LyricStyleProfile
    let language: LyricLanguage
    let defaultBackgroundSettings: DefaultBackgroundSettings
    let onDelete: () -> Void
    var onSlideContentChanged: (() -> Void)? = nil

    @Environment(\.dismiss) private var dismiss
    @State private var usesCustomStyle: Bool

    init(
        slide: Binding<LyricSlide>,
        styleProfile: Binding<LyricStyleProfile>,
        language: LyricLanguage,
        defaultBackgroundSettings: DefaultBackgroundSettings = .default,
        onDelete: @escaping () -> Void,
        onSlideContentChanged: (() -> Void)? = nil
    ) {
        _slide = slide
        _styleProfile = styleProfile
        self.language = language
        self.defaultBackgroundSettings = defaultBackgroundSettings
        self.onDelete = onDelete
        self.onSlideContentChanged = onSlideContentChanged
        _usesCustomStyle = State(initialValue: slide.wrappedValue.style != nil)
    }

    private var activeStyle: Binding<SlideTextStyle> {
        Binding(
            get: {
                slide.style ?? styleProfile.resolvedStyle(for: slide)
            },
            set: { newStyle in
                slide.style = newStyle
                usesCustomStyle = true
            }
        )
    }

    var body: some View {
        StickyPreviewEditorLayout {
            LyricSlideLivePreview(
                slide: slide,
                style: activeStyle.wrappedValue,
                language: language,
                scopeLabel: "Live Preview",
                compact: true,
                backgroundStyle: .settingsDefault(defaultBackgroundSettings)
            )
        } content: {
            VStack(alignment: .leading, spacing: 24) {
                GroupBox("Slide Text") {
                    TextEditor(text: $slide.text)
                        .frame(minHeight: 120)
                        .scrollContentBackground(.hidden)
                        .padding(8)
                        .background(Color.primary.opacity(0.05), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }

                GroupBox("Tag") {
                    Picker("Section", selection: $slide.tag) {
                        ForEach(LyricSlideTag.allCases) { tag in
                            Text(tag.localizedName(for: language)).tag(tag)
                        }
                    }
                    .pickerStyle(.menu)
                }

                GroupBox("Typography") {
                    Toggle("Custom style for this slide", isOn: $usesCustomStyle)
                        .onChange(of: usesCustomStyle) { _, enabled in
                            if enabled {
                                if slide.style == nil {
                                    slide.style = styleProfile.resolvedStyle(for: slide)
                                }
                            } else {
                                slide.style = nil
                            }
                        }

                    if usesCustomStyle {
                        SlideStyleControlsView(style: activeStyle)
                    } else {
                        Text("Using global style from \"\(styleProfile.name)\".")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Button("Delete Slide", role: .destructive) {
                    onDelete()
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationTitle("Slide \(slide.order + 1)")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .onDisappear {
            onSlideContentChanged?()
        }
    }
}
