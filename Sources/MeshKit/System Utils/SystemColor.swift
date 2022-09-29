//
//  SystemColor.swift
//  
//
//  Created by Ethan Lipnik on 7/27/22.
//

import Foundation
import simd

#if canImport(UIKit)
import UIKit
public typealias SystemColor = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias SystemColor = NSColor
#endif

public extension SystemColor {

    static func from(value: simd_float3) -> SystemColor {
        return SystemColor(
            red: CGFloat(value.x),
            green: CGFloat(value.y),
            blue: CGFloat(value.z),
            alpha: 1.0
        )
    }

    func asSimd() -> SIMD3<Float> {
        #if canImport(AppKit)
        guard let convertedColor = self.usingColorSpace(.sRGB) else {
            return .zero
        }
        return simd_float3(Float(convertedColor.redComponent), Float(convertedColor.greenComponent), Float(convertedColor.blueComponent))
        #elseif canImport(UIKit)
        var red: CGFloat = .zero
        var green: CGFloat = .zero
        var blue: CGFloat = .zero
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return SIMD3<Float>(Float(red), Float(green), Float(blue))
        #endif
    }
}
