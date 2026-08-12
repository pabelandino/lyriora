//
//  MetalTextEffectView.swift
//  Lyriora
//

import MetalKit
import SwiftUI
#if os(macOS)
import AppKit
#else
import UIKit
#endif

struct MetalTextEffectContainer<Content: View>: View {
    let time: TimeInterval
    let parameters: MetalTextEffectParameters
    @ViewBuilder var content: () -> Content

    var body: some View {
        if parameters.isActive, MetalTextEffectSupport.isAvailable {
            MetalTextEffectRepresentable(time: time, parameters: parameters, content: content())
        } else {
            content()
        }
    }
}

#if os(macOS)
private struct MetalTextEffectRepresentable<Content: View>: NSViewRepresentable {
    let time: TimeInterval
    let parameters: MetalTextEffectParameters
    let content: Content

    final class ContainerView: NSView {
        let mtkView = MTKView(frame: .zero, device: nil)
        let renderer: MetalTextEffectRenderer?

        override init(frame frameRect: NSRect) {
            renderer = MetalTextEffectRenderer.make()
            super.init(frame: frameRect)
            wantsLayer = true
            layer?.backgroundColor = NSColor.clear.cgColor
            mtkView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(mtkView)
            NSLayoutConstraint.activate([
                mtkView.leadingAnchor.constraint(equalTo: leadingAnchor),
                mtkView.trailingAnchor.constraint(equalTo: trailingAnchor),
                mtkView.topAnchor.constraint(equalTo: topAnchor),
                mtkView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            renderer?.attach(to: mtkView)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            nil
        }
    }

    func makeNSView(context: Context) -> ContainerView {
        ContainerView()
    }

    func updateNSView(_ nsView: ContainerView, context: Context) {
        guard let renderer = nsView.renderer else { return }

        let imageRenderer = ImageRenderer(content: content)
        imageRenderer.scale = 2
        guard let cgImage = imageRenderer.cgImage else { return }
        renderer.update(sourceImage: cgImage, parameters: parameters, time: time)
    }
}
#else
private struct MetalTextEffectRepresentable<Content: View>: UIViewRepresentable {
    let time: TimeInterval
    let parameters: MetalTextEffectParameters
    let content: Content

    final class ContainerView: UIView {
        let mtkView = MTKView(frame: .zero, device: nil)
        let renderer: MetalTextEffectRenderer?

        override init(frame: CGRect) {
            renderer = MetalTextEffectRenderer.make()
            super.init(frame: frame)
            backgroundColor = .clear
            mtkView.translatesAutoresizingMaskIntoConstraints = false
            mtkView.isOpaque = false
            mtkView.backgroundColor = .clear
            addSubview(mtkView)
            NSLayoutConstraint.activate([
                mtkView.leadingAnchor.constraint(equalTo: leadingAnchor),
                mtkView.trailingAnchor.constraint(equalTo: trailingAnchor),
                mtkView.topAnchor.constraint(equalTo: topAnchor),
                mtkView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            renderer?.attach(to: mtkView)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            nil
        }
    }

    func makeUIView(context: Context) -> ContainerView {
        ContainerView()
    }

    func updateUIView(_ uiView: ContainerView, context: Context) {
        guard let renderer = uiView.renderer else { return }

        let imageRenderer = ImageRenderer(content: content)
        imageRenderer.scale = 2
        guard let cgImage = imageRenderer.cgImage else { return }
        renderer.update(sourceImage: cgImage, parameters: parameters, time: time)
    }
}
#endif
