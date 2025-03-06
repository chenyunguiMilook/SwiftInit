//
//  Extensions.swift
//  CoreKit
//
//  Created by chenyungui on 2024/10/13.
//
import Foundation

extension Int: CodeConvertible {
    public func code(precision: Int) -> String {
        "\(self)"
    }
}

extension String: CodeConvertible {
    public func code(precision: Int) -> String {
        return "\"\(self)\""
    }
}

extension Bool: CodeConvertible {
    public func code(precision: Int) -> String {
        self ? "true" : "false"
    }
}

extension Double: CodeConvertible {
    public func code(precision: Int) -> String {
        self.toFixed(precision)
    }
}

extension Array: CodeConvertible where Element: CodeConvertible {
    public func code(precision: Int) -> String {
        return "[\(map{ "\($0.code(precision: precision))" }.joined(separator: ", "))]"
    }
}

extension BinaryFloatingPoint {
    fileprivate func toFixed(_ count: Int) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = NumberFormatter.Style.decimal
        nf.maximumFractionDigits = count
        let double = Double(self)
        let number = NSNumber(floatLiteral: double)
        return nf.string(from: number)!
    }
}
