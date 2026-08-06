//
//  PresentationFontFamily.swift
//  Lyriora
//

import SwiftUI

enum PresentationFontFamily: String, Codable, CaseIterable, Identifiable, Sendable {
    case systemRounded
    case systemDefault
    case systemSerif
    case arial
    case avenirNext
    case helveticaNeue
    case georgia
    case futura
    case courierNew

    var id: String { rawValue }

    var label: String {
        switch self {
        case .systemRounded: "SF Rounded"
        case .systemDefault: "SF Pro"
        case .systemSerif: "New York"
        case .arial: "Arial"
        case .avenirNext: "Avenir Next"
        case .helveticaNeue: "Helvetica Neue"
        case .georgia: "Georgia"
        case .futura: "Futura"
        case .courierNew: "Courier New"
        }
    }

    var usesSystemDesign: Bool {
        switch self {
        case .systemRounded, .systemDefault, .systemSerif:
            true
        default:
            false
        }
    }

    var systemDesign: Font.Design {
        switch self {
        case .systemRounded: .rounded
        case .systemSerif: .serif
        case .systemDefault: .default
        default: .default
        }
    }

    func font(size: CGFloat, weight: PresentationFontWeight) -> Font {
        if usesSystemDesign {
            return .system(size: size, weight: weight.swiftUIWeight, design: systemDesign)
        }
        let name = postScriptName(for: weight)
        return .custom(name, size: size)
    }

    func postScriptName(for weight: PresentationFontWeight) -> String {
        switch self {
        case .systemRounded, .systemDefault, .systemSerif:
            return label
        case .arial:
            switch weight {
            case .regular: return "ArialMT"
            case .medium, .semibold: return "Arial-BoldMT"
            case .bold: return "Arial-BoldMT"
            }
        case .avenirNext:
            switch weight {
            case .regular: return "AvenirNext-Regular"
            case .medium: return "AvenirNext-Medium"
            case .semibold: return "AvenirNext-DemiBold"
            case .bold: return "AvenirNext-Bold"
            }
        case .helveticaNeue:
            switch weight {
            case .regular: return "HelveticaNeue"
            case .medium: return "HelveticaNeue-Medium"
            case .semibold: return "HelveticaNeue-Medium"
            case .bold: return "HelveticaNeue-Bold"
            }
        case .georgia:
            switch weight {
            case .regular: return "Georgia"
            case .medium, .semibold: return "Georgia-Bold"
            case .bold: return "Georgia-Bold"
            }
        case .futura:
            switch weight {
            case .regular: return "Futura-Medium"
            case .medium, .semibold: return "Futura-Medium"
            case .bold: return "Futura-Bold"
            }
        case .courierNew:
            switch weight {
            case .regular: return "CourierNewPSMT"
            case .medium, .semibold, .bold: return "Courier-Bold"
            }
        }
    }

    init(fromLegacyDesign design: PresentationFontDesign) {
        switch design {
        case .default: self = .systemDefault
        case .rounded: self = .systemRounded
        case .serif: self = .systemSerif
        case .monospaced: self = .courierNew
        }
    }
}

#if canImport(UIKit)
import UIKit

extension PresentationFontFamily {
    func uiFont(size: CGFloat, weight: PresentationFontWeight) -> UIFont {
        if usesSystemDesign {
            return UIFont.systemFont(ofSize: size, weight: weight.uiWeight)
        }
        return UIFont(name: postScriptName(for: weight), size: size)
            ?? UIFont.systemFont(ofSize: size, weight: weight.uiWeight)
    }
}
#elseif os(macOS)
import AppKit

extension PresentationFontFamily {
    func nsFont(size: CGFloat, weight: PresentationFontWeight) -> NSFont {
        if usesSystemDesign {
            return NSFont.systemFont(ofSize: size, weight: weight.nsWeight)
        }
        return NSFont(name: postScriptName(for: weight), size: size)
            ?? NSFont.systemFont(ofSize: size, weight: weight.nsWeight)
    }
}
#endif
