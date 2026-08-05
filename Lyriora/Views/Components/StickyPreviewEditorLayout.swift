//
//  StickyPreviewEditorLayout.swift
//  Lyriora
//

import SwiftUI

struct StickyPreviewEditorLayout<Preview: View, Content: View>: View {
    @ViewBuilder var preview: () -> Preview
    @ViewBuilder var content: () -> Content

    private let contentMaxWidth: CGFloat = 700
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
            .scrollDismissesKeyboard(.interactively)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

    @ViewBuilder
    private var previewSection: some View {
        Color.clear
            .aspectRatio(
                PresentationLayout.aspectRatio(for: PresentationLayout.textStylePreviewCanvasSize),
                contentMode: .fit
            )
            .frame(maxWidth: contentMaxWidth)
            .frame(maxWidth: .infinity)
            .overlay {
                GeometryReader { geometry in
                    preview()
                        .environment(
                            \.previewContainerSize,
                            CGSize(
                                width: max(geometry.size.width, 1),
                                height: max(geometry.size.height, 1)
                            )
                        )
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height,
                            alignment: .center
                        )
                }
            }
            .padding(.horizontal, previewHorizontalPadding)
            .padding(.vertical, previewVerticalPadding)
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
