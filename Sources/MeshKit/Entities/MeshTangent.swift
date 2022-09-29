//
//  MeshTangent.swift
//  
//
//  Created by Ethan Lipnik on 7/29/22.
//

import Foundation
import simd

public struct MeshTangent: Codable, Hashable, Equatable {

    public let u: MeshPoint
    public let v: MeshPoint

    public init(u: MeshPoint = .zero, v: MeshPoint = .zero) {
        self.u = u
        self.v = v
    }
    
    public static var zero: MeshTangent {
        return MeshTangent(u: .zero, v: .zero)
    }

    public static func from(uTangent: simd_float2, vTangent: simd_float2) -> MeshTangent {
        return MeshTangent(u: .from(location: uTangent), v: .from(location: vTangent))
    }
}
