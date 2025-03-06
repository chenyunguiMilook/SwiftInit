//
//  Method.swift
//  CoreKit
//
//  Created by chenyungui on 2024/10/12.
//


public struct MethodCall: InstanceOperation, InlineOperation {
    
    public var name: String
    public var parameters: [Parameter]
    
    public init(_ name: String) {
        self.name = name
        self.parameters = []
    }
    
    public init(_ name: String, parameters: [Parameter] = []) {
        self.name = name
        self.parameters = parameters
    }
    
    public init(_ name: String, @ParameterBuilder builder: () -> [Parameter]) {
        self.name = name
        self.parameters = builder()
    }
    
    public init(_ name: String, _ object: SourceInitable?) {
        self.name = name
        self.parameters = [Parameter(object)]
    }
    
    public init(_ name: String, _ objects: [SourceInitable]?) {
        self.name = name
        self.parameters = [Parameter(objects)]
    }
    
    public init(_ name: String, _ source: CodeConvertible?) {
        self.name = name
        self.parameters = [Parameter(source)]
    }
    
    public init(_ name: String, _ sources: [CodeConvertible]?) {
        self.name = name
        self.parameters = [Parameter(sources)]
    }

    public init(_ name: String, _ string: String?, isRaw: Bool = false) {
        self.name = name
        self.parameters = [Parameter(string, isRaw: isRaw)]
    }
    
    public init(_ name: String, _ strings: [String]?, isRaw: Bool = false) {
        self.name = name
        self.parameters = [Parameter(strings, isRaw: isRaw)]
    }
    
    public init(_ name: String, _ number: Double?) {
        self.name = name
        self.parameters = [Parameter(number)]
    }
    
    public init(_ name: String, _ numbers: [Double]?) {
        self.name = name
        self.parameters = [Parameter(numbers)]
    }
    
    public init(_ name: String, _ int: Int?) {
        self.name = name
        self.parameters = [Parameter(int)]
    }
    
    public init(_ name: String, _ ints: [Int]?) {
        self.name = name
        self.parameters = [Parameter(ints)]
    }

    public init(_ name: String, _ bool: Bool?) {
        self.name = name
        self.parameters = [Parameter(bool)]
    }
    
    public init(_ name: String, _ bools: [Bool]?) {
        self.name = name
        self.parameters = [Parameter(bools)]
    }
    
    public func code(precision: Int) -> String {
        if parameters.isEmpty {
            ".\(name)()"
        } else {
            ".\(name)(\(parameters.code(precision: precision)))"
        }
    }
}
