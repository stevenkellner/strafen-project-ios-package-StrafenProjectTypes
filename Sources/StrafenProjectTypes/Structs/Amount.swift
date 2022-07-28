//
//  Amount.swift
//  
//
//  Created by Steven on 17.06.22.
//

import Foundation

/// Contains an amount value with subunit value.
public struct Amount: IAmount {

    /// Value of the amount.
    public private(set) var value: UInt

    /// Subunit value of the amount.
    @Clamping(0...99) public private(set) var subUnitValue: UInt = .zero

    public init(value: UInt, subUnitValue: UInt) {
        self.value = value
        self.subUnitValue = subUnitValue
    }
}

extension Amount {

    /// Initializes amount with a `IAmount` protocol.
    /// - Parameter amount: `IAmount` protocol to initialize the amount.
    public init(_ amount: some IAmount) {
        self.value = amount.value
        self.subUnitValue = amount.subUnitValue
    }
}

extension Amount: Equatable {
    public static func == (lhs: Amount, rhs: Amount) -> Bool {
        return lhs.value == rhs.value && lhs.subUnitValue == rhs.subUnitValue
    }
}

extension Amount: Comparable {
    public static func < (lhs: Amount, rhs: Amount) -> Bool {
        if lhs.value == rhs.value {
            return lhs.subUnitValue < rhs.subUnitValue
        }
        return lhs.value < rhs.value
    }
}

extension Amount: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawAmount = try container.decode(Double.self)

        guard rawAmount >= 0 else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Amount is negative.")
        }

        self.value = UInt(rawAmount)
        self.subUnitValue = UInt(rawAmount * 100) - self.value * 100
    }
}

extension Amount: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(Double(self.value) + Double(self.subUnitValue) / 100)
    }
}

extension Amount: Sendable {}

extension Amount: Hashable {}
