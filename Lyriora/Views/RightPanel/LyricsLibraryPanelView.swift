//
//  LyricsLibraryPanelView.swift
//  Lyriora
//

import SwiftUI

struct LyricsLibraryPanelView: View {
    @Bindable var viewModel: AppViewModel

    #if os(macOS)
    @Environment(\.openWindow) private var openWindow
    #endif

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            VStack(spacing: 12) {
                HStack {
                    Text("Lyrics")
                        .font(.headline)

                    Spacer()

                    Button {
                        openLyricEditor(existingLyricID: nil)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.green, .white.opacity(0.85))
                    }
                    .accessibilityLabel("Create new lyric")
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)

                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.lyrics) { lyric in
                            LyricCardView(
                                lyric: lyric,
                                isSelected: lyric.id == viewModel.selectedLyricID,
                                onEdit: {
                                    openLyricEditor(existingLyricID: lyric.id)
                                }
                            )
                            .onTapGesture {
                                viewModel.selectLyric(lyric)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                }
                .transparentScrollContent()
            }
        }
    }

    private func openLyricEditor(existingLyricID: UUID?) {
        #if os(macOS)
        let launch = LyricEditorLaunch(existingLyricID: existingLyricID)
        openWindow(id: "lyric-editor", value: launch)
        #else
        if let existingLyricID,
           let lyric = viewModel.lyrics.first(where: { $0.id == existingLyricID }) {
            viewModel.presentLyricEditor(for: lyric)
        } else {
            viewModel.presentNewLyricEditor()
        }
        #endif
    }
}

private struct LyricCardView: View {
    let lyric: LyricDocument
    let isSelected: Bool
    let onEdit: () -> Void

    private let cornerRadius: CGFloat = 18

    private var footerShape: UnevenRoundedRectangle {
        UnevenRoundedRectangle(
            topLeadingRadius: 6,
            bottomLeadingRadius: cornerRadius,
            bottomTrailingRadius: cornerRadius,
            topTrailingRadius: 6,
            style: .continuous
        )
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(LyricGradient.linearGradient(for: lyric.colorSeed))

            VStack {
                HStack {
                    Spacer()
                    Button(action: onEdit) {
                        Image(systemName: "pencil.circle.fill")
                            .font(.title3)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .black.opacity(0.35))
                            .shadow(color: .black.opacity(0.25), radius: 2, y: 1)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Edit lyric")
                    .padding(8)
                }

                Spacer()

                Image(systemName: "music.note")
                    .font(.title2)
                    .foregroundStyle(.white.opacity(0.22))
                    .padding(.bottom, 8)

                Spacer()
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(lyric.title.uppercased())
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)

                Text(lyric.previewSnippet)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.88))
                    .lineLimit(1)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .glassEffect(.regular, in: footerShape)
        }
        .frame(height: 132)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(.white.opacity(0.9), lineWidth: 2.5)
            }
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
