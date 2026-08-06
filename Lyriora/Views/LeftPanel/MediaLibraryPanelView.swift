//
//  MediaLibraryPanelView.swift
//  Lyriora
//

import PhotosUI
import SwiftUI
import UniformTypeIdentifiers

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
        guard !LibrarySearch.normalize(searchText).isEmpty else {
            return viewModel.imageAssets
        }
        return viewModel.imageAssets.filter { $0.matchesSearch(searchText) }
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

                ScrollView {
                    LazyVStack(spacing: 10) {
                        if filteredAssets.isEmpty, !LibrarySearch.normalize(searchText).isEmpty {
                            LibrarySearchEmptyState(query: searchText)
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
                                    onRemove: { viewModel.deleteMediaAsset(asset) }
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
}

private struct VideoLibrarySection: View {
    @Bindable var viewModel: AppViewModel
    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout
    @State private var assetPendingRename: MediaAsset?
    @State private var renameDraft = ""
    @State private var searchText = ""

    private var filteredAssets: [MediaAsset] {
        guard !LibrarySearch.normalize(searchText).isEmpty else {
            return viewModel.videoAssets
        }
        return viewModel.videoAssets.filter { $0.matchesSearch(searchText) }
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
                    MediaImportToolbarButton(
                        title: "Videos",
                        kind: .video,
                        viewModel: viewModel
                    )
                }
                .padding(.top, workspaceCompactLayout ? 8 : 10)

                ScrollView {
                        LazyVStack(spacing: 10) {
                            if filteredAssets.isEmpty, !LibrarySearch.normalize(searchText).isEmpty {
                                LibrarySearchEmptyState(query: searchText)
                            } else {
                                ForEach(filteredAssets) { asset in
                                    MediaThumbnailView(
                                        asset: asset,
                                        fileURL: viewModel.videoURL(for: asset),
                                        isSelected: viewModel.isBackgroundSelected(asset),
                                        showsDuration: true,
                                        durationLabel: viewModel.videoDurationLabel(for: asset),
                                        onEnsureDuration: {
                                            await viewModel.ensureVideoDuration(for: asset)
                                        },
                                        onSelect: { viewModel.selectBackgroundMedia(withID: asset.id) },
                                        onRename: {
                                            renameDraft = asset.listLabel
                                            assetPendingRename = asset
                                        },
                                        onRemove: { viewModel.deleteMediaAsset(asset) }
                                    )
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
                    actions: [
                        .init(
                            title: "Rename",
                            systemImage: "pencil",
                            handler: onRename
                        ),
                        .init(
                            title: "Delete",
                            systemImage: "trash",
                            role: .destructive,
                            handler: onRemove
                        )
                    ],
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

    @ViewBuilder
    private var thumbnailContent: some View {
        if asset.kind == .image {
            LocalFileThumbnailImage(url: fileURL)
        } else {
            LocalFileVideoThumbnail(url: fileURL)
        }
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
            let metadata = await VideoAssetMetadataLoader.load(from: url)
            image = metadata.thumbnail
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
