//
//  PersonName.swift
//  
//
//  Created by Steven on 17.06.22.
//

import Foundation

/// Contains first and optionally last name of a person.
public struct PersonName: IPersonName {
    
    /// First name of the person.
    public private(set) var first: String
    
    /// Last name of the person.
    public private(set) var last: String?

    public init(first: String, last: String? = nil) {
        self.first = first
        self.last = last
    }
}

extension PersonName {
    
    /// Initializes person name with a `IPersonName` protocol.
    /// - Parameter personName: `IPersonName` protocol to initialize the person name.
    public init(_ personName: some IPersonName) {
        self.first = personName.first
        self.last = personName.last
    }
}

extension PersonName: Equatable {}

extension PersonName: Decodable {}

extension PersonName: Encodable {}

extension PersonName: Sendable {}

extension PersonName: Hashable {}
