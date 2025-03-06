//
//  AttributeGetter.swift
//  CoreKit
//
//  Created by chenyungui on 2024/10/14.
//


public struct AttributeGetter: InlineOperation {
    public var attribute: String
    
    public init(_ attribute: String) {
        self.attribute = attribute
    }
    
    public func code(precision: Int) -> String {
        ".\(self.attribute)"
    }
}

extension AttributeGetter: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public typealias ExtendedGraphemeClusterLiteralType = String
    public typealias UnicodeScalarLiteralType = String
    
    public init(stringLiteral value: String) {
        self.attribute = value
    }
}
