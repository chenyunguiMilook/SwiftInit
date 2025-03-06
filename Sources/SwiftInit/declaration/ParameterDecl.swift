//
//  ParameterDecl.swift
//  CoreKit
//
//  Created by chenyungui on 2024/10/15.
//

public struct ParameterDecl: CodeConvertible {
    public var name: String?
    public var label: String?
    public var type: String
    
    public init(name: String? = nil, label: String? = nil, type: String) {
        assert(name == nil && label == nil, "name and label should not all nil")
        self.name = name
        self.label = label
        self.type = type
    }
    
    public func code(precision: Int) -> String {
        switch (name, label) {
        case (.some(let name), .some(let label)):
            if name == label {
                return "\(name): \(type)"
            } else {
                return "\(name) \(label): \(type)"
            }
        case (.some(let name), _):
            return "\(name): \(type)"
        case (_, .some(let label)):
            return "_ \(label): \(type)"
        default:
            fatalError()
        }
    }
}
