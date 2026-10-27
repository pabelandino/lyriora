//
//  BibleSlideGridView.swift
//  Lyriora
//

import SwiftUI

struct BibleSlideGridView: View {
    @Bindable var viewModel: AppViewModel
    let session: BibleReadingSession
    let presentationState: PresentationState
    let defaultBackgroundSettings: DefaultBackgroundSettings
    var backgroundContentMode: BackgroundContentMode = .fill

    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout

    private var thumbnailWidth: CGFloat {
        workspaceCompactLayout ? 120 : 168
    }

    private var canGoNext: Bool {
        viewModel.bibleCanGoNext(in: session)
    }

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            VStack(spacing: 0) {
                header

                GeometryReader { geometry in
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(Array(session.slides.enumerated()), id: \.element.id) { index, slide in
                                    BibleSlideThumbnailView(
                                        slide: slide,
                                        style: viewModel.settings.biblePresentation.style,
                                        isLive: index == session.previewSlideIndex,
                                        isFocused: index == session.stripFocusIndex,
                                        width: thumbnailWidth
                                    )
                                    .id(slide.id)
                                    .onTapGesture {
                                        viewModel.selectBibleSlide(at: index)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                        }
                        .onChange(of: session.stripFocusIndex) { _, newIndex in
                            guard session.slides.indices.contains(newIndex) else { return }
                            withAnimation(.easeInOut(duration: 0.2)) {
                                proxy.scrollTo(session.slides[newIndex].id, anchor: .center)
                            }
                        }
                    }
                }
            }
        }
    }

    private var header: some View {
        HStack(spacing: 10) {
            Label("Bible reading", systemImage: "book")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            Text(session.versionName)
                .font(.caption.weight(.medium))
                .foregroundStyle(.tertiary)
                .lineLimit(1)

            Spacer(minLength: 0)

            HStack(spacing: 2) {
                bibleNavigationButton(
                    systemName: "chevron.left",
                    accessibilityLabel: "Previous verse",
                    isEnabled: session.canGoPreviousInStrip
                ) {
                    viewModel.goToPreviousBibleSlide()
                }

                Text(slideCounterLabel)
                    .font(.footnote.weight(.semibold).monospacedDigit())
                    .foregroundStyle(.secondary)
                    .frame(minWidth: 48)

                bibleNavigationButton(
                    systemName: "chevron.right",
                    accessibilityLabel: "Next verse",
                    isEnabled: canGoNext
                ) {
                    viewModel.goToNextBibleSlide()
                }
            }

            Button(role: .destructive) {
                viewModel.dismissBibleReadingSession()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title3)
                    .symbolRenderingMode(.hierarchical)
                    .frame(width: 44, height: 44)
                    .contentShape(Circle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("End Bible reading")
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
        .padding(.bottom, 4)
    }

    private func bibleNavigationButton(
        systemName: String,
        accessibilityLabel: String,
        isEnabled: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.body.weight(.semibold))
                .frame(width: 44, height: 44)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .foregroundStyle(isEnabled ? .primary : .tertiary)
        .disabled(!isEnabled)
        .accessibilityLabel(accessibilityLabel)
    }

    private var slideCounterLabel: String {
        let focus = session.stripFocusIndex + 1
        let loaded = session.slides.count
        if canGoNext, session.stripFocusIndex == loaded - 1 {
            return "\(focus)/\(loaded)+"
        }
        return "\(focus)/\(loaded)"
    }
}

private struct BibleSlideThumbnailView: View {
    let slide: BiblePresentationSlide
    let style: SlideTextStyle
    let isLive: Bool
    let isFocused: Bool
    let width: CGFloat

    private let aspectRatio: CGFloat = 16 / 9
    private let textInset: CGFloat = 8

    private var thumbnailStyle: SlideTextStyle {
        var resolved = style
        resolved.paddingRatio = max(resolved.paddingRatio, 0.12)
        resolved.maxFontSize = min(resolved.maxFontSize, 22)
        resolved.minFontSize = min(resolved.minFontSize, 10)
        resolved.isAdaptiveScalingEnabled = true
        return resolved
    }

    private var textConfiguration: PresentationTextConfiguration {
        PresentationTextConfiguration(style: thumbnailStyle)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.black.opacity(0.85))

                GeometryReader { geometry in
                    EditorAdaptivePresentationText(
                        text: slide.text,
                        configuration: textConfiguration,
                        containerSize: geometry.size,
                        sizing: .scaledApproximation
                    )
                }
                .padding(textInset)
            }
            .aspectRatio(aspectRatio, contentMode: .fit)
            .frame(width: width)
            .clipped()
            .overlay {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .strokeBorder(borderColor, lineWidth: borderWidth)
            }

            HStack(spacing: 4) {
                if isLive {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 6, height: 6)
                }
                Text(slide.referenceLabel)
                    .font(.caption2.weight(.medium))
                    .foregroundStyle(isLive ? .primary : .secondary)
                    .lineLimit(1)
            }
        }
        .contentShape(Rectangle())
        .opacity(isLive || isFocused ? 1 : 0.72)
    }

    private var borderColor: Color {
        if isLive {
            return .green
        }
        if isFocused {
            return .white.opacity(0.75)
        }
        return .white.opacity(0.15)
    }

    private var borderWidth: CGFloat {
        if isLive || isFocused {
            return 2
        }
        return 1
    }
}
