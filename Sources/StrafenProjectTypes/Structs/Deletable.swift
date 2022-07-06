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
