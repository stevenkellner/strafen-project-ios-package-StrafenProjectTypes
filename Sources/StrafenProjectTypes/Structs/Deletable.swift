//
//  Deletable.swift
//  
//
//  Created by Steven on 06.07.22.
//

import Foundation

/// Deleted database item or underlying database item
public enum Deletable<T>: IDeletable where T: Identifiable {

    /// Underlying database item.
    case item(value: T)

    /// Deleted database item.
    case deleted(with: T.ID)

    public var concreteDeletable: Deletable<T> { self }
}

extension Deletable {

    /// Initializes deletable with a `IDeletable` protocol.
    /// - Parameter deletable: `IDeletable` protocol to initialize the deletable.
    public init(_ deletable: some IDeletable<T>) {
        self = deletable.concreteDeletable
    }
}

extension Deletable: Equatable where T: Equatable {}

extension Deletable: Decodable where T: Decodable, T.ID: Decodable {
    private enum DecodingKeys: String, CodingKey {
        case id
        case deleted
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)

        // Check if it is deleted
        if try container.decode(Bool.self, forKey: .deleted) {
            let id = try container.decode(T.ID.self, forKey: .id)
            self = .deleted(with: id)
        } else {
            let value = try T(from: decoder)
            self = .item(value: value)
        }
    }
}

extension Deletable: Encodable where T: Encodable, T.ID: Encodable {
    private enum EncodingKeys: String, CodingKey {
        case id
        case deleted
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .item(value: let value):
            try value.encode(to: encoder)
        case .deleted(with: let id):
            var container = encoder.container(keyedBy: EncodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(true, forKey: .deleted)
        }
    }
}

extension Deletable: Sendable where T: Sendable, T.ID: Sendable {}

extension Deletable: Hashable where T: Hashable {}
