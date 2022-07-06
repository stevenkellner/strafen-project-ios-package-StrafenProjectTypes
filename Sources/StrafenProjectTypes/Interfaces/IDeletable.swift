//
//  IDeletable.swift
//  
//
//  Created by Steven on 06.07.22.
//

import Foundation

/// Deleted database item or underlying database item
public protocol IDeletable<T> {

    /// Type of the underlying database item.
    associatedtype T: Identifiable

    /// Concrete `Deletable` type of this deletable.
    var concreteDeletable: Deletable<T> { get }
}

extension IDeletable {

    /// Converts the protocol to the concrete `Deletable` type.
    public var concrete: Deletable<T> {
        return Deletable(self)
    }
}
