//
//  MeshKit.swift
//  
//
//  Created by Ethan Lipnik on 7/27/22.
//

import Foundation
import MeshGradient
import CoreGraphics
import simd

public actor MeshKit {
    
    public static func mesh(
        of size: MeshSize,
        colors: [SystemColor],
        locationRandomizationRange: ClosedRange<Float> = -0.2...0.2,
        turbulencyRandomizationRange: ClosedRange<Float> = -0.25...0.25
    ) -> Grid<MeshColor> {

        let shouldRandomizeLocations = !locationRandomizationRange.isEmpty

        let meshRandomizer = MeshRandomizer(
            locationRandomizer: MeshRandomizer.randomizeLocationExceptEdges(range: locationRandomizationRange),
            turbulencyRandomizer: MeshRandomizer.randomizeTurbulencyExceptEdges(range: turbulencyRandomizationRange),
            colorRandomizer: MeshRandomizer.pure(colors: colors)
        )

        let preparationGrid = Grid<simd_float3>(
            repeating: .zero,
            width: size.width,
            height: size.height
        )

        var result = MeshGenerator.generate(colorDistribution: preparationGrid)

        // And here we shuffle the grid using randomizer that we created
        for y in stride(from: 0, to: result.width, by: 1) {
            for x in stride(from: 0, to: result.height, by: 1) {
                if shouldRandomizeLocations {
                    meshRandomizer.locationRandomizer(&result[x, y].location, x, y, result.width, result.height)
                    meshRandomizer.turbulencyRandomizer(&result[x, y].uTangent, x, y, result.width, result.height)
                    meshRandomizer.turbulencyRandomizer(&result[x, y].vTangent, x, y, result.width, result.height)
                }
                meshRandomizer.colorRandomizer(&result[x, y].color, result[x, y].color, x, y, result.width, result.height)
            }
        }

        return result.asMeshColor()
    }
}

fileprivate extension MeshRandomizer {

    static func pure(colors: [SystemColor]) -> ColorRandomizer {
        return { color, _, x, y, _, height in
            let index = x + y * height
            color = colors[index].asSimd()
        }
    }
}
