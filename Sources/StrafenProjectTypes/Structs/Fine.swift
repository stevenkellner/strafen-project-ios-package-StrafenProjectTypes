//
//  Fine.swift
//  
//
//  Created by Steven on 17.06.22.
//

import Foundation

/// Contains all properties of a fine.
public struct Fine: IFine {

    /// Type of the id of the fine.
    public typealias ID = Tagged<(Fine, id: ()), UUID>

    /// Id of the fine.
    public private(set) var id: ID

    /// Associated person id of the fine.
    public private(set) var personId: Person.ID

    /// Payed state of the fine.
    public private(set) var payedState: PayedState

    /// Number of the fine.
    public private(set) var number: UInt

    /// Date of the fine.
    public private(set) var date: Date

    /// Fine reason of the fine.
    public private(set) var fineReason: FineReason

    public init(id: ID, personId: Person.ID, payedState: PayedState, number: UInt, date: Date, fineReason: FineReason) {
        self.id = id
        self.personId = personId
        self.payedState = payedState
        self.number = number
        self.date = date
        self.fineReason = fineReason
    }
}

extension Fine {

    /// Initializes fine with a `IFine` protocol.
    /// - Parameter fine: `IFine` protocol to initialize the fine.
    public init(_ fine: some IFine) {
        self.id = fine.id
        self.personId = fine.personId
        self.payedState = PayedState(fine.payedState)
        self.number = fine.number
        self.date = fine.date
        self.fineReason = FineReason(fine.fineReason)
    }
}

extension Fine: Equatable {}

extension Fine: Decodable {}

extension Fine: Encodable {}

extension Fine: Sendable {}

extension Fine: Hashable {}
