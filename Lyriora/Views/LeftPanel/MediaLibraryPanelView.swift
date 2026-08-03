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
                                onRemove: { viewModel.deleteMediaAsset(asset) }
                            )
                            .onTapGesture {
                                viewModel.selectBackgroundMedia(asset)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                }
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
                                onRemove: { viewModel.deleteMediaAsset(asset) }
                            )
                            .onTapGesture {
                                viewModel.selectBackgroundMedia(asset)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                }
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
            Image(systemName: "plus.circle.fill")
                .font(.title3)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.green, .white.opacity(0.85))
        }
        .accessibilityLabel(accessibilityLabel)
    }
    .padding(.horizontal, 16)
}

private struct MediaThumbnailView: View {
    let asset: MediaAsset
    let fileURL: URL
    var isSelected: Bool = false
    var showsDuration: Bool = false
    let onRemove: () -> Void

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if asset.kind == .image {
                AsyncImage(url: fileURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        Image(systemName: "photo")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            } else {
                ZStack {
                    Color.black.opacity(0.25)

                    Image(systemName: "play.rectangle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

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
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .glassEffect(.clear, in: .rect(cornerRadius: 14))
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
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(.white.opacity(0.9), lineWidth: 2.5)
            }
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
