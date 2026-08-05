//
//  LyricsLibraryPanelView.swift
//  Lyriora
//

import SwiftUI

struct LyricsLibraryPanelView: View {
    @Bindable var viewModel: AppViewModel

    @State private var lyricPendingDeletion: LyricDocument?

    #if os(macOS)
    @Environment(\.openWindow) private var openWindow
    #endif

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            VStack(spacing: 12) {
                HStack(spacing: 8) {
                    Label("Lyrics", systemImage: "append.page")
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Spacer()

                    Button {
                        openLyricEditor(existingLyricID: nil)
                    } label: {
                        GlassCircleIcon(systemName: "plus")
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Create new lyric")
                }
                .padding(.leading, Layout.contentHorizontalInset)
                .padding(.trailing, Layout.trailingControlInset)
                .padding(.top, 12)

                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.lyrics) { lyric in
                            LyricCardView(
                                lyric: lyric,
                                isSelected: lyric.id == viewModel.selectedLyricID,
                                onEdit: {
                                    openLyricEditor(existingLyricID: lyric.id)
                                },
                                onDelete: {
                                    lyricPendingDeletion = lyric
                                }
                            )
                            .onTapGesture {
                                viewModel.selectLyric(lyric)
                            }
                        }
                    }
                    .padding(.horizontal, Layout.contentHorizontalInset)
                }
                .transparentScrollContent()
            }
        }
        .alert(
            "Delete Lyric Permanently?",
            isPresented: deleteAlertBinding,
            presenting: lyricPendingDeletion
        ) { lyric in
            Button("Delete Permanently", role: .destructive) {
                viewModel.deleteLyric(lyric)
                lyricPendingDeletion = nil
            }
            Button("Cancel", role: .cancel) {
                lyricPendingDeletion = nil
            }
        } message: { lyric in
            Text("\"\(lyric.title)\" will be permanently deleted. This action cannot be undone.")
        }
    }

    private var deleteAlertBinding: Binding<Bool> {
        Binding(
            get: { lyricPendingDeletion != nil },
            set: { if !$0 { lyricPendingDeletion = nil } }
        )
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

private enum Layout {
    static let contentHorizontalInset: CGFloat = 8
    static let cardMenuInset: CGFloat = 8
    static var trailingControlInset: CGFloat {
        contentHorizontalInset + cardMenuInset
    }
}

private struct LyricCardView: View {
    let lyric: LyricDocument
    let isSelected: Bool
    let onEdit: () -> Void
    let onDelete: () -> Void

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

            VStack(alignment: .leading, spacing: 2) {
                Text(lyric.title.uppercased())
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)

                Text(lyric.previewSnippet)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.88))
                    .lineLimit(1)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity, alignment: .leading)
            .glassEffect(.regular, in: footerShape)
        }
        .frame(height: 98)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay(alignment: .topTrailing) {
            GlassOverflowMenu(
                actions: [
                    .init(
                        title: "Edit",
                        systemImage: "pencil",
                        handler: onEdit
                    ),
                    .init(
                        title: "Delete",
                        systemImage: "trash",
                        role: .destructive,
                        handler: onDelete
                    )
                ],
                iconSize: 36
            )
            .padding(Layout.cardMenuInset)
        }
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(.white.opacity(0.9), lineWidth: 2.5)
            }
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
