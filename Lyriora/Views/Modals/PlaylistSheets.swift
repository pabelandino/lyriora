//
//  PlaylistSheets.swift
//  Lyriora
//

import SwiftUI

struct PlaylistPickerSheet: View {
    @Bindable var viewModel: AppViewModel
    let kind: LibraryPlaylistKind

    @Environment(\.dismiss) private var dismiss

    @State private var searchText = ""
    @State private var newPlaylistName = ""
    @State private var isCreateFieldVisible = false

    private var filteredPlaylists: [LibraryPlaylist] {
        let playlists = viewModel.playlists(for: kind)
        guard !LibrarySearch.normalize(searchText).isEmpty else { return playlists }
        return playlists.filter { $0.matchesSearch(searchText) }
    }

    private var isSearching: Bool {
        !LibrarySearch.normalize(searchText).isEmpty
    }

    var body: some View {
        PlaylistModalShell {
            VStack(spacing: 16) {
                PlaylistModalHeader(
                    title: "\(kind.title) Playlists",
                    subtitle: "Organize your library",
                    systemImage: kind.systemImage,
                    onClose: { dismiss() },
                    primaryAction: { withAnimation(GlassMorphAnimation.standard) { isCreateFieldVisible.toggle() } }
                )

                PlaylistGlassSearchField(text: $searchText, placeholder: "Search playlists")

                if isCreateFieldVisible {
                    createPlaylistCard
                        .transition(.move(edge: .top).combined(with: .opacity))
                }

                ScrollView {
                    LazyVStack(spacing: PlaylistModalMetrics.rowSpacing) {
                        PlaylistGlassSectionLabel(title: "Library", count: totalItemCount)

                        PlaylistGlassRowButton(
                            title: "All \(kind.title.lowercased())",
                            subtitle: "Show everything in your library",
                            trailingText: "\(totalItemCount)",
                            isSelected: viewModel.selectedPlaylistID(for: kind) == nil
                        ) {
                            viewModel.clearPlaylistSelection(for: kind)
                            dismiss()
                        }

                        PlaylistGlassSectionLabel(
                            title: "Playlists",
                            count: filteredPlaylists.count
                        )
                        .padding(.top, 4)

                        if filteredPlaylists.isEmpty {
                            PlaylistGlassEmptyState(
                                title: isSearching ? "No matches" : "No playlists yet",
                                systemImage: "music.note.list",
                                message: isSearching
                                    ? "Try a different search term."
                                    : "Create one to group your \(kind.title.lowercased())."
                            )
                        } else {
                            ForEach(filteredPlaylists) { playlist in
                                PlaylistGlassRowButton(
                                    title: playlist.name,
                                    subtitle: "Updated \(playlist.updatedAt.formatted(date: .abbreviated, time: .omitted))",
                                    trailingText: "\(playlist.itemIDs.count)",
                                    isSelected: viewModel.selectedPlaylistID(for: kind) == playlist.id
                                ) {
                                    viewModel.selectPlaylist(playlist)
                                    dismiss()
                                }
                                .contextMenu {
                                    Button {
                                        openEditor(for: playlist)
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }

                                    Button(role: .destructive) {
                                        viewModel.deletePlaylist(playlist)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                #if os(iOS)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        viewModel.deletePlaylist(playlist)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }

                                    Button {
                                        openEditor(for: playlist)
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    .tint(.blue)
                                }
                                #endif
                            }
                        }
                    }
                    .padding(.bottom, 4)
                }
                .transparentScrollContent()
            }
        }
        #if os(iOS)
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        #endif
        .presentationBackground {
            Color.clear
        }
        #if os(macOS)
        .frame(minWidth: 460, minHeight: 560)
        #endif
    }

    private var createPlaylistCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("New playlist")
                .font(.caption.weight(.bold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            HStack(spacing: 10) {
                TextField("Name", text: $newPlaylistName)
                    .textFieldStyle(.plain)
                    .font(.subheadline.weight(.semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .glassEffect(.regular.interactive(), in: .capsule)
                    .glassControlBorder(Capsule())
                    .onSubmit(createPlaylist)

                Button("Create") { createPlaylist() }
                    .font(.subheadline.weight(.bold))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .glassEffect(.regular.interactive(), in: .capsule)
                    .glassControlBorder(Capsule())
                    .disabled(newPlaylistName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.clear)
                .glassEffect(.regular, in: .rect(cornerRadius: 18, style: .continuous))
                .glassControlBorder(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
    }

    private var totalItemCount: Int {
        switch kind {
        case .lyric: viewModel.lyrics.count
        case .image: viewModel.imageAssets.count
        case .video: viewModel.videoAssets.count
        }
    }

    private func createPlaylist() {
        guard let playlist = viewModel.createPlaylist(name: newPlaylistName, kind: kind) else { return }
        newPlaylistName = ""
        isCreateFieldVisible = false
        openEditor(for: playlist)
        dismiss()
    }

    private func openEditor(for playlist: LibraryPlaylist) {
        viewModel.playlistEditorTargetID = playlist.id
        viewModel.playlistPickerKind = kind
        viewModel.isPlaylistEditorPresented = true
    }
}

struct PlaylistEditorSheet: View {
    @Bindable var viewModel: AppViewModel
    let kind: LibraryPlaylistKind
    let playlistID: UUID?

    @Environment(\.dismiss) private var dismiss

    @State private var playlistName = ""
    @State private var workingItemIDs: [UUID] = []
    @State private var availableSearchText = ""
    @State private var selectedAvailableIDs: Set<UUID> = []

    private var resolvedPlaylist: LibraryPlaylist? {
        if let playlistID {
            return viewModel.playlists.first { $0.id == playlistID }
        }
        return nil
    }

    private var availableItems: [UUID] {
        allItemIDs.filter { !workingItemIDs.contains($0) }
    }

    private var filteredAvailableItems: [UUID] {
        guard !LibrarySearch.normalize(availableSearchText).isEmpty else {
            return availableItems
        }

        return availableItems.filter { itemID in
            viewModel.playlistItemMatchesSearch(itemID, kind: kind, query: availableSearchText)
        }
    }

    private var availableSearchPlaceholder: String {
        switch kind {
        case .lyric: "Search title or lyrics"
        case .image: "Search images"
        case .video: "Search videos"
        }
    }

    private var showsMediaPreview: Bool {
        kind == .image || kind == .video
    }

    private var allItemIDs: [UUID] {
        switch kind {
        case .lyric: viewModel.lyrics.map(\.id)
        case .image: viewModel.imageAssets.map(\.id)
        case .video: viewModel.videoAssets.map(\.id)
        }
    }

    var body: some View {
        PlaylistModalShell {
            VStack(spacing: 16) {
                PlaylistModalHeader(
                    title: resolvedPlaylist == nil ? "New Playlist" : "Edit Playlist",
                    subtitle: kind.title,
                    systemImage: kind.systemImage,
                    onClose: { dismiss() }
                )

                PlaylistGlassNameField(name: $playlistName)

                Text("Drag items into the playlist, or select multiple and tap Add.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 14) {
                    PlaylistGlassColumn(
                        title: "Library",
                        badge: selectedAvailableIDs.isEmpty ? nil : "+\(selectedAvailableIDs.count)"
                    ) {
                        VStack(spacing: 10) {
                            HStack {
                                Spacer()
                                if !selectedAvailableIDs.isEmpty {
                                    Button("Add selected") { addSelectedItems() }
                                        .font(.caption.weight(.bold))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .glassEffect(.regular.interactive(), in: .capsule)
                                }
                            }

                            PlaylistGlassSearchField(
                                text: $availableSearchText,
                                placeholder: availableSearchPlaceholder
                            )

                            ScrollView {
                                LazyVStack(spacing: PlaylistModalMetrics.rowSpacing) {
                                    ForEach(filteredAvailableItems, id: \.self) { itemID in
                                        availableRow(for: itemID)
                                    }
                                }
                                .padding(.bottom, 4)
                            }
                            .transparentScrollContent()
                        }
                    }

                    PlaylistGlassColumn(
                        title: "In playlist",
                        badge: "\(workingItemIDs.count)"
                    ) {
                        ScrollView {
                            LazyVStack(spacing: PlaylistModalMetrics.rowSpacing) {
                                if workingItemIDs.isEmpty {
                                    PlaylistGlassEmptyState(
                                        title: "Empty playlist",
                                        systemImage: "tray",
                                        message: "Drop items here from the library."
                                    )
                                } else {
                                    ForEach(workingItemIDs, id: \.self) { itemID in
                                        playlistRow(for: itemID)
                                    }
                                }
                            }
                            .padding(.bottom, 4)
                        }
                        .transparentScrollContent()
                        .dropDestination(for: String.self) { items, _ in
                            guard let rawID = items.first, let itemID = UUID(uuidString: rawID) else { return false }
                            addItem(itemID)
                            return true
                        }
                    }
                }
                .frame(maxHeight: .infinity)

                PlaylistModalActionBar(
                    cancelTitle: "Cancel",
                    confirmTitle: "Save Playlist",
                    isConfirmDisabled: playlistName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                    onCancel: { dismiss() },
                    onConfirm: savePlaylist
                )
            }
        }
        .onAppear(perform: loadInitialState)
        #if os(iOS)
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        #endif
        .presentationBackground {
            Color.clear
        }
        #if os(macOS)
        .frame(minWidth: 860, minHeight: 620)
        #endif
    }

    @ViewBuilder
    private func availableRow(for itemID: UUID) -> some View {
        let isSelected = selectedAvailableIDs.contains(itemID)

        HStack(spacing: 10) {
            if showsMediaPreview, let fileURL = viewModel.mediaFileURL(for: itemID, kind: kind) {
                PlaylistMediaPreview(url: fileURL, kind: kind == .image ? .image : .video)
            } else if kind == .lyric,
                      let lyric = viewModel.lyrics.first(where: { $0.id == itemID }) {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(LyricGradient.linearGradient(for: lyric.colorSeed))
                    .frame(width: 8, height: 44)
            }

            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(isSelected ? .green : .secondary)
                .font(.title3)

            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.playlistItemLabel(for: itemID, kind: kind))
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(showsMediaPreview ? 1 : 2)

                if kind == .lyric, !availableSearchText.isEmpty,
                   let lyric = viewModel.lyrics.first(where: { $0.id == itemID }),
                   let snippet = lyric.searchMatchSnippet(matching: availableSearchText) {
                    Text(snippet)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.tertiary)
        }
        .playlistItemGlassRow(isHighlighted: isSelected)
        .contentShape(RoundedRectangle(cornerRadius: PlaylistModalMetrics.rowCornerRadius, style: .continuous))
        .onTapGesture { toggleSelection(for: itemID) }
        .draggable(itemID.uuidString)
    }

    @ViewBuilder
    private func playlistRow(for itemID: UUID) -> some View {
        HStack(spacing: 10) {
            if showsMediaPreview, let fileURL = viewModel.mediaFileURL(for: itemID, kind: kind) {
                PlaylistMediaPreview(url: fileURL, kind: kind == .image ? .image : .video)
            } else if kind == .lyric,
                      let lyric = viewModel.lyrics.first(where: { $0.id == itemID }) {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(LyricGradient.linearGradient(for: lyric.colorSeed))
                    .frame(width: 8, height: 44)
            }

            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.tertiary)

            Text(viewModel.playlistItemLabel(for: itemID, kind: kind))
                .font(.subheadline.weight(.semibold))
                .lineLimit(showsMediaPreview ? 1 : 2)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button { removeItem(itemID) } label: {
                GlassCircleIcon(systemName: "minus", diameter: 32, symbolSize: 13)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Remove from playlist")
        }
        .playlistItemGlassRow(isHighlighted: true)
        .draggable(itemID.uuidString)
        .dropDestination(for: String.self) { items, _ in
            guard let rawID = items.first, let droppedID = UUID(uuidString: rawID) else { return false }
            reorderDrop(moving: droppedID, onto: itemID)
            return true
        }
    }

    private func loadInitialState() {
        if let resolvedPlaylist {
            playlistName = resolvedPlaylist.name
            workingItemIDs = resolvedPlaylist.itemIDs
        } else {
            playlistName = ""
            workingItemIDs = []
        }
    }

    private func toggleSelection(for itemID: UUID) {
        withAnimation(GlassMorphAnimation.standard) {
            if selectedAvailableIDs.contains(itemID) {
                selectedAvailableIDs.remove(itemID)
            } else {
                selectedAvailableIDs.insert(itemID)
            }
        }
    }

    private func addSelectedItems() {
        for itemID in selectedAvailableIDs {
            addItem(itemID)
        }
        selectedAvailableIDs.removeAll()
    }

    private func addItem(_ itemID: UUID) {
        guard allItemIDs.contains(itemID), !workingItemIDs.contains(itemID) else { return }
        withAnimation(GlassMorphAnimation.standard) {
            workingItemIDs.append(itemID)
        }
    }

    private func removeItem(_ itemID: UUID) {
        withAnimation(GlassMorphAnimation.standard) {
            workingItemIDs.removeAll { $0 == itemID }
        }
    }

    private func reorderDrop(moving sourceID: UUID, onto targetID: UUID) {
        guard sourceID != targetID else { return }

        if !workingItemIDs.contains(sourceID) {
            addItem(sourceID)
        }

        guard let sourceIndex = workingItemIDs.firstIndex(of: sourceID) else { return }

        var items = workingItemIDs
        items.remove(at: sourceIndex)

        if let targetIndex = items.firstIndex(of: targetID) {
            items.insert(sourceID, at: targetIndex)
        } else {
            items.append(sourceID)
        }

        withAnimation(GlassMorphAnimation.standard) {
            workingItemIDs = items
        }
    }

    private func savePlaylist() {
        viewModel.savePlaylist(
            id: playlistID,
            name: playlistName,
            kind: kind,
            itemIDs: workingItemIDs
        )
        dismiss()
    }
}

private struct PlaylistMediaPreview: View {
    let url: URL
    let kind: MediaAssetKind

    private let size: CGFloat = 52

    var body: some View {
        Group {
            switch kind {
            case .image:
                PlaylistImagePreview(url: url)
            case .video:
                PlaylistVideoPreview(url: url)
            }
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(.white.opacity(0.22), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.18), radius: 4, y: 2)
    }
}

private struct PlaylistImagePreview: View {
    let url: URL
    @State private var image: Image?

    var body: some View {
        Group {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Color.black.opacity(0.2)
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.secondary)
                    }
            }
        }
        .task(id: url) {
            if let loaded = LocalFileImageBackground.loadImage(from: url) {
                image = loaded
            }
        }
    }
}

private struct PlaylistVideoPreview: View {
    let url: URL
    @State private var image: Image?

    var body: some View {
        ZStack {
            Group {
                if let image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.black.opacity(0.35)
                }
            }

            Image(systemName: "play.fill")
                .font(.caption2.weight(.bold))
                .foregroundStyle(.white.opacity(0.95))
                .padding(7)
                .background(.black.opacity(0.38), in: Circle())
        }
        .task(id: url) {
            let metadata = await VideoAssetMetadataLoader.load(from: url)
            image = metadata.thumbnail
        }
    }
}
