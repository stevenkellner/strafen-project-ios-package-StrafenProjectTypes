//
//  Tagged.swift
//  
//
//  Created by Steven on 17.06.22.
//

import Foundation

/// Tagged value type.
@dynamicMemberLookup
public struct Tagged<Tag, RawValue> {

    /// Raw value ot the tag.
    public var rawValue: RawValue

    /// Initializes tagged with raw value.
    /// - Parameter rawValue: Raw value ot the tag.
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }

    /// Initializes tagged with raw value.
    /// - Parameter rawValue: Raw value ot the tag.
    public init?(rawValue: RawValue?) {
        guard let rawValue else { return nil }
        self.init(rawValue: rawValue)
    }

    /// Mappes the raw value with specified transform closure.
    /// - Parameter transform: Transform closure to map the raw value.
    /// - Returns: Tag with mapped raw value.
    public func map<B>(_ transform: (RawValue) -> B) -> Tagged<Tag, B> {
        return .init(rawValue: transform(self.rawValue))
    }
}

extension Tagged {

    /// Subscript for dynaimc member lookup
    public subscript<T>(dynamicMember keyPath: KeyPath<RawValue, T>) -> T {
        return self.rawValue[keyPath: keyPath]
    }
}

extension Tagged: CustomStringConvertible {
    public var description: String {
        return String(describing: self.rawValue)
    }
}

extension Tagged: RawRepresentable {}

extension Tagged: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        return self.rawValue
    }
}

// MARK: - Conditional Conformances

extension Tagged: Collection where RawValue: Collection {
    public typealias Element = RawValue.Element
    public typealias Index = RawValue.Index

    public func index(after i: RawValue.Index) -> RawValue.Index {
        return rawValue.index(after: i)
    }

    public subscript(position: RawValue.Index) -> RawValue.Element {
        return rawValue[position]
    }

    public var startIndex: RawValue.Index {
        return rawValue.startIndex
    }

    public var endIndex: RawValue.Index {
        return rawValue.endIndex
    }

    public __consuming func makeIterator() -> RawValue.Iterator {
        return rawValue.makeIterator()
    }
}

extension Tagged: Comparable where RawValue: Comparable {
    public static func < (lhs: Tagged, rhs: Tagged) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension Tagged: Decodable where RawValue: Decodable {
    public init(from decoder: Decoder) throws {
        do {
            self.init(rawValue: try decoder.singleValueContainer().decode(RawValue.self))
        } catch {
            self.init(rawValue: try RawValue(from: decoder))
        }
    }
}

extension Tagged: Encodable where RawValue: Encodable {
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.singleValueContainer()
            try container.encode(self.rawValue)
        } catch {
            try self.rawValue.encode(to: encoder)
        }
    }
}

extension Tagged: Equatable where RawValue: Equatable {}

extension Tagged: Error where RawValue: Error {}

extension Tagged: Sendable where RawValue: Sendable {}

extension Tagged: LocalizedError where RawValue: Error {
    public var errorDescription: String? {
        return rawValue.localizedDescription
    }
    public var failureReason: String? {
        return (rawValue as? LocalizedError)?.failureReason
    }
    public var helpAnchor: String? {
        return (rawValue as? LocalizedError)?.helpAnchor
    }
    public var recoverySuggestion: String? {
        return (rawValue as? LocalizedError)?.recoverySuggestion
    }
}

extension Tagged: ExpressibleByBooleanLiteral where RawValue: ExpressibleByBooleanLiteral {
    public typealias BooleanLiteralType = RawValue.BooleanLiteralType

    public init(booleanLiteral value: RawValue.BooleanLiteralType) {
        self.init(rawValue: RawValue(booleanLiteral: value))
    }
}

extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {
    public typealias ExtendedGraphemeClusterLiteralType = RawValue.ExtendedGraphemeClusterLiteralType

    public init(extendedGraphemeClusterLiteral: ExtendedGraphemeClusterLiteralType) {
        self.init(rawValue: RawValue(extendedGraphemeClusterLiteral: extendedGraphemeClusterLiteral))
    }
}

extension Tagged: ExpressibleByFloatLiteral where RawValue: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = RawValue.FloatLiteralType

    public init(floatLiteral: FloatLiteralType) {
        self.init(rawValue: RawValue(floatLiteral: floatLiteral))
    }
}

extension Tagged: ExpressibleByIntegerLiteral where RawValue: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = RawValue.IntegerLiteralType

    public init(integerLiteral: IntegerLiteralType) {
        self.init(rawValue: RawValue(integerLiteral: integerLiteral))
    }
}

