//
//  MediaLibraryPanelView.swift
//  Lyriora
//

import PhotosUI
import SwiftUI

struct MediaLibraryPanelView: View {
    @Bindable var viewModel: AppViewModel

    var body: some View {
        VStack(spacing: 16) {
            ImageLibrarySection(viewModel: viewModel)
                .frame(maxHeight: .infinity)

            VideoLibrarySection(viewModel: viewModel)
                .frame(maxHeight: .infinity)
        }
        .frame(maxHeight: .infinity)
    }
}

private struct ImageLibrarySection: View {
    @Bindable var viewModel: AppViewModel

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            VStack(spacing: 12) {
                sectionHeader(
                    title: "Images",
                    systemName: "photo.on.rectangle.angled",
                    pickerSelection: $viewModel.selectedPhotoItems,
                    matching: .images,
                    accessibilityLabel: "Import images"
                )

                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.imageAssets) { asset in
                            MediaThumbnailView(
                                asset: asset,
                                fileURL: viewModel.imageURL(for: asset),
                                isSelected: viewModel.isBackgroundSelected(asset),
                                onSelect: { viewModel.selectBackgroundMedia(withID: asset.id) },
                                onRemove: { viewModel.deleteMediaAsset(asset) }
                            )
                            .id(asset.id)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                }
                .transparentScrollContent()
            }
            .padding(.top, 12)
        }
    }
}

private struct VideoLibrarySection: View {
    @Bindable var viewModel: AppViewModel

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            VStack(spacing: 12) {
                sectionHeader(
                    title: "Videos",
                    systemName: "film.stack",
                    pickerSelection: $viewModel.selectedVideoItems,
                    matching: .videos,
                    accessibilityLabel: "Import videos"
                )

                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.videoAssets) { asset in
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
                                onRemove: { viewModel.deleteMediaAsset(asset) }
                            )
                            .id(asset.fileName)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                }
                .transparentScrollContent()
            }
            .padding(.top, 12)
        }
    }
}

@ViewBuilder
private func sectionHeader(
    title: String,
    systemName: String,
    pickerSelection: Binding<[PhotosPickerItem]>,
    matching: PHPickerFilter,
    accessibilityLabel: String
) -> some View {
    HStack {
        Label(title, systemImage: systemName)
            .font(.headline)
            .foregroundStyle(.primary)

        Spacer()

        PhotosPicker(selection: pickerSelection, maxSelectionCount: 10, matching: matching) {
            GlassCircleIcon(systemName: "plus")
        }
        .buttonStyle(.plain)
        .accessibilityLabel(accessibilityLabel)
    }
    .padding(.horizontal, 16)
}

private struct MediaThumbnailView: View {
    let asset: MediaAsset
    let fileURL: URL
    var isSelected: Bool = false
    var showsDuration: Bool = false
    var durationLabel: String? = nil
    var onEnsureDuration: (() async -> Void)? = nil
    let onSelect: () -> Void
    let onRemove: () -> Void

    @State private var displayedDurationLabel: String?

    private let cornerRadius: CGFloat = 14

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    private var resolvedDurationLabel: String {
        displayedDurationLabel ?? durationLabel ?? "--:--"
    }

    var body: some View {
        Button(action: onSelect) {
            thumbnailContent
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .frame(height: 88)
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
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.body)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .black.opacity(0.55))
                    .shadow(color: .black.opacity(0.35), radius: 2, y: 1)
            }
            .buttonStyle(.plain)
            .padding(6)
            .accessibilityLabel("Remove from library")
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
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
