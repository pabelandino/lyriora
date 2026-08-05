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
            VStack(alignment: .center, spacing: Constants.badgeSpacing) {
                toggleButton

                if isExpanded {
                    VStack(spacing: Constants.badgeSpacing) {
                        ForEach(BackgroundContentMode.allCases) { mode in
                            Button {
                                withAnimation {
                                    contentMode = mode
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
                            .glassEffect(.regular, in: .rect(cornerRadius: Constants.badgeCornerRadius))
                            .glassEffectID(mode.id, in: glassNamespace)
                            .accessibilityLabel(mode.label)
                            .accessibilityHint(mode.subtitle)
                            .accessibilityAddTraits(contentMode == mode ? .isSelected : [])
                        }
                    }
                }
            }
            .frame(width: Constants.badgeFrameWidth, alignment: .top)
        }
        // Reserve only the toggle footprint in layout; badges overflow downward as an overlay.
        .frame(
            width: Constants.badgeSize,
            height: Constants.badgeSize,
            alignment: .top
        )
        .zIndex(isExpanded ? 100 : 0)
        .opacity(isEnabled ? 1 : 0.45)
        .allowsHitTesting(isEnabled)
    }

    private var toggleButton: some View {
        Button {
            withAnimation {
                isExpanded.toggle()
            }
        } label: {
            BackgroundFitToggleLabel(mode: contentMode, isExpanded: isExpanded)
            .frame(
                width: Constants.badgeSize,
                height: Constants.badgeSize
            )
        }
        .buttonStyle(.glass)
        #if os(macOS)
        .tint(.clear)
        #endif
        .glassEffectID("background-fit-toggle", in: glassNamespace)
        .accessibilityLabel("Background fit")
        .accessibilityValue(contentMode.label)
        .accessibilityHint(isExpanded ? "Collapse background fit options" : "Expand background fit options")
    }
}

private struct BackgroundFitBadgeLabel: View {
    let mode: BackgroundContentMode
    let isSelected: Bool

    var body: some View {
        Image(systemName: mode.systemImage)
            .font(.system(size: 17, weight: .semibold))
            .foregroundStyle(isSelected ? .green : .primary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(RoundedRectangle(cornerRadius: BackgroundFitToolbar.Constants.badgeCornerRadius))
    }
}

private struct BackgroundFitToggleLabel: View {
    let mode: BackgroundContentMode
    let isExpanded: Bool

    var body: some View {
        Image(systemName: isExpanded ? "xmark" : mode.systemImage)
            .font(.system(size: 17, weight: .semibold))
            .foregroundStyle(isExpanded ? .green : .primary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(RoundedRectangle(cornerRadius: BackgroundFitToolbar.Constants.badgeCornerRadius))
    }
}

extension BackgroundFitToolbar {
    enum Layout {
        static let reservedSize: CGFloat = Constants.badgeSize
    }
}

private extension BackgroundFitToolbar {
    enum Constants {
        static let badgeCornerRadius: CGFloat = 12
        static let badgeSize: CGFloat = 44
        static let badgeSpacing: CGFloat = 8
        static let badgeGlassSpacing: CGFloat = 8
        static let badgeFrameWidth: CGFloat = 44
    }
}
