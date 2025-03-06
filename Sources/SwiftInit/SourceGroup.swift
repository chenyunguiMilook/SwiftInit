//
//  SourceGroup.swift
//  CoreKit
//
//  Created by chenyungui on 2024/10/10.
//


public struct SourceGroup: CodeConvertible {
    public enum Separator {
        case none
        case newline
    }
    
    public let separator: Separator
    public var sources: [any CodeConvertible]
    
    public init(separator: Separator = .newline, sources: [any CodeConvertible]) {
        self.separator = separator
        self.sources = sources
    }
    
    public init(
        separator: Separator = .newline,
        @CodeBuilder builder: () -> [Optional<any CodeConvertible>]
    ) {
        self.separator = separator
        self.sources = builder().compactMap{ $0 }
    }
    
    public func code(precision: Int) -> String {
        self.sources.map{ $0.code(precision: precision) }
            .joined(separator: separator.value)
    }
}

extension SourceGroup.Separator {
    public var value: String {
        switch self {
        case .none: ""
        case .newline: "\n"
        }
    }
}
