//
//  Reference.swift
//  CoreKit
//
//  Created by chenyungui on 2024/10/13.
//


// convert Source to declartion mode
public final class VarDecl: DeclConvertible {
    public enum Style {
        case normal
        case lazy
        case closure
    }
    
    public var style: Style = .normal
    public let instance: Initializer
    public var dependentVars: [VarDecl] = []
    public let operations: [InstanceOperation]
    
    private var _varName: String?
    public var varName: String {
        _varName ?? instance.varName
    }
    
    public init(_ instance: Initializer) {
        self.instance = instance
        self.operations = []
    }
    
    public init(_ instance: SourceInitable) {
        self.instance = instance.source()
        self.operations = []
    }
    
    public init(
        _ instance: Initializer,
        @InstanceOperationBuilder builder: () -> [InstanceOperation]
    ) {
        self.instance = instance
        self.operations = builder()
    }
    
    public init<T>(
        _ type: T.Type,
        @ParameterBuilder parameters: () -> [Parameter]
    ) {
        self.instance = .object(type, builder: parameters)
        self.operations = []
    }
    
    public init(
        _ type: String,
        @ParameterBuilder parameters: () -> [Parameter]
    ) {
        self.instance = .object(type, builder: parameters)
        self.operations = []
    }
    
    public func setVarName(_ name: String) -> Self {
        self._varName = name
        return self
    }

    public func lazy() -> Self {
        self.style = .lazy
        return self
    }
    
    public func closure() -> Self {
        self.style = .closure
        return self
    }
    
    public func code(precision: Int) -> String {
        switch style {
        case .normal:
            return definitionCode(precision: precision)
        case .lazy:
            return """
            lazy var \(varName): \(instance.typeName) = \(closureDefinition(precision: precision))()
            """
        case .closure:
            return """
            let \(varName): \(instance.typeName) = \(closureDefinition(precision: precision))()
            """
        }
    }
    
    private func closureDefinition(precision: Int) -> String {
        if dependentVars.isEmpty && operations.isEmpty {
            return """
            {
                \(instance.code(precision: precision))
            }
            """
        } else {
            return """
            {
                \(definitionCode(precision: precision))
                return \(varName)
            }
            """
        }
    }
    
    private func definitionCode(precision: Int) -> String {
        let depends = dependentVars.map { v in
            v.code(precision: precision)
        }
        let def = operations.isEmpty ? "let" : "var"
        let definition = "\(def) \(varName) = \(instance.code(precision: precision))"
        
        let exps = operations.map { exp in
            varName + exp.code(precision: precision)
        }
        return (depends + [definition] + exps).joined(separator: "\n")
    }
}
