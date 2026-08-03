//
//  CodableColor.swift
//  Lyriora
//

import SwiftUI

struct CodableColor: Codable, Equatable, Sendable {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double

    init(red: Double, green: Double, blue: Double, alpha: Double = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: alpha)
    }

    static let white = CodableColor(red: 1, green: 1, blue: 1)
    static let black = CodableColor(red: 0, green: 0, blue: 0)

    init(from color: Color) {
        #if canImport(UIKit)
        let uiColor = UIColor(color)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        red = Double(r)
        green = Double(g)
        blue = Double(b)
        alpha = Double(a)
        #elseif os(macOS)
        let nsColor = NSColor(color)
        let converted = nsColor.usingColorSpace(.deviceRGB) ?? nsColor
        red = Double(converted.redComponent)
        green = Double(converted.greenComponent)
        blue = Double(converted.blueComponent)
        alpha = Double(converted.alphaComponent)
        #else
        red = 1
        green = 1
        blue = 1
        alpha = 1
        #endif
    }
}

#if canImport(UIKit)
import UIKit
#elseif os(macOS)
import AppKit
#endif
