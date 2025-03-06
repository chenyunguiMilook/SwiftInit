//
//  SourceRepresentable.swift
//  CoreKit
//
//  Created by yungui chen on 2024/10/12.
//


import Foundation

// all Sourceable need support get inline code
public protocol SourceInitable {
    func source() -> Initializer
}

public protocol CodeConvertible {
    func code(precision: Int) -> String
}

public protocol InstanceOperation: CodeConvertible {
    
}

public protocol InlineOperation: CodeConvertible {
    
}

public protocol DeclConvertible: CodeConvertible {
    
}

//public protocol ShapeDeclConvertible {
//    var bounds: CGRect { get }
//    func uiBezierPathDecl() -> VarDecl
//    func swiftUIPathDecl() -> VarDecl
//    func swiftUIShapeDecl(in bounds: CGRect?) -> VarDecl
//    func applying(_ transform: Matrix2D) -> Self
//}

// MARK: - MultiCodeConvertible
public protocol SourceKind: CustomStringConvertible, CaseIterable, Sendable {
}

public protocol MultiCodeConvertible {
    associatedtype Kind where Kind: SourceKind
    var snippetGroupName: String { get }
    func code(for kind: Kind) -> CodeConvertible?
}

extension MultiCodeConvertible {
    
    public var snippetGroup: SnippetGroup {
        SnippetGroup(name: snippetGroupName, snippets: snippets())
    }
    
    public func snippets() -> [CodeSnippet] {
        snippets(for: Array(Kind.allCases))
    }

    public func snippets(for kinds: [Kind]) -> [CodeSnippet] {
        kinds.compactMap { kind in
            guard let source = self.code(for: kind) else { return nil }
            return CodeSnippet(kind.description, source)
        }
    }
}


