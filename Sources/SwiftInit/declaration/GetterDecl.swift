//
//  GetterDecl.swift
//  CoreKit
//
//  Created by yungui chen on 2024/10/15.
//

public struct GetterDecl: DeclConvertible {
    
    public var name: String
    public var type: String
    public var body: [CodeConvertible]
    
    public init(name: String, type: String, body: [CodeConvertible]) {
        self.name = name
        self.type = type
        self.body = body
    }
    
    public init(
        name: String,
        type: String,
        @CodeBuilder body: () -> [Optional<any CodeConvertible>]
    ) {
        self.name = name
        self.type = type
        self.body = body().compactMap{ $0 }
    }
    
    public func code(precision: Int) -> String {
        """
        var \(name): \(type) {
            \(body.map{ $0.code(precision: precision) }.joined(separator: "\n"))
        }
        """
    }
}

