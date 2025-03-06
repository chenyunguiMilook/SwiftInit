//
//  Parameter.swift
//  CoreKit
//
//  Created by yungui chen on 2024/10/9.
//
import Foundation

public struct Parameter {
    public enum Value {
        case object(SourceInitable?)
        case objectArray([SourceInitable]?)
        case source(CodeConvertible?)
        case sourceArray([CodeConvertible]?)
        case string(String?) // will add ""
        case stringArray([String]?)
        case rawString(String?) // will not add "
        case rawStringArray([String]?)
        case floating(Double?)
        case floatingArray([Double]?)
        case integer(Int?)
        case integerArray([Int]?)
        case boolean(Bool?)
        case booleanArray([Bool]?)
    }
    
    public var label: String?
    public var value: Value?
    
    // MARK: - label only
    public init(label: String) {
        self.label = label
        self.value = nil
    }
    
    // MARK: - with label
    public init(_ label: String?, _ object: SourceInitable?) {
        self.label = label
        self.value = .object(object)
    }
    
    public init(_ label: String?, _ objects: [SourceInitable]?) {
        self.label = label
        self.value = .objectArray(objects)
    }
    
    public init(_ label: String?, _ source: CodeConvertible?) {
        self.label = label
        self.value = .source(source)
    }
    
    public init(_ label: String?, _ sources: [CodeConvertible]?) {
        self.label = label
        self.value = .sourceArray(sources)
    }

    public init(_ label: String?, _ string: String?, isRaw: Bool = false) {
        self.label = label
        self.value = isRaw ? .rawString(string) : .string(string)
    }
    
    public init(_ label: String?, _ strings: [String]?, isRaw: Bool = false) {
        self.label = label
        self.value = isRaw ? .rawStringArray(strings) : .stringArray(strings)
    }
    
    public init(_ label: String?, _ number: Double?) {
        self.label = label
        self.value = .floating(number)
    }
    
    public init(_ label: String?, _ numbers: [Double]?) {
        self.label = label
        self.value = .floatingArray(numbers)
    }
    
    public init(_ label: String?, _ number: CGFloat?) {
        self.label = label
        if let number {
            self.value = .floating(CGFloat(number))
        }
    }
    
    public init(_ label: String?, _ numbers: [CGFloat]?) {
        self.label = label
        if let numbers {
            self.value = .floatingArray(numbers.map{ Double($0) })
        }
    }
    
    public init(_ label: String?, _ int: Int?) {
        self.label = label
        self.value = .integer(int)
    }
    
    public init(_ label: String?, _ ints: [Int]?) {
        self.label = label
        self.value = .integerArray(ints)
    }

    public init(_ label: String?, _ bool: Bool?) {
        self.label = label
        self.value = .boolean(bool)
    }
    
    public init(_ label: String?, _ bools: [Bool]?) {
        self.label = label
        self.value = .booleanArray(bools)
    }

    // MARK: - without label
    public init(_ object: SourceInitable?) {
        self.value = .object(object)
    }
    
    public init(_ objects: [SourceInitable]?) {
        self.value = .objectArray(objects)
    }
    
    public init(_ source: CodeConvertible?) {
        self.value = .source(source)
    }
    
    public init(_ sources: [CodeConvertible]?) {
        self.value = .sourceArray(sources)
    }

    public init(_ string: String?, isRaw: Bool = false) {
        self.value = isRaw ? .rawString(string) : .string(string)
    }
    
    public init(_ strings: [String]?, isRaw: Bool = false) {
        self.value = isRaw ? .rawStringArray(strings) : .stringArray(strings)
    }
    
    public init(_ number: Double?) {
        self.value = .floating(number)
    }
    
    public init(_ numbers: [Double]?) {
        self.value = .floatingArray(numbers)
    }
    
    public init(_ int: Int?) {
        self.value = .integer(int)
    }
    
    public init(_ ints: [Int]?) {
        self.value = .integerArray(ints)
    }

    public init(_ bool: Bool?) {
        self.value = .boolean(bool)
    }
    
    public init(_ bools: [Bool]?) {
        self.value = .booleanArray(bools)
    }
    
    public func code(precision: Int) -> String {
        var result: String = ""
        if let label {
            result += label + ": "
        }
        if let value = self.value?.code(precision: precision) {
            result += value
        } else {
            result += "nil"
        }
        return result
    }
}

extension Parameter.Value {
    
    public func code(precision: Int) -> String? {
        switch self {
        case .object(let object):
            guard let object else { return nil }
            return object.source().code(precision: precision)
        case .objectArray(let objects):
            guard let objects else { return nil }
            return "[\(objects.map{ $0.source().code(precision: precision) }.joined(separator: ", "))]"
        case .source(let object):
            guard let object else { return nil }
            return object.code(precision: precision)
        case .sourceArray(let objects):
            guard let objects else { return nil }
            return "[\(objects.map{ $0.code(precision: precision) }.joined(separator: ", "))]"
        case .integer(let value):
            guard let value else { return nil }
            return "\(value)"
        case .integerArray(let array):
            return array?.code(precision: precision)
        case .floating(let value):
            return value?.code(precision: precision)
        case .floatingArray(let array):
            return array?.code(precision: precision)
        case .string(let value):
            return value?.code(precision: precision)
        case .stringArray(let array):
            return array?.code(precision: precision)
        case .rawString(let value):
            return value
        case .rawStringArray(let array):
            guard let array else { return nil }
            return "[\(array.map{ $0 }.joined(separator: ", "))]"
        case .boolean(let value):
            return value?.code(precision: precision)
        case .booleanArray(let array):
            return array?.code(precision: precision)
        }
    }
}

extension Array where Element == Parameter {
    
    public func code(precision: Int) -> String {
        self.map{ $0.code(precision: precision) }
            .joined(separator: ", ")
    }
}
