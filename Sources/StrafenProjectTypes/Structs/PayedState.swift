//
//  PayedState.swift
//  
//
//  Created by Steven on 17.06.22.
//

import Foundation

/// Contains properties if a fine is payed.
public enum PayedState: IPayedState {

    /// Fine is payed.
    case payed(inApp: Bool, payDate: Date)

    /// Fine is unpayed.
    case unpayed

    /// Fine is settled.
    case settled

    public var concretePayedState: PayedState { self }
}

extension PayedState {

    /// Initializes payed state with a `IPayedState` protocol.
    /// - Parameter payedState: `IPayedState` protocol to initialize the payed state.
    public init(_ payedState: some IPayedState) {
        self = payedState.concretePayedState
    }
}

extension PayedState: Equatable {
    public static func == (lhs: PayedState, rhs: PayedState) -> Bool {
        switch (lhs, rhs) {
        case let (.payed(inApp: lhsInApp, payDate: lhsPayDate), .payed(inApp: rhsInApp, payDate: rhsPayDate)):
            return lhsInApp == rhsInApp && Calendar.current.isDate(lhsPayDate, equalTo: rhsPayDate, toGranularity: .nanosecond)
        case (.unpayed, .unpayed):
            return true
        case (.settled, .settled):
            return true
        default:
            return false
        }
    }
}

extension PayedState: Decodable {
    private enum CodingKeys: String, CodingKey {
        case state
        case inApp
        case payDate
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let state = try container.decode(String.self, forKey: .state)
        switch state {
        case "payed":
            self = .payed(
                inApp: try container.decode(Bool.self, forKey: .inApp),
                payDate: try container.decode(Date.self, forKey: .payDate)
            )
        case "unpayed":
            self = .unpayed
        case "settled":
            self = .settled
        default:
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [CodingKeys.state], debugDescription: "Invalid state: \(state)."))
        }
    }
}

extension PayedState: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .payed(inApp: inApp, payDate: payDate):
            try container.encode("payed", forKey: .state)
            try container.encode(inApp, forKey: .inApp)
            try container.encode(payDate, forKey: .payDate)
        case .unpayed:
            try container.encode("unpayed", forKey: .state)
        case .settled:
            try container.encode("settled", forKey: .state)
        }
    }
}

extension PayedState: Sendable {}

extension PayedState: Hashable {}
