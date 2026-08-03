//
//  StickyPreviewEditorLayout.swift
//  Lyriora
//

import SwiftUI

struct StickyPreviewEditorLayout<Preview: View, Content: View>: View {
    @ViewBuilder var preview: () -> Preview
    @ViewBuilder var content: () -> Content

    private let contentMaxWidth: CGFloat = 700
    private let previewHeight: CGFloat = 200
    private let previewVerticalPadding: CGFloat = 12
    private let previewHorizontalPadding: CGFloat = 20

    var body: some View {
        VStack(spacing: 0) {
            previewSection

            Divider()

            ScrollView {
                content()
                    .padding(24)
                    .frame(maxWidth: contentMaxWidth)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

    @ViewBuilder
    private var previewSection: some View {
        GeometryReader { geometry in
            let containerSize = CGSize(
                width: max(geometry.size.width, 1),
                height: previewHeight
            )

            preview()
                .environment(\.previewContainerSize, containerSize)
                .frame(width: geometry.size.width, height: previewHeight, alignment: .center)
        }
        .frame(maxWidth: contentMaxWidth)
        .frame(maxWidth: .infinity)
        .frame(height: previewHeight)
        .padding(.horizontal, previewHorizontalPadding)
        .padding(.vertical, previewVerticalPadding)
        .frame(maxWidth: .infinity)
        .background(stickyBackground)
        .zIndex(1)
    }

    @ViewBuilder
    private var stickyBackground: some View {
        #if os(macOS)
        Color(nsColor: .windowBackgroundColor)
        #else
        Color(uiColor: .systemBackground)
        #endif
    }
}
