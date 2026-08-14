//
//  PlaylistFilterBar.swift
//  Lyriora
//

import SwiftUI

struct PlaylistFilterBar: View {
    let kind: LibraryPlaylistKind
    @Bindable var viewModel: AppViewModel

    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout

    private var selectedPlaylist: LibraryPlaylist? {
        viewModel.selectedPlaylist(for: kind)
    }

    var body: some View {
        HStack(spacing: 8) {
            Button {
                viewModel.presentPlaylistPicker(for: kind)
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "music.note.list")
                        .font(.caption.weight(.semibold))

                    Text(selectedPlaylist?.name ?? "All \(kind.title.lowercased())")
                        .font(workspaceCompactLayout ? .caption.weight(.semibold) : .subheadline.weight(.semibold))
                        .lineLimit(1)

                    Image(systemName: "chevron.down")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(.secondary)
                }
                .foregroundStyle(.primary)
                .padding(.horizontal, 12)
                .padding(.vertical, workspaceCompactLayout ? 6 : 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassEffect(.regular.interactive(), in: .capsule)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Select playlist")

            Button {
                if let selectedPlaylist {
                    viewModel.playlistEditorTargetID = selectedPlaylist.id
                    viewModel.playlistPickerKind = kind
                    viewModel.isPlaylistEditorPresented = true
                } else {
                    viewModel.playlistEditorTargetID = nil
                    viewModel.playlistPickerKind = kind
                    viewModel.isPlaylistEditorPresented = true
                }
            } label: {
                GlassCircleIcon(
                    systemName: "slider.horizontal.3",
                    diameter: workspaceCompactLayout ? 32 : 36,
                    symbolSize: workspaceCompactLayout ? 13 : 15
                )
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Manage playlists")
        }
    }
}
