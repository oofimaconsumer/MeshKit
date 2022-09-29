//
//  MeshSize.swift
//  
//
//  Created by Ethan Lipnik on 7/27/22.
//

import Foundation

public struct MeshSize: Codable, Equatable, Hashable {

    public let width: Int
    public let height: Int

    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    public static func square(of size: Int) -> MeshSize {
        return MeshSize(width: size, height: size)
    }

    public static var zero: MeshSize {
        .square(of: .zero)
    }
}
