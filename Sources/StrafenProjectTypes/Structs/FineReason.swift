//
//  FineReason.swift
//  
//
//  Created by Steven on 17.06.22.
//

import Foundation

/// Contains a reason of a fine, either with a template id or custom with reason message, amount and importance.
public enum FineReason: IFineReason {
    
    /// Fine reason with template id.
    case template(reasonTemplateId: ReasonTemplate.ID)
    
    /// Custom fine reason with reason message, amount and importance.
    case custom(reasonMessage: String, amount: Amount, importance: Importance)

    public var concreteFineReason: FineReason { self }
}

extension FineReason {
    
    /// Initializes fine reason with a `IFineReason` protocol.
    /// - Parameter fineReason: `IFineReason` protocol to initialize the fine reason.
    public init(_ fineReason: some IFineReason) {
        self = fineReason.concreteFineReason
    }
}

extension FineReason: Equatable {
    public static func ==(lhs: FineReason, rhs: FineReason) -> Bool {
        switch (lhs, rhs) {
        case (
                .template(reasonTemplateId: let lhsReasonTemplateId),
                .template(reasonTemplateId: let rhsReasonTemplateId)
            ):
            return lhsReasonTemplateId == rhsReasonTemplateId
        case (
                .custom(reasonMessage: let lhsReasonMessage, amount: let lhsAmount, importance: let lhsImportance),
                .custom(reasonMessage: let rhsReasonMessage, amount: let rhsAmount, importance: let rhsImportance)
            ):
            return lhsReasonMessage == rhsReasonMessage && lhsAmount == rhsAmount && lhsImportance == rhsImportance
        default:
            return false
        }
    }
}

extension FineReason: Decodable {
    private enum CodingKeys: String, CodingKey {
        case reasonTemplateId
        case reasonMessage
        case amount
        case importance
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let reasonTemplateId = try? container.decode(ReasonTemplate.ID.self, forKey: .reasonTemplateId) {
            self = .template(reasonTemplateId: reasonTemplateId)
        } else {
            self = .custom(
                reasonMessage: try container.decode(String.self, forKey: .reasonMessage),
                amount: try container.decode(Amount.self, forKey: .amount),
                importance: try container.decode(Importance.self, forKey: .importance)
            )
        }
    }
}

extension FineReason: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .template(reasonTemplateId: let reasonTemplateId):
            try container.encode(reasonTemplateId, forKey: .reasonTemplateId)
        case .custom(reasonMessage: let reasonMessage, amount: let amount, importance: let importance):
            try container.encode(reasonMessage, forKey: .reasonMessage)
            try container.encode(amount, forKey: .amount)
            try container.encode(importance, forKey: .importance)
        }
    }
}

extension FineReason: Sendable {}

extension FineReason: Hashable {}
