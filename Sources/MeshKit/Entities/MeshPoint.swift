//
//  MeshPoint.swift
//  
//
//  Created by Ethan Lipnik on 7/29/22.
//

import Foundation
import simd

public struct MeshPoint: Codable, Hashable, Equatable {

    public let x: Float
    public let y: Float

    public init(x: Float = .zero, y: Float = .zero) {
        self.x = x
        self.y = y
    }
    
    public static let zero = MeshPoint()

    public static func from(location: simd_float2) -> MeshPoint {
        return MeshPoint(x: location.x, y: location.y)
    }
}
