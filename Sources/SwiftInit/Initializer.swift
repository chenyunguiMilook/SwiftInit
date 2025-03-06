//
//  Source.swift
//  CoreKit
//
//  Created by chenyungui on 2024/10/10.
//

// 凡是继承自Source都是可以初始化的对象
public final class Initializer: CodeConvertible {
    public enum Kind {
        case `class`
        case `enum`
        case optionSet
        case staticInstance
        case staticMethod
    }

    public let kind: Kind
    public let typeName: String
    public let varName: String
    public let parameters: [Parameter]
    public var operations: [InlineOperation] = [] // such as UIColor.red.withAlphaComponents(0.3)
    public let options: [String]
    
    public init(
        _ type: String,
        kind: Kind,
        varName: String? = nil,
        parameters: [Parameter],
        operations: [InlineOperation] = [],
        options: [String] = []
    ) {
        self.kind = kind
        self.typeName = type
        self.varName = varName ?? type.variableName()
        self.parameters = parameters
        self.operations = operations
        self.options = options
    }
    
    public init<T>(
        _ type: T.Type,
        kind: Kind,
        parameters: [Parameter],
        operations: [InlineOperation] = [],
        options: [String] = []
    ) {
        let type = String(describing: T.self)
        self.typeName = type
        self.varName = type.variableName()
        self.kind = kind
        self.parameters = parameters
        self.operations = operations
        self.options = options
    }
    
    @discardableResult
    public func join(
        @InlineOperationBuilder builder: () -> [InlineOperation]
    ) -> Self {
        self.operations += builder()
        return self
    }
    
    public func code(precision: Int) -> String {
        let ops = self.operations
            .map{ $0.code(precision: precision) }
            .joined()
        return initString(precision: precision) + ops
    }

    private func initString(precision: Int) -> String {
        switch self.kind {
        case .class:
            return "\(typeName)(\(parameters.code(precision: precision)))"
        case .optionSet:
            let options = self.options.enumerated().map { i, string in
                if i == 0 {
                    "\(typeName).\(string)"
                } else {
                    ".\(string)"
                }
            }
            return "[\(options.joined(separator: ", "))]"
        case .enum:
            return ""
        case .staticInstance, .staticMethod:
            assert(!operations.isEmpty)
            return typeName
        }
    }
}

// MARK: - Class

extension Initializer {
    public static func object<T>(
        _ type: T.Type,
        @ParameterBuilder builder: () -> [Parameter]
    ) -> Initializer {
        Initializer(type, kind: .class, parameters: builder())
    }
    
    public static func object(
        _ type: String,
        @ParameterBuilder builder: () -> [Parameter]
    ) -> Initializer {
        Initializer(type, kind: .class, parameters: builder())
    }
    
    public static func object<T>(
        _ type: T.Type
    ) -> Initializer {
        Initializer(type, kind: .class, parameters: [])
    }
    
    public static func object(
        _ type: String
    ) -> Initializer {
        Initializer(type, kind: .class, parameters: [])
    }
}

extension Initializer {

    public static func `enum`<T>(
        _ type: T.Type,
        case: String
    ) -> Initializer {
        Initializer(type, kind: .enum, parameters: [], operations: [AttributeGetter(`case`)])
    }
    
    public static func `enum`<T>(
        _ type: T.Type,
        case: String,
        @ParameterBuilder builder: () -> [Parameter]
    ) -> Initializer {
        Initializer(type, kind: .enum, parameters: [], operations: [MethodCall(`case`, builder: builder)])
    }
    
    public static func `enum`(
        _ type: String,
        case: String
    ) -> Initializer {
        Initializer(type, kind: .enum, parameters: [], operations: [AttributeGetter(`case`)])
    }
    
    public static func `enum`(
        _ type: String,
        case: String,
        @ParameterBuilder builder: () -> [Parameter]
    ) -> Initializer {
        Initializer(type, kind: .enum, parameters: [], operations: [MethodCall(`case`, builder: builder)])
    }
}

extension Initializer { // for OptionSet
    public static func optionSet<T>(
        _ type: T.Type,
        @StringBuilder builder: () -> [String]
    ) -> Initializer {
        Initializer(type, kind: .optionSet, parameters: [], options: builder())
    }
    
    public static func optionSet(
        _ type: String,
        @StringBuilder builder: () -> [String]
    ) -> Initializer {
        Initializer(type, kind: .optionSet, parameters: [], options: builder())
    }
}

extension Initializer {
    public static func staticVar<T>(
        _ type: T.Type,
        instanceName: String
    ) -> Initializer {
        Initializer(type, kind: .staticInstance, parameters: [], operations: [AttributeGetter(instanceName)])
    }
    
    public static func staticVar(
        _ type: String,
        instanceName: String
    ) -> Initializer {
        Initializer(type, kind: .staticInstance, parameters: [], operations: [AttributeGetter(instanceName)])
    }
}

extension Initializer {
    public static func staticMethod<T>(
        _ type: T.Type,
        methodName: String,
        @ParameterBuilder builder: () -> [Parameter]
    ) -> Initializer {
        Initializer(type, kind: .staticMethod, parameters: [], operations: [MethodCall(methodName, builder: builder)])
    }
    
    public static func staticMethod(
        _ type: String,
        methodName: String,
        @ParameterBuilder builder: () -> [Parameter]
    ) -> Initializer {
        Initializer(type, kind: .staticMethod, parameters: [], operations: [MethodCall(methodName, builder: builder)])
    }
    
    public static func staticMethod<T>(
        _ type: T.Type,
        methodName: String,
        parameters: [Parameter] = []
    ) -> Initializer {
        let method = MethodCall(methodName, parameters: parameters)
        return Initializer(type, kind: .staticMethod, parameters: [], operations: [method])
    }
    
    public static func staticMethod(
        _ type: String,
        methodName: String,
        parameters: [Parameter]
    ) -> Initializer {
        let method = MethodCall(methodName, parameters: parameters)
        return Initializer(type, kind: .staticMethod, parameters: [], operations: [method])
    }
}
