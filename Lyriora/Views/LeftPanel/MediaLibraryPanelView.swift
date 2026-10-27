//
//  MediaLibraryPanelView.swift
//  Lyriora
//

import PhotosUI
import SwiftUI
import UniformTypeIdentifiers

#if canImport(UIKit)
import UIKit
#elseif os(macOS)
import AppKit
#endif

struct MediaLibraryPanelView: View {
    @Bindable var viewModel: AppViewModel
    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout

    var body: some View {
        VStack(spacing: workspaceCompactLayout ? 8 : 16) {
            ImageLibrarySection(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VideoLibrarySection(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

private struct ImageLibrarySection: View {
    @Bindable var viewModel: AppViewModel
    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout
    @State private var assetPendingRename: MediaAsset?
    @State private var renameDraft = ""
    @State private var searchText = ""

    private var filteredAssets: [MediaAsset] {
        viewModel.filteredMediaAssets(
            kind: .image,
            searchText: searchText,
            playlistID: viewModel.selectedImagePlaylistID
        )
    }

    private var isPlaylistFiltered: Bool {
        viewModel.selectedImagePlaylistID != nil
    }

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            VStack(spacing: workspaceCompactLayout ? 6 : 8) {
                LibraryMorphSearchHeader(
                    title: "Images",
                    systemImage: "photo.on.rectangle.angled",
                    searchText: $searchText,
                    placeholder: "Search images"
                ) {
                    MediaImportToolbarButton(
                        title: "Images",
                        kind: .image,
                        viewModel: viewModel
                    )
                }
                .padding(.top, workspaceCompactLayout ? 8 : 10)

                PlaylistFilterBar(kind: .image, viewModel: viewModel)
                    .padding(.horizontal, 12)

                ScrollView {
                    LazyVStack(spacing: 10) {
                        if filteredAssets.isEmpty, !LibrarySearch.normalize(searchText).isEmpty || isPlaylistFiltered {
                            if !LibrarySearch.normalize(searchText).isEmpty {
                                LibrarySearchEmptyState(query: searchText)
                            } else {
                                Text("This playlist is empty")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 24)
                            }
                        } else {
                            ForEach(filteredAssets) { asset in
                                MediaThumbnailView(
                                    asset: asset,
                                    fileURL: viewModel.imageURL(for: asset),
                                    isSelected: viewModel.isBackgroundSelected(asset),
                                    onSelect: { viewModel.selectBackgroundMedia(withID: asset.id) },
                                    onRename: {
                                        renameDraft = asset.listLabel
                                        assetPendingRename = asset
                                    },
                                    onRemove: { viewModel.deleteMediaAsset(asset) },
                                    addToPlaylistActions: playlistActions(for: asset.id, kind: .image)
                                )
                                .id(asset.id)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                }
                .clippedPanelScrollContent()
            }
            .padding(.bottom, 4)
        }
        .renameMediaAlert(
            asset: $assetPendingRename,
            draft: $renameDraft,
            onSave: { asset, name in
                viewModel.renameMediaAsset(asset, to: name)
            }
        )
    }

    private func playlistActions(for assetID: UUID, kind: LibraryPlaylistKind) -> [GlassOverflowMenu.Action] {
        MediaLibraryPlaylistActions.make(for: assetID, kind: kind, viewModel: viewModel)
    }
}

private struct VideoLibrarySection: View {
    @Bindable var viewModel: AppViewModel
    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout
    @State private var assetPendingRename: MediaAsset?
    @State private var renameDraft = ""
    @State private var searchText = ""
    @State private var isYouTubeLinkAlertPresented = false
    @State private var youtubeLinkDraft = ""

    private var filteredAssets: [MediaAsset] {
        viewModel.filteredMediaAssets(
            kind: .video,
            searchText: searchText,
            playlistID: viewModel.selectedVideoPlaylistID
        )
    }

    private var isPlaylistFiltered: Bool {
        viewModel.selectedVideoPlaylistID != nil
    }

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            VStack(spacing: workspaceCompactLayout ? 6 : 8) {
                LibraryMorphSearchHeader(
                    title: "Videos",
                    systemImage: "film.stack",
                    searchText: $searchText,
                    placeholder: "Search videos"
                ) {
                    HStack(spacing: 8) {
                        YouTubeLinkToolbarButton(
                            onPaste: {
                                youtubeLinkDraft = ClipboardLinkReader.string ?? ""
                                isYouTubeLinkAlertPresented = true
                            }
                        )
                        MediaImportToolbarButton(
                            title: "Videos",
                            kind: .video,
                            viewModel: viewModel
                        )
                    }
                }
                .padding(.top, workspaceCompactLayout ? 8 : 10)

                PlaylistFilterBar(kind: .video, viewModel: viewModel)
                    .padding(.horizontal, 12)

                ScrollView {
                    LazyVStack(spacing: 10) {
                        if filteredAssets.isEmpty, !LibrarySearch.normalize(searchText).isEmpty || isPlaylistFiltered {
                            if !LibrarySearch.normalize(searchText).isEmpty {
                                LibrarySearchEmptyState(query: searchText)
                            } else {
                                Text("This playlist is empty")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 24)
                            }
                        } else {
                            ForEach(filteredAssets) { asset in
                                videoThumbnail(for: asset)
                                    .id(asset.fileName)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                }
                .clippedPanelScrollContent()
            }
            .padding(.bottom, 4)
        }
        .renameMediaAlert(
            asset: $assetPendingRename,
            draft: $renameDraft,
            onSave: { asset, name in
                viewModel.renameMediaAsset(asset, to: name)
            }
        )
        .sheet(isPresented: $isYouTubeLinkAlertPresented) {
            YouTubeLinkEntrySheet(
                linkDraft: $youtubeLinkDraft,
                onAdd: {
                    viewModel.addYouTubeBackground(from: youtubeLinkDraft)
                    youtubeLinkDraft = ""
                    isYouTubeLinkAlertPresented = false
                },
                onCancel: {
                    youtubeLinkDraft = ""
                    isYouTubeLinkAlertPresented = false
                }
            )
        }
    }

    private func playlistActions(for assetID: UUID, kind: LibraryPlaylistKind) -> [GlassOverflowMenu.Action] {
        MediaLibraryPlaylistActions.make(for: assetID, kind: kind, viewModel: viewModel)
    }

    private func videoThumbnail(for asset: MediaAsset) -> some View {
        MediaThumbnailView(
            asset: asset,
            fileURL: viewModel.videoURL(for: asset),
            isSelected: viewModel.isBackgroundSelected(asset),
            showsDuration: true,
            durationLabel: viewModel.videoDurationLabel(for: asset),
            onEnsureDuration: durationLoader(for: asset),
            onSelect: { viewModel.selectBackgroundMedia(withID: asset.id) },
            onRename: {
                renameDraft = asset.listLabel
                assetPendingRename = asset
            },
            onRemove: { viewModel.deleteMediaAsset(asset) },
            addToPlaylistActions: playlistActions(for: asset.id, kind: .video)
        )
    }

    private func durationLoader(for asset: MediaAsset) -> (() async -> Void)? {
        { await viewModel.ensureVideoDuration(for: asset) }
    }
}

private enum MediaLibraryPlaylistActions {
    static func make(
        for assetID: UUID,
        kind: LibraryPlaylistKind,
        viewModel: AppViewModel
    ) -> [GlassOverflowMenu.Action] {
        let playlists = viewModel.playlists(for: kind)
        guard !playlists.isEmpty else { return [] }

        return playlists.map { playlist in
            GlassOverflowMenu.Action(
                title: playlist.name,
                systemImage: playlist.itemIDs.contains(assetID) ? "checkmark" : "music.note.list",
                handler: {
                    if playlist.itemIDs.contains(assetID) {
                        viewModel.removeItem(from: playlist.id, itemID: assetID)
                    } else {
                        viewModel.addItems(to: playlist.id, itemIDs: [assetID])
                    }
                }
            )
        }
    }
}

private struct YouTubeLinkToolbarButton: View {
    let onPaste: () -> Void

    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout

    var body: some View {
        Button(action: onPaste) {
            GlassCircleIcon(
                systemName: "link",
                diameter: LibraryPanelMetrics.actionDiameter(compact: workspaceCompactLayout),
                symbolSize: LibraryPanelMetrics.actionSymbolSize(compact: workspaceCompactLayout)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Add YouTube link")
    }
}

private enum ClipboardLinkReader {
    static var string: String? {
        #if canImport(UIKit)
        UIPasteboard.general.string
        #elseif os(macOS)
        NSPasteboard.general.string(forType: .string)
        #else
        nil
        #endif
    }
}

private struct YouTubeLinkEntrySheet: View {
    @Binding var linkDraft: String
    let onAdd: () -> Void
    let onCancel: () -> Void

    @FocusState private var isFieldFocused: Bool

    private let placeholder = "https://youtube.com/watch?v=…"

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Paste a YouTube URL to use it as a background video.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                TextField("", text: $linkDraft, prompt: Text(placeholder))
                    #if os(iOS)
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.roundedBorder)
                    #elseif os(macOS)
                    .textFieldStyle(.roundedBorder)
                    #endif
                    .autocorrectionDisabled()
                    #if os(iOS)
                    .keyboardType(.URL)
                    #endif
                    .focused($isFieldFocused)

                Spacer(minLength: 0)
            }
            .padding(20)
            .frame(minWidth: 360, minHeight: 140)
            .navigationTitle("YouTube Link")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: onAdd)
                        .disabled(YouTubeLinkParser.videoID(from: linkDraft) == nil)
                }
            }
            .onAppear {
                isFieldFocused = true
            }
        }
        #if os(iOS)
        .presentationDetents([.medium])
        #endif
    }
}

