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
            .glassEffect(.regular, in: .rect(cornerRadius: cornerRadius, style: .continuous))
    }
}

struct GlassCapsuleToolbar<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        HStack(spacing: 24) {
            content()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
        .glassEffect(.regular.interactive(), in: .capsule)
    }
}

enum GlassToolbarIconSize {
    case regular
    case prominent

    var iconFont: Font {
        switch self {
        case .regular:
            .system(size: 18, weight: .semibold)
        case .prominent:
            .system(size: 20, weight: .semibold)
        }
    }

    var frameSize: CGFloat {
        switch self {
        case .regular: 40
        case .prominent: 40
        }
    }
}

struct GlassIconButton: View {
    let systemName: String
    let accessibilityLabel: String
    var size: GlassToolbarIconSize = .regular
    var isActive: Bool = false
    var isEnabled: Bool = true
    let action: () -> Void

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
        return isActive ? .green : .primary
    }
}

extension View {
    func transparentScrollContent() -> some View {
        scrollContentBackground(.hidden)
    }
}

struct GlassCircleIcon: View {
    let systemName: String
    var diameter: CGFloat = 36
    var symbolSize: CGFloat = 15

    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: symbolSize, weight: .bold))
            .foregroundStyle(.white.opacity(0.95))
            .frame(width: diameter, height: diameter)
            .contentShape(Circle())
            .glassEffect(.regular.interactive(), in: .circle)
            .shadow(color: .black.opacity(0.18), radius: 2, y: 1)
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
                        action.handler()
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
    }
}
