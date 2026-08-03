//
//  GlassPanel.swift
//  Lyriora
//

import SwiftUI

struct GlassPanel<Content: View>: View {
    var cornerRadius: CGFloat = 24
    var variant: Glass = .regular
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .glassEffect(variant, in: .rect(cornerRadius: cornerRadius))
    }
}

struct GlassCapsuleToolbar<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        GlassEffectContainer(spacing: 24) {
            HStack(spacing: 24) {
                content()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            .glassEffect(.regular.interactive(), in: .capsule)
        }
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
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(size.iconFont)
                .frame(width: size.frameSize, height: size.frameSize)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .foregroundStyle(isActive ? Color.green : .primary)
        .accessibilityLabel(accessibilityLabel)
    }
}

struct GlassMediaThumbnail<Content: View>: View {
    var cornerRadius: CGFloat = 14
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .frame(maxWidth: .infinity)
            .frame(height: 88)
            .glassEffect(.clear, in: .rect(cornerRadius: cornerRadius))
    }
}
