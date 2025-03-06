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

// MARK: - MultiCodeConvertible
public protocol SourceKind: CustomStringConvertible, CaseIterable, Sendable {
}

public protocol MultiCodeConvertible {
    associatedtype Kind where Kind: SourceKind
    var snippetGroupName: String { get }
    func code(for kind: Kind) -> CodeConvertible?
}

