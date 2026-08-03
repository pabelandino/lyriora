//
//  LyricSlideLivePreview.swift
//  Lyriora
//

import SwiftUI

struct LyricSlideLivePreview: View {
    let slide: LyricSlide?
    let style: SlideTextStyle
    let language: LyricLanguage
    let scopeLabel: String
    var compact: Bool = false
    var previewText: String?

    @Environment(\.previewContainerSize) private var previewContainerSize

    private var cornerRadius: CGFloat { compact ? 18 : 20 }
    private var compactHeight: CGFloat { 200 }

    private var displayText: String {
        previewText ?? slide?.text ?? ""
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    private var previewConfiguration: PresentationTextConfiguration {
        style.presentationConfiguration(isPreview: compact)
    }

    private var resolvedContainerSize: CGSize {
        if let previewContainerSize {
            return previewContainerSize
        }
        return CGSize(width: 640, height: compact ? compactHeight : 400)
    }

    var body: some View {
        VStack(spacing: compact ? 8 : 12) {
            if !compact {
                headerRow
            }

            previewCard
        }
        .frame(width: resolvedContainerSize.width, alignment: .center)
    }

    @ViewBuilder
    private var headerRow: some View {
        HStack {
            Text(scopeLabel)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            Spacer()

            if let slide {
                Text(slide.tag.localizedName(for: language))
                    .font(.caption.weight(.bold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.ultraThinMaterial, in: Capsule())
            }
        }
    }

    @ViewBuilder
    private var previewCard: some View {
        let size = resolvedContainerSize

        ZStack {
            shape
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.05, green: 0.11, blue: 0.24),
                            Color(red: 0.10, green: 0.22, blue: 0.44),
                            Color(red: 0.04, green: 0.08, blue: 0.20)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            previewCardContent(containerSize: size)
        }
        .frame(width: size.width, height: size.height)
        .clipShape(shape)
        .glassEffect(.regular, in: .rect(cornerRadius: cornerRadius, style: .continuous))
        .overlay {
            shape.strokeBorder(.white.opacity(0.15), lineWidth: 1)
        }
    }

    @ViewBuilder
    private func previewCardContent(containerSize: CGSize) -> some View {
        if !displayText.isEmpty {
            EditorAdaptivePresentationText(
                text: displayText,
                configuration: previewConfiguration,
                containerSize: containerSize
            )
        } else {
            Text("Select a slide or import lyrics to preview.")
                .font(compact ? .callout : .body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.65))
                .padding(24)
                .frame(width: containerSize.width, height: containerSize.height, alignment: .center)
        }
    }
}
