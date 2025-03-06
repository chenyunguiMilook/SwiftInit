//
//  FuncDeclaration.swift
//  CoreKit
//
//  Created by chenyungui on 2024/10/15.
//


public struct FuncDecl: DeclConvertible {
    public enum Kind {
        case normal
        case `init`
        case `static`
    }
    
    public var type: Kind
    public var name: String
    public var parameters: [ParameterDecl]
    public var `return`: String?
    public var body: [CodeConvertible]
    
    public init(
        type: Kind,
        name: String,
        return: String?,
        parameters: [ParameterDecl],
        body: [CodeConvertible]
    ) {
        self.type = type
        self.name = name
        self.parameters = parameters
        self.body = body
    }
    
    public func code(precision: Int) -> String {
        let params = parameters.map{ $0.code(precision: precision) }.joined(separator: ", ")
        let content = body.map{ $0.code(precision: precision) }.joined(separator: "\n")
        var method = "\(name)(\(params))"
        if let `return` {
            method += " -> \(`return`)"
        }
        
        switch type {
        case .normal: return """
            func \(method) {
                \(content)
            }
            """
        case .`init`: return """
            \(method) {
                \(content)
            }
            """
        case .static: return """
            static func \(method) {
                \(content)
            }
            """
        }
    }
}

extension FuncDecl {
    public static func `func`(
        _ name: String,
        return: String? = nil,
        @ParameterDeclBuilder parameters: () -> [ParameterDecl],
        @CodeBuilder body: () -> [Optional<any CodeConvertible>]
    ) -> FuncDecl {
        FuncDecl(
            type: .normal,
            name: name,
            return: `return`,
            parameters: parameters(),
            body: body().compactMap{ $0 }
        )
    }
    
    public static func `init`(
        @ParameterDeclBuilder parameters: () -> [ParameterDecl],
        @CodeBuilder body: () -> [Optional<any CodeConvertible>]
    ) -> Self {
        FuncDecl(
            type: .`init`,
            name: "init",
            return: nil,
            parameters: parameters(),
            body: body().compactMap{ $0 }
        )
    }
    
    public static func staticFunc(
        _ name: String,
        return: String? = nil,
        @ParameterDeclBuilder parameters: () -> [ParameterDecl],
        @CodeBuilder body: () -> [Optional<any CodeConvertible>]
    ) -> FuncDecl {
        FuncDecl(
            type: .static,
            name: name,
            return: `return`,
            parameters: parameters(),
            body: body().compactMap{ $0 }
        )
    }
}
