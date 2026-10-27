//
//  MetalTextEffectRenderer.swift
//  Lyriora
//

import Metal
import MetalKit
import SwiftUI

enum MetalTextEffectSupport {
    static let isAvailable: Bool = MetalTextEffectRenderer.make() != nil
}

struct MetalTextEffectParameters: Equatable {
    var glitchStrength: Float = 0
    var chromaticStrength: Float = 0
    var glowStrength: Float = 0
    var scanlineStrength: Float = 0

    var isActive: Bool {
        glitchStrength > 0.01 || chromaticStrength > 0.01 || glowStrength > 0.01 || scanlineStrength > 0.01
    }

    static func forAnimation(
        kind: TextAnimationKind,
        time: TimeInterval,
        intensity: Double,
        speed: Double
    ) -> MetalTextEffectParameters {
        let phase = Double(time * speed)
        let power = Float(intensity)

        switch kind {
        case .glitchSlice, .hudGlitch:
            let glitchGate = Float(abs(sin(phase * 6)))
            let glitchStrength = Swift.min(1, 0.35 + 0.45 * power * glitchGate)
            let chromaStrength = Swift.min(1, 0.25 + 0.35 * power)
            let glowStrength = Swift.min(1, 0.2 + 0.25 * power)
            let scanlineStrength = kind == .hudGlitch ? Swift.min(1, 0.4 * power) : Float(0)
            return MetalTextEffectParameters(
                glitchStrength: glitchStrength,
                chromaticStrength: chromaStrength,
                glowStrength: glowStrength,
                scanlineStrength: scanlineStrength
            )
        case .chromaticShift:
            let pulse = Float(0.5 + 0.5 * sin(phase * 4))
            let chromaStrength = Swift.min(1, 0.35 + 0.5 * power * pulse)
            let glowStrength = Swift.min(1, 0.15 * power)
            return MetalTextEffectParameters(
                chromaticStrength: chromaStrength,
                glowStrength: glowStrength
            )
        case .neonGlow, .gradientNeon:
            let pulse = Float(0.5 + 0.5 * sin(phase * 3))
            let glowStrength = Swift.min(1, 0.45 + 0.4 * power * pulse)
            let chromaStrength = Swift.min(1, 0.12 * power)
            return MetalTextEffectParameters(
                chromaticStrength: chromaStrength,
                glowStrength: glowStrength
            )
        default:
            return MetalTextEffectParameters()
        }
    }
}

final class MetalTextEffectRenderer: NSObject, MTKViewDelegate {
    private let device: MTLDevice
    private let commandQueue: MTLCommandQueue
    private let pipelineState: MTLRenderPipelineState
    private let samplerState: MTLSamplerState
    private var sourceTexture: MTLTexture?
    private var uniforms = TextEffectUniformsMetal(
        time: 0,
        glitchStrength: 0,
        chromaticStrength: 0,
        glowStrength: 0,
        scanlineStrength: 0
    )

    struct TextEffectUniformsMetal {
        var time: Float
        var glitchStrength: Float
        var chromaticStrength: Float
        var glowStrength: Float
        var scanlineStrength: Float
    }

    static func make() -> MetalTextEffectRenderer? {
        guard
            let device = MTLCreateSystemDefaultDevice(),
            let commandQueue = device.makeCommandQueue(),
            let library = device.makeDefaultLibrary(),
            let vertexFunction = library.makeFunction(name: "lyricTextVertex"),
            let fragmentFunction = library.makeFunction(name: "lyricTextFragment")
        else {
            return nil
        }

        let descriptor = MTLRenderPipelineDescriptor()
        descriptor.vertexFunction = vertexFunction
        descriptor.fragmentFunction = fragmentFunction
        descriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        descriptor.colorAttachments[0].isBlendingEnabled = true
        descriptor.colorAttachments[0].rgbBlendOperation = .add
        descriptor.colorAttachments[0].alphaBlendOperation = .add
        descriptor.colorAttachments[0].sourceRGBBlendFactor = .sourceAlpha
        descriptor.colorAttachments[0].sourceAlphaBlendFactor = .sourceAlpha
        descriptor.colorAttachments[0].destinationRGBBlendFactor = .oneMinusSourceAlpha
        descriptor.colorAttachments[0].destinationAlphaBlendFactor = .oneMinusSourceAlpha

        guard let pipelineState = try? device.makeRenderPipelineState(descriptor: descriptor) else {
            return nil
        }

        let samplerDescriptor = MTLSamplerDescriptor()
        samplerDescriptor.minFilter = .linear
        samplerDescriptor.magFilter = .linear
        guard let samplerState = device.makeSamplerState(descriptor: samplerDescriptor) else {
            return nil
        }

        return MetalTextEffectRenderer(
            device: device,
            commandQueue: commandQueue,
            pipelineState: pipelineState,
            samplerState: samplerState
        )
    }

    private init(
        device: MTLDevice,
        commandQueue: MTLCommandQueue,
        pipelineState: MTLRenderPipelineState,
        samplerState: MTLSamplerState
    ) {
        self.device = device
        self.commandQueue = commandQueue
        self.pipelineState = pipelineState
        self.samplerState = samplerState
        super.init()
    }

    func attach(to view: MTKView) {
        view.device = device
        view.delegate = self
        view.framebufferOnly = false
        view.isPaused = false
        view.enableSetNeedsDisplay = false
        view.preferredFramesPerSecond = 30
        view.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
        #if os(macOS)
        view.layer?.isOpaque = false
        #else
        view.isOpaque = false
        view.backgroundColor = .clear
        view.layer.isOpaque = false
        #endif
    }

    func update(sourceImage: CGImage, parameters: MetalTextEffectParameters, time: TimeInterval) {
        let textureLoader = MTKTextureLoader(device: device)
        sourceTexture = try? textureLoader.newTexture(cgImage: sourceImage, options: [
            .SRGB: false,
            .generateMipmaps: false
        ])

        uniforms = TextEffectUniformsMetal(
            time: Float(time),
            glitchStrength: parameters.glitchStrength,
            chromaticStrength: parameters.chromaticStrength,
            glowStrength: parameters.glowStrength,
            scanlineStrength: parameters.scanlineStrength
        )
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}

    func draw(in view: MTKView) {
        guard
            let drawable = view.currentDrawable,
            let passDescriptor = view.currentRenderPassDescriptor,
            let sourceTexture,
            let commandBuffer = commandQueue.makeCommandBuffer(),
            let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor)
        else { return }

        encoder.setRenderPipelineState(pipelineState)
        encoder.setFragmentTexture(sourceTexture, index: 0)
        encoder.setFragmentSamplerState(samplerState, index: 0)
        encoder.setFragmentBytes(&uniforms, length: MemoryLayout<TextEffectUniformsMetal>.stride, index: 0)
        encoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
        encoder.endEncoding()

        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
