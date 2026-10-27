//
//  LyricsLibraryPanelView.swift
//  Lyriora
//

import SwiftUI

struct LyricsLibraryPanelView: View {
    @Bindable var viewModel: AppViewModel
    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout

    @State private var lyricPendingDeletion: LyricDocument?
    @State private var searchText = ""

    #if os(macOS)
    @Environment(\.openWindow) private var openWindow
    #endif

    private var filteredLyrics: [LyricDocument] {
        viewModel.filteredLyrics(
            searchText: searchText,
            playlistID: viewModel.selectedLyricPlaylistID
        )
    }

    private var isPlaylistFiltered: Bool {
        viewModel.selectedLyricPlaylistID != nil
    }

    private var isSearching: Bool {
        !LibrarySearch.normalize(searchText).isEmpty
    }

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            VStack(spacing: workspaceCompactLayout ? 6 : 8) {
                LibraryMorphSearchHeader(
                    title: "Lyrics",
                    systemImage: "append.page",
                    searchText: $searchText,
                    placeholder: "Search title or lyrics",
                    horizontalPadding: Layout.contentHorizontalInset
                ) {
                    Button {
                        openLyricEditor(existingLyricID: nil)
                    } label: {
                        GlassCircleIcon(
                            systemName: "plus",
                            diameter: LibraryPanelMetrics.actionDiameter(compact: workspaceCompactLayout),
                            symbolSize: LibraryPanelMetrics.actionSymbolSize(compact: workspaceCompactLayout)
                        )
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Create new lyric")
                }
                .padding(.top, workspaceCompactLayout ? 8 : 10)

                PlaylistFilterBar(kind: .lyric, viewModel: viewModel)
                    .padding(.horizontal, Layout.contentHorizontalInset)

                ScrollView {
                        LazyVStack(spacing: 10) {
                            if filteredLyrics.isEmpty, isSearching || isPlaylistFiltered {
                                if isSearching {
                                    LibrarySearchEmptyState(query: searchText)
                                } else {
                                    Text("This playlist is empty")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 24)
                                }
                            } else {
                                ForEach(filteredLyrics) { lyric in
                                    LyricCardView(
                                        lyric: lyric,
                                        isSelected: lyric.id == viewModel.selectedLyricID,
                                        subtitle: isSearching
                                            ? (lyric.searchMatchSnippet(matching: searchText) ?? lyric.previewSnippet)
                                            : lyric.previewSnippet,
                                        onEdit: {
                                            openLyricEditor(existingLyricID: lyric.id)
                                        },
                                        onDelete: {
                                            lyricPendingDeletion = lyric
                                        },
                                        addToPlaylistActions: playlistActions(for: lyric.id)
                                    )
                                    .onTapGesture {
                                        viewModel.selectLyric(lyric)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, Layout.contentHorizontalInset)
                        .padding(.bottom, 12)
                    }
                    .clippedPanelScrollContent()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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

    private func playlistActions(for lyricID: UUID) -> [GlassOverflowMenu.Action] {
        let playlists = viewModel.playlists(for: .lyric)
        guard !playlists.isEmpty else { return [] }

        return playlists.map { playlist in
            GlassOverflowMenu.Action(
                title: playlist.name,
                systemImage: playlist.itemIDs.contains(lyricID) ? "checkmark" : "music.note.list",
                handler: {
                    if playlist.itemIDs.contains(lyricID) {
                        viewModel.removeItem(from: playlist.id, itemID: lyricID)
                    } else {
                        viewModel.addItems(to: playlist.id, itemIDs: [lyricID])
                    }
                }
            )
        }
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
    var subtitle: String
    let onEdit: () -> Void
    let onDelete: () -> Void
    var addToPlaylistActions: [GlassOverflowMenu.Action] = []

    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout

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

                Text(subtitle)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.88))
                    .lineLimit(1)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity, alignment: .leading)
            .glassEffect(.regular, in: footerShape)
        }
        .frame(height: workspaceCompactLayout ? 82 : 98)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay(alignment: .topTrailing) {
            GlassOverflowMenu(
                actions: overflowActions,
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

    private var overflowActions: [GlassOverflowMenu.Action] {
        var actions: [GlassOverflowMenu.Action] = [
            .init(title: "Edit", systemImage: "pencil", handler: onEdit)
        ]

        if !addToPlaylistActions.isEmpty {
            actions.append(contentsOf: addToPlaylistActions)
        }

        actions.append(
            .init(title: "Delete", systemImage: "trash", role: .destructive, handler: onDelete)
        )
        return actions
    }
}
