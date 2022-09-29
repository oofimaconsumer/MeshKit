//
//  Grid+Extensions.swift
//  
//
//  Created by Ethan Lipnik on 8/18/22.
//

import Foundation
import MeshGradient
import simd

public extension Grid where Element == ControlPoint {

    func asMeshColor() -> Grid<MeshColor> {
        var grid = Grid<MeshColor>(repeating: .init(), width: width, height: height)
        grid.elements = {
            var colors: ContiguousArray<MeshColor> = []
            for y in stride(from: 0, to: width, by: 1) {
                for x in stride(from: 0, to: height, by: 1) {
                    let point = self[x, y]
                    let location: MeshPoint = .from(location: point.location)
                    let color = MeshColor(
                        startLocation: location,
                        location: location,
                        color: .from(value: point.color),
                        tangent: .from(uTangent: point.uTangent, vTangent: point.vTangent)
                    )
                    colors.append(color)
                }
            }

            return colors
        }()

        return grid
    }
}

public extension Grid where Element == MeshColor {

    func asControlPoint() -> Grid<ControlPoint> {
        var grid = Grid<ControlPoint>(repeating: .zero, width: width, height: height)
        grid.elements = {
            var controlPoints: ContiguousArray<ControlPoint> = []
            for y in stride(from: 0, to: width, by: 1) {
                for x in stride(from: 0, to: height, by: 1) {
                    let color = self[x, y]
                    controlPoints.append(
                        ControlPoint(
                            color: color.asSimd(),
                            location: simd_float2(color.location.x, color.location.y),
                            uTangent: simd_float2(color.tangent.u.x, color.tangent.u.y),
                            vTangent: simd_float2(color.tangent.v.x, color.tangent.v.y)
                        )
                    )
                }
            }

            return controlPoints
        }()

        return grid
    }

    func isEdge(x: Int, y: Int) -> Bool {
        return !(x != 0 && x != width - 1 && y != 0 && y != height - 1)
    }
}
