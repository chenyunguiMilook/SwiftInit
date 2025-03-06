//
//  Reference.swift
//  CoreKit
//
//  Created by yungui chen on 2024/10/15.
//

public struct ObjectModifier: CodeConvertible {
    
    public var instance: Initializer
    public var modifiers: [MethodCall]
    
    public init(
        _ instance: Initializer,
        @MethodBuilder modifiers: () -> [Optional<MethodCall>]
    ) {
        self.instance = instance
        self.modifiers = modifiers().compactMap{ $0 }
    }
    
    public func code(precision: Int) -> String {
        instance.varName + "\n" + modifiers.map{ $0.code(precision: precision) }.joined(separator: "\n")
    }
}
