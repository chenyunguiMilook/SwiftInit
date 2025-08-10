//
//  ShapeDeclConvertible.swift
//  SwiftInit
//
//  Created by chenyungui on 2025/8/10.
//

import CoreGraphics

public protocol ShapeDeclConvertible {
    var bounds: CGRect { get }
    func uiBezierPathDecl() -> VarDecl
    func swiftUIPathDecl() -> VarDecl
    func swiftUIShapeDecl(in bounds: CGRect?) -> VarDecl
    func applying(_ transform: CGAffineTransform) -> Self
}
