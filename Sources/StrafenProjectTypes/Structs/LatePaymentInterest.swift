//
//  LatePaymentInterest.swift
//  
//
//  Created by Steven on 03.07.22.
//

import Foundation

/// Late payement interest
public struct LatePaymentInterest: ILatePaymentInterest {

    /// Interest free period of the late payment interest.
    public private(set) var interestFreePeriod: TimePeriod

    /// Interest period of the late payment interest.
    public private(set) var interestPeriod: TimePeriod

    /// Interest rate of the late payment interest.
    public private(set) var interestRate: Double

    /// Compound interest of the late payment interest.
    public private(set) var compoundInterest: Bool

    public init(interestFreePeriod: TimePeriod, interestPeriod: TimePeriod, interestRate: Double, compoundInterest: Bool) {
        self.interestFreePeriod = interestFreePeriod
        self.interestPeriod = interestPeriod
        self.interestRate = interestRate
        self.compoundInterest = compoundInterest
    }
}

extension LatePaymentInterest {

    /// Initializes late payment interest with a `ILatePaymentInterest` protocol.
    /// - Parameter latePaymentInterest: `ILatePaymentInterest` protocol to initialize the late payment interest.
    public init(_ latePaymentInterest: some ILatePaymentInterest) {
        self.interestFreePeriod = TimePeriod(latePaymentInterest.interestFreePeriod)
        self.interestPeriod = TimePeriod(latePaymentInterest.interestPeriod)
        self.interestRate = latePaymentInterest.interestRate
        self.compoundInterest = latePaymentInterest.compoundInterest
    }
}

extension LatePaymentInterest: Equatable {}

extension LatePaymentInterest: Decodable {}

extension LatePaymentInterest: Encodable {}

extension LatePaymentInterest: Sendable {}

extension LatePaymentInterest: Hashable {}


/// Contains a value and an unit of `day`, `month`, `year`.
public struct TimePeriod: ITimePeriod {

    /// Value of the time period.
    public private(set) var value: UInt

    /// Unit of the time period.
    public private(set) var unit: TimePeriodUnit

    public init(value: UInt, unit: TimePeriodUnit) {
        self.value = value
        self.unit = unit
    }
}

extension TimePeriod {

    /// Initializes time period with a `ITimePeriod` protocol.
    /// - Parameter timePeriod: `ITimePeriod` protocol to initialize the time period.
    public init(_ timePeriod: some ITimePeriod) {
        self.value = timePeriod.value
        self.unit = TimePeriodUnit(timePeriod.unit)
    }
}

extension TimePeriod: Equatable {}

extension TimePeriod: Decodable {}

extension TimePeriod: Encodable {}

extension TimePeriod: Sendable {}

extension TimePeriod: Hashable {}

/// Unit of a time period.
public enum TimePeriodUnit: ITimePeriodUnit {

    /// Day unit of a time period.
    case day

    /// Month unit of a time period.
    case month

    /// Year unit of a time period.
    case year

    public var concreteTimePeriodUnit: TimePeriodUnit { self }
}

extension TimePeriodUnit {

    /// Initializes time period unit with a `ITimePeriodUnit` protocol.
    /// - Parameter timePeriodUnit: `ITimePeriodUnit` protocol to initialize the time period unit.
    public init(_ timePeriodUnit: some ITimePeriodUnit) {
        self = timePeriodUnit.concreteTimePeriodUnit
    }
}

extension TimePeriodUnit: Equatable {}

extension TimePeriodUnit: Decodable {}

extension TimePeriodUnit: Encodable {}

extension TimePeriodUnit: Sendable {}

extension TimePeriodUnit: Hashable {}
