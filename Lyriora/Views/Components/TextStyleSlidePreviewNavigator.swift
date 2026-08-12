//
//  TextStyleSlidePreviewNavigator.swift
//  Lyriora
//

import SwiftUI

struct TextStyleSlidePreviewNavigator: View {
    let slides: [LyricSlide]
    let language: LyricLanguage
    @Binding var selectedIndex: Int

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Button {
                    selectedIndex = max(0, selectedIndex - 1)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.body.weight(.semibold))
                        .frame(width: 36, height: 36)
                        .contentShape(Circle())
                }
                .buttonStyle(.plain)
                .disabled(selectedIndex <= 0)

                VStack(spacing: 2) {
                    Text("Slide \(selectedIndex + 1) of \(slides.count)")
                        .font(.subheadline.weight(.semibold))

                    if slides.indices.contains(selectedIndex) {
                        Text(slides[selectedIndex].tag.localizedName(for: language))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(minWidth: 120)

                Button {
                    selectedIndex = min(slides.count - 1, selectedIndex + 1)
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.body.weight(.semibold))
                        .frame(width: 36, height: 36)
                        .contentShape(Circle())
                }
                .buttonStyle(.plain)
                .disabled(selectedIndex >= slides.count - 1)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(slides.enumerated()), id: \.element.id) { index, slide in
                        Button {
                            selectedIndex = index
                        } label: {
                            Text("\(slide.order + 1)")
                                .font(.caption.weight(.semibold))
                                .monospacedDigit()
                                .frame(minWidth: 34, minHeight: 30)
                                .padding(.horizontal, 4)
                                .background(
                                    index == selectedIndex
                                        ? Color.accentColor.opacity(0.18)
                                        : Color.primary.opacity(0.06),
                                    in: Capsule()
                                )
                                .overlay {
                                    Capsule()
                                        .strokeBorder(
                                            index == selectedIndex
                                                ? Color.accentColor.opacity(0.45)
                                                : Color.primary.opacity(0.08),
                                            lineWidth: 1
                                        )
                                }
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Slide \(slide.order + 1)")
                    }
                }
                .padding(.horizontal, 2)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
