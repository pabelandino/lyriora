//
//  GlassPanel.swift
//  Lyriora
//

import SwiftUI

struct GlassPanel<Content: View>: View {
    var cornerRadius: CGFloat = 24
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .clipShape(panelShape)
            .glassEffect(.regular, in: .rect(cornerRadius: cornerRadius, style: .continuous))
    }

    private var panelShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }
}

struct GlassCapsuleToolbar<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        HStack(spacing: GlassToolbarMetrics.itemSpacing) {
            content()
        }
        .padding(.horizontal, GlassToolbarMetrics.horizontalPadding)
        .padding(.vertical, GlassToolbarMetrics.verticalPadding)
        .glassEffect(.regular.interactive(), in: .capsule)
    }
}

enum GlassToolbarMetrics {
    static let horizontalPadding: CGFloat = 20
    static let verticalPadding: CGFloat = 6
    static let itemSpacing: CGFloat = 20
    static let iconSize: CGFloat = 36
    static let iconFontSize: CGFloat = 17
    static let prominentIconFontSize: CGFloat = 18

    static var controlHeight: CGFloat {
        iconSize + verticalPadding * 2
    }
}

enum GlassToolbarIconSize {
    case regular
    case prominent

    var iconFont: Font {
        switch self {
        case .regular:
            .system(size: GlassToolbarMetrics.iconFontSize, weight: .semibold)
        case .prominent:
            .system(size: GlassToolbarMetrics.prominentIconFontSize, weight: .semibold)
        }
    }

    var frameSize: CGFloat {
        GlassToolbarMetrics.iconSize
    }
}

enum GlassToolbarIconStyle {
    static func foreground(isActive: Bool, colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .light:
            isActive ? activeLight : inactiveLight
        case .dark:
            isActive ? .green : .primary
        @unknown default:
            isActive ? .green : .primary
        }
    }

    private static let activeLight = Color(red: 0.10, green: 0.72, blue: 0.34)
    private static let inactiveLight = Color(white: 0.42)
}

struct GlassIconButton: View {
    let systemName: String
    let accessibilityLabel: String
    var size: GlassToolbarIconSize = .regular
    var isActive: Bool = false
    var isEnabled: Bool = true
    let action: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(size.iconFont)
                .frame(width: size.frameSize, height: size.frameSize)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .foregroundStyle(foregroundColor)
        .opacity(isEnabled ? 1 : 0.45)
        .disabled(!isEnabled)
        .accessibilityLabel(accessibilityLabel)
    }

    private var foregroundColor: Color {
        guard isEnabled else { return .secondary }
        return GlassToolbarIconStyle.foreground(isActive: isActive, colorScheme: colorScheme)
    }
}

extension View {
    func transparentScrollContent() -> some View {
        scrollContentBackground(.hidden)
            .scrollClipDisabled(false)
    }

    func clippedPanelScrollContent() -> some View {
        frame(maxHeight: .infinity)
            .transparentScrollContent()
    }
}

enum GlassControlChrome {
    static let borderWidth: CGFloat = 1

    static func iconForeground(for colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .light:
            Color(white: 0.38)
        case .dark:
            Color.white.opacity(0.95)
        @unknown default:
            Color.primary
        }
    }

    static func liquidGlassBorderGradient(for colorScheme: ColorScheme) -> LinearGradient {
        switch colorScheme {
        case .light:
            LinearGradient(
                colors: [
                    Color.white.opacity(0.78),
                    Color.primary.opacity(0.12),
                    Color.black.opacity(0.08)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .dark:
            LinearGradient(
                colors: [
                    Color.white.opacity(0.46),
                    Color.white.opacity(0.16),
                    Color.white.opacity(0.05)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        @unknown default:
            LinearGradient(
                colors: [
                    Color.primary.opacity(0.14),
                    Color.primary.opacity(0.08)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    static func shadowColor(for colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .light:
            Color.black.opacity(0.10)
        case .dark:
            Color.black.opacity(0.18)
        @unknown default:
            Color.black.opacity(0.14)
        }
    }
}

private struct GlassControlBorderModifier<S: InsettableShape>: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    let shape: S

    func body(content: Content) -> some View {
        content
            .compositingGroup()
            .overlay {
                shape.strokeBorder(
                    GlassControlChrome.liquidGlassBorderGradient(for: colorScheme),
                    lineWidth: GlassControlChrome.borderWidth
                )
                .allowsHitTesting(false)
            }
    }
}

extension View {
    func glassControlBorder<S: InsettableShape>(_ shape: S) -> some View {
        modifier(GlassControlBorderModifier(shape: shape))
    }
}

struct GlassCircleIcon: View {
    let systemName: String
    var diameter: CGFloat = 36
    var symbolSize: CGFloat = 15

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: symbolSize, weight: .bold))
            .foregroundStyle(GlassControlChrome.iconForeground(for: colorScheme))
            .frame(width: diameter, height: diameter)
            .contentShape(Circle())
            .glassEffect(.regular.interactive(), in: .circle)
            .shadow(
                color: GlassControlChrome.shadowColor(for: colorScheme),
                radius: 2,
                y: 1
            )
            .glassControlBorder(Circle())
    }
}

struct GlassOverflowMenu: View {
    struct Action: Identifiable {
        let id = UUID()
        let title: String
        let systemImage: String
        var role: ButtonRole?
        let handler: () -> Void
    }

    let actions: [Action]
    var iconSize: CGFloat = 36

    @State private var isPresented = false

    var body: some View {
        Button {
            isPresented = true
        } label: {
            GlassCircleIcon(systemName: "ellipsis", diameter: iconSize)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Lyric options")
        .popover(isPresented: $isPresented, arrowEdge: .top) {
            VStack(spacing: 4) {
                ForEach(actions) { action in
                    Button(role: action.role) {
                        isPresented = false
                        DispatchQueue.main.async {
                            action.handler()
                        }
                    } label: {
                        Label(action.title, systemImage: action.systemImage)
                            .font(.body.weight(.medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(8)
            .frame(minWidth: 168)
            .glassEffect(.regular, in: .rect(cornerRadius: 14, style: .continuous))
        }
        #if os(iOS)
        .presentationCompactAdaptation(.popover)
        #endif
    }
}
