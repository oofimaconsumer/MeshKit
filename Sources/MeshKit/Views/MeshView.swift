//
//  MeshView.swift
//  
//
//  Created by Ethan Lipnik on 7/28/22.
//

import Foundation
import MeshGradient
import MetalKit

public extension MeshView {

     init(
        colors: Grid<MeshColor>,
        animatorConfiguration: MeshAnimator.Configuration,
        grainAlpha: Float = .zero,
        subdivisions: Int,
        colorSpace: CGColorSpace? = nil
    ) {
        self.init(
            initialGrid: colors.asControlPoint(),
            animatorConfiguration: animatorConfiguration,
            grainAlpha: grainAlpha,
            subdivisions: subdivisions,
            colorSpace: colorSpace
        )
    }

    init(
        colors: Grid<MeshColor>,
        grainAlpha: Float = .zero,
        subdivisions: Int,
        colorSpace: CGColorSpace? = nil
    ) {
        self.init(
            grid: colors.asControlPoint(),
            grainAlpha: grainAlpha,
            subdivisions: subdivisions,
            colorSpace: colorSpace
        )
    }
}

extension MTKView {
    public func export() -> CIImage? {
        guard let texture = self.currentDrawable?.texture else { return nil }
        return CIImage(mtlTexture: texture)
    }
}
