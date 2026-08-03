//
//  ExternalDisplayInfo.swift
//  Lyriora
//

import CoreGraphics
import Foundation

struct ExternalDisplayInfo: Equatable, Sendable {
    let name: String
    let resolution: CGSize
    let scale: CGFloat
    let isConnected: Bool

    static let unavailable = ExternalDisplayInfo(
        name: "No external display",
        resolution: .zero,
        scale: 1,
        isConnected: false
    )

    var resolutionDescription: String {
        guard isConnected else { return "Not connected" }
        return "\(Int(resolution.width)) × \(Int(resolution.height)) @ \(String(format: "%.1fx", scale))"
    }
}
