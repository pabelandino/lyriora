//
//  SlideGridView.swift
//  Lyriora
//

import SwiftUI

struct SlideGridView: View {
    let slides: [LyricSlide]
    let selectedSlideIndex: Int?
    let presentationState: PresentationState
    let defaultBackgroundSettings: DefaultBackgroundSettings
    let onSelect: (LyricSlide) -> Void

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            if slides.isEmpty {
                ContentUnavailableView(
                    "No slides",
                    systemImage: "rectangle.on.rectangle.slash",
                    description: Text("Select a lyric from the library to see its slides.")
                )
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(slides) { slide in
                            SlideThumbnailView(
                                slide: slide,
                                isSelected: slide.index == selectedSlideIndex,
                                presentationState: presentationState,
                                defaultBackgroundSettings: defaultBackgroundSettings
                            )
                            .onTapGesture {
                                onSelect(slide)
                            }
                        }
                    }
                    .padding(16)
                }
            }
        }
    }
}

private struct SlideThumbnailView: View {
    let slide: LyricSlide
    let isSelected: Bool
    let presentationState: PresentationState
    let defaultBackgroundSettings: DefaultBackgroundSettings

    private let cornerRadius: CGFloat = 16

    var body: some View {
        ZStack {
            ToggleablePresentationBackgroundLayer(
                isVisible: presentationState.showBackground,
                background: presentationState.background,
                defaultBackgroundSettings: defaultBackgroundSettings
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Text(slide.text)
                .font(.caption.weight(.semibold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
                .padding(10)
                .shadow(color: .black.opacity(0.35), radius: 4, y: 2)
        }
        .frame(minHeight: 72)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .glassEffect(.clear, in: .rect(cornerRadius: cornerRadius))
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(.white.opacity(0.9), lineWidth: 2)
            }
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
