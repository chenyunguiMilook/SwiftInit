//
//  Assignment.swift
//  CoreKit
//
//  Created by chenyungui on 2024/10/12.
//

public struct AttributeAssignment: InstanceOperation {
    public typealias Value = Parameter.Value
    
    public let attribute: String
    public let value: Value
    
    public init(_ attribute: String, value: Value) {
        self.attribute = attribute
        self.value = value
    }
    
    public init(_ attribute: String, _ object: SourceInitable?) {
        self.attribute = attribute
        self.value = .object(object)
    }
    
    public init(_ attribute: String, _ objects: [SourceInitable]?) {
        self.attribute = attribute
        self.value = .objectArray(objects)
    }
    
    public init(_ attribute: String, _ source: CodeConvertible?) {
        self.attribute = attribute
        self.value = .source(source)
    }
    
    public init(_ attribute: String, _ sources: [CodeConvertible]?) {
        self.attribute = attribute
        self.value = .sourceArray(sources)
    }

    public init(_ attribute: String, _ string: String?, isRaw: Bool = false) {
        self.attribute = attribute
        if isRaw {
            self.value = .rawString(string)
        } else {
            self.value = .string(string)
        }
    }
    
    public init(_ attribute: String, _ strings: [String]?, isRaw: Bool = false) {
        self.attribute = attribute
        if isRaw {
            self.value = .rawStringArray(strings)
        } else {
            self.value = .stringArray(strings)
        }
    }
    
    public init(_ attribute: String, _ number: Double?) {
        self.attribute = attribute
        self.value = .floating(number)
    }
    
    public init(_ attribute: String, _ numbers: [Double]?) {
        self.attribute = attribute
        self.value = .floatingArray(numbers)
    }
    
    public init(_ attribute: String, _ int: Int?) {
        self.attribute = attribute
        self.value = .integer(int)
    }
    
    public init(_ attribute: String, _ ints: [Int]?) {
        self.attribute = attribute
        self.value = .integerArray(ints)
    }

    public init(_ attribute: String, _ bool: Bool?) {
        self.attribute = attribute
        self.value = .boolean(bool)
    }
    
    public init(_ attribute: String, _ bools: [Bool]?) {
        self.attribute = attribute
        self.value = .booleanArray(bools)
    }
    
    public func code(precision: Int) -> String {
        let value = value.code(precision: precision) ?? "nil"
        return ".\(attribute) = \(value)"
    }
}
