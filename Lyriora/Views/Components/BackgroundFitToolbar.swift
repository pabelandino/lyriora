//
//  BackgroundFitToolbar.swift
//  Lyriora
//

import SwiftUI

struct BackgroundFitToolbar: View {
    @Binding var contentMode: BackgroundContentMode
    var isEnabled: Bool = true
    var onChange: () -> Void

    @Namespace private var glassNamespace
    @State private var isExpanded = false

    var body: some View {
        GlassEffectContainer(spacing: Constants.badgeGlassSpacing) {
            toggleButton
                .frame(width: Constants.badgeSize, height: Constants.badgeSize)
                .overlay(alignment: .top) {
                    if isExpanded {
                        expandedOptions
                            .padding(.top, Constants.badgeSize + Constants.badgeSpacing)
                    }
                }
        }
        .frame(width: Constants.badgeSize, height: Constants.badgeSize, alignment: .top)
        .zIndex(isExpanded ? 100 : 1)
        .opacity(isEnabled ? 1 : 0.45)
        .allowsHitTesting(isEnabled)
    }

    private var expandedOptions: some View {
        VStack(spacing: Constants.badgeSpacing) {
            ForEach(BackgroundContentMode.allCases) { mode in
                Button {
                    contentMode = mode
                    withAnimation(GlassMorphAnimation.standard) {
                        isExpanded = false
                    }
                    onChange()
                } label: {
                    BackgroundFitBadgeLabel(
                        mode: mode,
                        isSelected: contentMode == mode
                    )
                    .frame(
                        width: Constants.badgeSize,
                        height: Constants.badgeSize
                    )
                }
                .buttonStyle(.plain)
                .glassEffect(.regular.interactive(), in: .circle)
                .glassEffectID(mode.id, in: glassNamespace)
                .accessibilityLabel(mode.label)
                .accessibilityHint(mode.subtitle)
                .accessibilityAddTraits(contentMode == mode ? .isSelected : [])
            }
        }
    }

    private var toggleButton: some View {
        Button {
            withAnimation(GlassMorphAnimation.standard) {
                isExpanded.toggle()
            }
        } label: {
            BackgroundFitToggleLabel(mode: contentMode, isExpanded: isExpanded)
                .frame(
                    width: Constants.badgeSize,
                    height: Constants.badgeSize
                )
        }
        .buttonStyle(.plain)
        #if os(macOS)
        .tint(.clear)
        #endif
        .glassEffect(.regular.interactive(), in: .circle)
        .glassEffectID("background-fit-toggle", in: glassNamespace)
        .accessibilityLabel("Background fit")
        .accessibilityValue(contentMode.label)
        .accessibilityHint(isExpanded ? "Collapse background fit options" : "Expand background fit options")
    }
}

private struct BackgroundFitBadgeLabel: View {
    let mode: BackgroundContentMode
    let isSelected: Bool

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Image(systemName: mode.systemImage)
            .font(.system(size: GlassToolbarMetrics.iconFontSize, weight: .semibold))
            .foregroundStyle(
                GlassToolbarIconStyle.foreground(isActive: isSelected, colorScheme: colorScheme)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Circle())
    }
}

private struct BackgroundFitToggleLabel: View {
    let mode: BackgroundContentMode
    let isExpanded: Bool

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Image(systemName: isExpanded ? "xmark" : mode.systemImage)
            .font(.system(size: GlassToolbarMetrics.iconFontSize, weight: .semibold))
            .foregroundStyle(
                GlassToolbarIconStyle.foreground(isActive: isExpanded, colorScheme: colorScheme)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Circle())
    }
}

extension BackgroundFitToolbar {
    enum Layout {
        static let reservedSize: CGFloat = Constants.badgeSize
    }
}

extension BackgroundFitToolbar {
    fileprivate enum Constants {
        static let badgeSize: CGFloat = GlassToolbarMetrics.controlHeight
        static let badgeSpacing: CGFloat = 8
        static let badgeGlassSpacing: CGFloat = 8
    }
}
