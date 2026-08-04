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
            VideoLibrarySection(viewModel: viewModel)
        }
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
    let onSelect: () -> Void
    let onRemove: () -> Void

    private let cornerRadius: CGFloat = 14

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        Button(action: onSelect) {
            ZStack(alignment: .bottomLeading) {
                thumbnailContent
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()

                if showsDuration {
                    Text("00:00")
                        .font(.caption2.weight(.semibold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .glassEffect(.regular, in: .capsule)
                        .padding(8)
                }
            }
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
    }

    @ViewBuilder
    private var thumbnailContent: some View {
        if asset.kind == .image {
            LocalFileThumbnailImage(url: fileURL)
        } else {
            ZStack {
                Color.black.opacity(0.25)

                Image(systemName: "play.rectangle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
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
            image = LocalFileImageBackground.loadImage(from: url)
        }
    }
}