extension Tagged: ExpressibleByStringLiteral where RawValue: ExpressibleByStringLiteral {
    public typealias StringLiteralType = RawValue.StringLiteralType

    public init(stringLiteral: StringLiteralType) {
        self.init(rawValue: RawValue(stringLiteral: stringLiteral))
    }
}

extension Tagged: ExpressibleByStringInterpolation where RawValue: ExpressibleByStringInterpolation {
    public typealias StringInterpolation = RawValue.StringInterpolation

    public init(stringInterpolation: Self.StringInterpolation) {
        self.init(rawValue: RawValue(stringInterpolation: stringInterpolation))
    }
}

extension Tagged: ExpressibleByUnicodeScalarLiteral where RawValue: ExpressibleByUnicodeScalarLiteral {
    public typealias UnicodeScalarLiteralType = RawValue.UnicodeScalarLiteralType

    public init(unicodeScalarLiteral: UnicodeScalarLiteralType) {
        self.init(rawValue: RawValue(unicodeScalarLiteral: unicodeScalarLiteral))
    }
}

extension Tagged: Identifiable where RawValue: Identifiable {
    public typealias ID = RawValue.ID

    public var id: ID {
        return rawValue.id
    }
}

extension Tagged: LosslessStringConvertible where RawValue: LosslessStringConvertible {
    public init?(_ description: String) {
        guard let rawValue = RawValue(description) else { return nil }
        self.init(rawValue: rawValue)
    }
}

extension Tagged: AdditiveArithmetic where RawValue: AdditiveArithmetic {
    public static var zero: Tagged {
        return self.init(rawValue: .zero)
    }

    public static func + (lhs: Tagged, rhs: Tagged) -> Tagged {
        return self.init(rawValue: lhs.rawValue + rhs.rawValue)
    }

    public static func += (lhs: inout Tagged, rhs: Tagged) {
        lhs.rawValue += rhs.rawValue
    }

    public static func - (lhs: Tagged, rhs: Tagged) -> Tagged {
        return self.init(rawValue: lhs.rawValue - rhs.rawValue)
    }

    public static func -= (lhs: inout Tagged, rhs: Tagged) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Tagged: Numeric where RawValue: Numeric {
    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard let rawValue = RawValue(exactly: source) else { return nil }
        self.init(rawValue: rawValue)
    }

    public var magnitude: RawValue.Magnitude {
        return self.rawValue.magnitude
    }

    public static func * (lhs: Tagged, rhs: Tagged) -> Tagged {
        return self.init(rawValue: lhs.rawValue * rhs.rawValue)
    }

    public static func *= (lhs: inout Tagged, rhs: Tagged) {
        lhs.rawValue *= rhs.rawValue
    }
}

extension Tagged: Hashable where RawValue: Hashable {}

extension Tagged: SignedNumeric where RawValue: SignedNumeric {}

extension Tagged: Sequence where RawValue: Sequence {
    public typealias Iterator = RawValue.Iterator

    public __consuming func makeIterator() -> RawValue.Iterator {
        return rawValue.makeIterator()
    }
}

extension Tagged: Strideable where RawValue: Strideable {
    public typealias Stride = RawValue.Stride

    public func distance(to other: Tagged<Tag, RawValue>) -> RawValue.Stride {
        self.rawValue.distance(to: other.rawValue)
    }

    public func advanced(by n: RawValue.Stride) -> Tagged<Tag, RawValue> { // swiftlint:disable:this identifier_name
        Tagged(rawValue: self.rawValue.advanced(by: n))
    }
}

extension Tagged: ExpressibleByArrayLiteral where RawValue: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = RawValue.ArrayLiteralElement

    public init(arrayLiteral elements: ArrayLiteralElement...) {
        let transform = unsafeBitCast(
            RawValue.init(arrayLiteral:) as (ArrayLiteralElement...) -> RawValue,
            to: (([ArrayLiteralElement]) -> RawValue).self
        )

        self.init(rawValue: transform(elements))
    }
}

extension Tagged: ExpressibleByDictionaryLiteral where RawValue: ExpressibleByDictionaryLiteral {
    public typealias Key = RawValue.Key
    public typealias Value = RawValue.Value

    public init(dictionaryLiteral elements: (Key, Value)...) {
        let transform = unsafeBitCast(
            RawValue.init(dictionaryLiteral:) as ((Key, Value)...) -> RawValue,
            to: (([(Key, Value)]) -> RawValue).self
        )

        self.init(rawValue: transform(elements))
    }
}
