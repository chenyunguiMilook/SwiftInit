//
//  ClassDecl.swift
//  CoreKit
//
//  Created by yungui chen on 2024/10/15.
//

public struct ClassDecl: CodeConvertible {
    
    public enum Kind: String {
        case `class` = "class"
        case `struct` = "struct"
    }
    
    public let comments: String?
    public let kind: Kind
    public let type: String
    public let superTypes: String?
    public let decls: [DeclConvertible]
    
    public init(kind: Kind, type: String, superTypes: String?, comments: String? = nil, decls: [DeclConvertible]) {
        self.comments = comments
        self.kind = kind
        self.type = type
        self.superTypes = superTypes
        self.decls = decls
    }
    
    public func code(precision: Int) -> String {
        var def = "\(kind.rawValue) \(type)"
        if let superTypes {
            def += ": \(superTypes)"
        }
        let body = """
        \(def) {
            \(decls.map{ $0.code(precision: precision) }.joined(separator: "\n"))
        }
        """
        if let comments {
            return """
            // \(comments)
            \(body)
            """
        } else {
            return body
        }
    }
}

extension ClassDecl {
    public static func `class`(
        _ type: String,
        superTypes: String? = nil,
        comments: String? = nil,
        @DeclBuilder declarations: () -> [DeclConvertible]
    ) -> Self {
        Self.init(
            kind: .class,
            type: type,
            superTypes: superTypes,
            comments: comments,
            decls: declarations()
        )
    }
    
    public static func `struct`(
        _ type: String,
        superTypes: String? = nil,
        comments: String? = nil,
        @DeclBuilder declarations: () -> [DeclConvertible]
    ) -> Self {
        Self.init(
            kind: .struct,
            type: type,
            superTypes: superTypes,
            comments: comments,
            decls: declarations()
        )
    }
}