private struct MediaImportToolbarButton: View {
    let title: String
    let kind: MediaAssetKind
    @Bindable var viewModel: AppViewModel

    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout
    @State private var isSourceDialogPresented = false
    @State private var isPhotoPickerPresented = false
    @State private var isFileImporterPresented = false

    var body: some View {
        Button {
            isSourceDialogPresented = true
        } label: {
            GlassCircleIcon(
                systemName: "plus",
                diameter: LibraryPanelMetrics.actionDiameter(compact: workspaceCompactLayout),
                symbolSize: LibraryPanelMetrics.actionSymbolSize(compact: workspaceCompactLayout)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Add \(title.lowercased())")
        .confirmationDialog(
            "Add \(title)",
            isPresented: $isSourceDialogPresented,
            titleVisibility: .visible
        ) {
            Button("Photo Library") {
                isPhotoPickerPresented = true
            }

            Button("Files") {
                isFileImporterPresented = true
            }

            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Choose where to import \(title.lowercased()) from.")
        }
        .photosPicker(
            isPresented: $isPhotoPickerPresented,
            selection: photoPickerSelection,
            maxSelectionCount: 10,
            matching: kind == .image ? .images : .videos
        )
        .fileImporter(
            isPresented: $isFileImporterPresented,
            allowedContentTypes: kind == .image ? MediaImportContentTypes.images : MediaImportContentTypes.videos,
            allowsMultipleSelection: true
        ) { result in
            switch result {
            case .success(let urls):
                Task {
                    switch kind {
                    case .image:
                        await viewModel.importImageFiles(from: urls)
                    case .video:
                        await viewModel.importVideoFiles(from: urls)
                    }
                }
            case .failure:
                break
            }
        }
    }

    private var photoPickerSelection: Binding<[PhotosPickerItem]> {
        switch kind {
        case .image:
            $viewModel.selectedPhotoItems
        case .video:
            $viewModel.selectedVideoItems
        }
    }
}

private enum MediaImportContentTypes {
    static let images: [UTType] = [.image]
    static let videos: [UTType] = [.movie, .video, .mpeg4Movie, .quickTimeMovie, .avi]
}

private struct MediaThumbnailView: View {
    let asset: MediaAsset
    let fileURL: URL
    var isSelected: Bool = false
    var showsDuration: Bool = false
    var durationLabel: String? = nil
    var onEnsureDuration: (() async -> Void)? = nil
    let onSelect: () -> Void
    let onRename: () -> Void
    let onRemove: () -> Void
    var addToPlaylistActions: [GlassOverflowMenu.Action] = []

    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout
    @State private var displayedDurationLabel: String?

    private let cornerRadius: CGFloat = 14

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    private var resolvedDurationLabel: String {
        displayedDurationLabel ?? durationLabel ?? "--:--"
    }

    private var menuIconSize: CGFloat {
        workspaceCompactLayout ? 32 : 36
    }

    var body: some View {
        VStack(alignment: .leading, spacing: workspaceCompactLayout ? 4 : 6) {
            Button(action: onSelect) {
                thumbnailContent
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: workspaceCompactLayout ? 72 : 88)
                    .clipShape(shape)
                    .overlay {
                        if isSelected {
                            shape.strokeBorder(.white.opacity(0.9), lineWidth: 2.5)
                        }
                    }
                    .contentShape(shape)
            }
            .buttonStyle(.plain)
            .overlay(alignment: .bottomLeading) {
                if showsDuration {
                    Text(resolvedDurationLabel)
                        .font(.caption2.weight(.semibold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .glassEffect(.regular, in: .capsule)
                        .padding(8)
                        .allowsHitTesting(false)
                }
            }
            .overlay(alignment: .topTrailing) {
                GlassOverflowMenu(
                    actions: overflowActions,
                    iconSize: menuIconSize
                )
                .padding(6)
                .accessibilityLabel("Media options")
            }
            .accessibilityLabel(asset.listLabel)
            .accessibilityAddTraits(isSelected ? .isSelected : [])

            Button(action: onRename) {
                Text(asset.listLabel)
                    .font(workspaceCompactLayout ? .caption2.weight(.medium) : .caption.weight(.medium))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 2)
            }
            .buttonStyle(.plain)
            .accessibilityHint("Rename media")
        }
        .onAppear {
            if let durationLabel {
                displayedDurationLabel = durationLabel
            }
        }
        .onChange(of: durationLabel) { _, newValue in
            if let newValue {
                displayedDurationLabel = newValue
            }
        }
        .task(id: asset.fileName) {
            guard showsDuration else { return }
            await onEnsureDuration?()
        }
    }

    private var overflowActions: [GlassOverflowMenu.Action] {
        var actions: [GlassOverflowMenu.Action] = [
            .init(title: "Rename", systemImage: "pencil", handler: onRename)
        ]

        if !addToPlaylistActions.isEmpty {
            actions.append(contentsOf: addToPlaylistActions)
        }

        actions.append(
            .init(title: "Delete", systemImage: "trash", role: .destructive, handler: onRemove)
        )
        return actions
    }

    @ViewBuilder
    private var thumbnailContent: some View {
        if asset.kind == .image {
            LocalFileThumbnailImage(url: fileURL)
        } else if asset.isYouTubeLink,
                  let sourceURL = YouTubeLinkParser.normalizedURL(from: youtubeLinkString),
                  let videoID = YouTubeLinkParser.videoID(from: sourceURL) {
            YouTubeThumbnailView(videoID: videoID)
        } else {
            LocalFileVideoThumbnail(url: fileURL)
        }
    }

    private var youtubeLinkString: String {
        (try? String(contentsOf: fileURL, encoding: .utf8)) ?? ""
    }
}

private extension View {
    func renameMediaAlert(
        asset: Binding<MediaAsset?>,
        draft: Binding<String>,
        onSave: @escaping (MediaAsset, String) -> Void
    ) -> some View {
        alert("Rename", isPresented: Binding(
            get: { asset.wrappedValue != nil },
            set: { isPresented in
                if !isPresented {
                    asset.wrappedValue = nil
                }
            }
        )) {
            TextField("Name", text: draft)

            Button("Save") {
                guard let pendingAsset = asset.wrappedValue else { return }
                onSave(pendingAsset, draft.wrappedValue)
                asset.wrappedValue = nil
            }

            Button("Cancel", role: .cancel) {
                asset.wrappedValue = nil
            }
        } message: {
            Text("Enter a new name for this item.")
        }
    }
}

private struct LocalFileVideoThumbnail: View {
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

            GlassCircleIcon(systemName: "play.fill", diameter: 42, symbolSize: 16)
        }
        .task(id: url) {
            if let cached = LocalImageCache.entry(for: url) {
                image = cached.image
                return
            }

            let metadata = await VideoAssetMetadataLoader.load(from: url)
            if let thumbnail = metadata.thumbnail {
                LocalImageCache.store(image: thumbnail, size: .zero, for: url)
                image = thumbnail
            }
        }
    }
}

private struct LocalFileThumbnailImage: View {
    let url: URL
    @State private var image: Image?

    var body: some View {
        Group {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "photo")
                    .font(.title2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task(id: url) {
            if let cached = LocalImageCache.entry(for: url) {
                image = cached.image
                return
            }

            if let loadedImage = LocalFileImageBackground.loadImage(from: url) {
                let size = LocalFileImageBackground.loadImageSize(from: url) ?? .zero
                LocalImageCache.store(image: loadedImage, size: size, for: url)
                image = loadedImage
            }
        }
    }
}
