//
//  MeshColor.swift
//  
//
//  Created by Ethan Lipnik on 7/27/22.
//

import Foundation
import CoreGraphics
import RandomColor

public final class MeshColor {

    public let startLocation: MeshPoint
    public let location: MeshPoint
    public let color: SystemColor
    public let tangent: MeshTangent

    public init(
        startLocation: MeshPoint = .zero,
        location: MeshPoint = .zero,
        color: SystemColor = .white,
        tangent: MeshTangent = .zero
    ) {
        self.startLocation = startLocation
        self.location = location
        self.color = color
        self.tangent = tangent
    }

    public func asSimd() -> SIMD3<Float> {
        return color.asSimd()
    }
}

// MARK: Codable

extension MeshColor: Codable {

    private enum CodingKeys: String, CodingKey {
        case startLocation
        case location
        case color
        case tangent
    }

    private struct CodableColor : Codable {

        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat

        var uiColor : SystemColor {
            SystemColor(red: red, green: green, blue: blue, alpha: 1.0)
        }

        init(uiColor : SystemColor) {
            var red: CGFloat = .zero
            var green: CGFloat = .zero
            var blue: CGFloat = .zero
            uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
            self.red = red
            self.green = green
            self.blue = blue
        }
    }

    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let startLocation = try container.decode(MeshPoint.self, forKey: .startLocation)
        let location = try container.decode(MeshPoint.self, forKey: .location)
        let color = try container.decode(CodableColor.self, forKey: .color).uiColor
        let tangent = try container.decode(MeshTangent.self, forKey: .tangent)
        self.init(startLocation: startLocation, location: location, color: color, tangent: tangent)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(startLocation, forKey: .startLocation)
        try container.encode(location, forKey: .location)
        try container.encode(CodableColor(uiColor: color), forKey: .color)
        try container.encode(tangent, forKey: .tangent)
    }
}

// MARK: Equatable

extension MeshColor: Equatable {

    public static func == (lhs: MeshColor, rhs: MeshColor) -> Bool {
        return lhs.location == rhs.location && lhs.color == rhs.color && lhs.tangent == rhs.tangent
    }
}

// MARK: Hashable

extension MeshColor: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(startLocation)
        hasher.combine(location)
        hasher.combine(color)
        hasher.combine(tangent)
    }
}
