//
//  FineReason.swift
//  
//
//  Created by Steven on 17.06.22.
//

import Foundation

/// Contains a reason of a fine, either with a template id or custom with reason message, amount and importance.
public struct FineReason: IFineReason {

    /// Message of the fine reason.
    public private(set) var reasonMessage: String

    /// Amount of the fine reason.
    public private(set) var amount: Amount

    /// Importance of the fine reason.
    public private(set) var importance: Importance

    public init(reasonMessage: String, amount: Amount, importance: Importance) {
        self.reasonMessage = reasonMessage
        self.amount = amount
        self.importance = importance
    }
}

extension FineReason {

    /// Initializes fine reason with a `IFineReason` protocol.
    /// - Parameter fineReason: `IFineReason` protocol to initialize the fine reason.
    public init(_ fineReason: some IFineReason) {
        self.reasonMessage = fineReason.reasonMessage
        self.amount = Amount(fineReason.amount)
        self.importance = Importance(fineReason.importance)
    }
}

extension FineReason: Equatable {}

extension FineReason: Decodable {}

extension FineReason: Encodable {}

extension FineReason: Sendable {}

extension FineReason: Hashable {}
