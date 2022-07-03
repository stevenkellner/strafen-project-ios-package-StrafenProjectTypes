//
//  ILatePaymentInterest.swift
//  
//
//  Created by Steven on 03.07.22.
//

import Foundation

/// Late payement interest
public protocol ILatePaymentInterest {

    /// Type of the time period.
    associatedtype TimePeriod: ITimePeriod

    /// Interest free period of the late payment interest.
    var interestFreePeriod: TimePeriod { get }

    /// Interest period of the late payment interest.
    var interestPeriod: TimePeriod { get }

    /// Interest rate of the late payment interest.
    var interestRate: Double { get }

    /// Compound interest of the late payment interest.
    var compoundInterest: Bool { get }
}

extension ILatePaymentInterest {

    /// Converts the protocol to the concrete `LatePaymentInterest` type.
    public var concrete: LatePaymentInterest {
        return LatePaymentInterest(self)
    }
}

/// Contains a value and an unit of `day`, `month`, `year`.
public protocol ITimePeriod {

    /// Type of the unit of the time period
    associatedtype TimePeriodUnit: ITimePeriodUnit

    /// Value of the time period.
    var value: UInt { get }

    /// Unit of the time period.
    var unit: TimePeriodUnit { get }
}

extension ITimePeriod {

    /// Converts the protocol to the concrete `TimePeriod` type.
    public var concrete: TimePeriod {
        return TimePeriod(self)
    }
}

/// Unit of a time period.
public protocol ITimePeriodUnit {

    /// Concrete `TimePeriodUnit` type of this unit.
    var concreteTimePeriodUnit: TimePeriodUnit { get }
}

extension ITimePeriodUnit {

    /// Converts the protocol to the concrete `TimePeriodUnit` type.
    public var concrete: TimePeriodUnit {
        return TimePeriodUnit(self)
    }
}
