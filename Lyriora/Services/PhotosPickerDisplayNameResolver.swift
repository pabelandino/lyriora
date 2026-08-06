//
//  PhotosPickerDisplayNameResolver.swift
//  Lyriora
//

import Photos
import PhotosUI
import SwiftUI

enum PhotosPickerDisplayNameResolver {
    static func displayName(for item: PhotosPickerItem) -> String? {
        guard let identifier = item.itemIdentifier else { return nil }

        let assets = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: nil)
        guard let asset = assets.firstObject else { return nil }

        let resources = PHAssetResource.assetResources(for: asset)
        guard let resource = resources.first else { return nil }

        let baseName = (resource.originalFilename as NSString).deletingPathExtension
        guard !baseName.isEmpty else { return nil }

        return baseName
    }
}
