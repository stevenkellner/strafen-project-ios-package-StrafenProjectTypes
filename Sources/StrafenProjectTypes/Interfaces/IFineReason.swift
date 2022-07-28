//
//  IFineReason.swift
//  
//
//  Created by Steven on 17.06.22.
//

import Foundation

/// Contains a reason of a fine, either with a template id or custom with reason message, amount and importance.
public protocol IFineReason {

    /// Type of the amount of the fine reason.
    associatedtype Amount: IAmount

    /// Type of the importance of the fine reason.
    associatedtype Importance: IImportance

    /// Message of the fine reason.
    var reasonMessage: String { get }

    /// Amount of the fine reason.
    var amount: Amount { get }

    /// Importance of the fine reason.
    var importance: Importance { get }
}

extension IFineReason {

    /// Converts the protocol to the concrete `FineReason` type.
    public var concrete: FineReason {
        return FineReason(self)
    }
}
