//
//  VideoSeekRequest.swift
//  Lyriora
//

import Foundation

struct VideoSeekRequest: Equatable, Sendable {
    let id: UUID
    let time: TimeInterval
}
