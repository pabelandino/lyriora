//
//  VideoProgressReporter.swift
//  Lyriora
//

import Foundation

final class VideoProgressReporter {
    var handler: ((TimeInterval, TimeInterval) -> Void)?
}
