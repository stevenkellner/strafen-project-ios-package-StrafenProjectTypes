//
//  Club.swift
//  
//
//  Created by Steven on 02.07.22.
//

import Foundation

/// Contains propterties of a club in firebase realtime database.
public struct Club: IClub {
    
    /// Type of the id of the club.
    public typealias ID = Tagged<(Club, id: ()), UUID>
    
    /// Id of the club.
    public private(set) var id: Club.ID
    
    /// Identifier of the club.
    public private(set) var identifier: String
    
    /// Name of the club.
    public private(set) var name: String
    
    /// Region code of the club.
    public private(set) var regionCode: String
    
    /// Indicates whether in app payment is active.
    public private(set) var inAppPaymentActive: Bool
    
    /// User ids of signed in persons.
    public private(set) var personUserIds: Dictionary<String, Person.ID>

    public init(id: Club.ID, identifier: String, name: String, regionCode: String, inAppPaymentActive: Bool, personUserIds: Dictionary<String, Person.ID>) {
        self.id = id
        self.identifier = identifier
        self.name = name
        self.regionCode = regionCode
        self.inAppPaymentActive = inAppPaymentActive
        self.personUserIds = personUserIds
    }
}

extension Club {
    
    /// Initializes club with a `IClub` protocol.
    /// - Parameter club: `IClub` protocol to initialize the club.
    public init(_ club: some IClub) {
        self.id = club.id
        self.identifier = club.identifier
        self.name = club.name
        self.regionCode = club.regionCode
        self.inAppPaymentActive = club.inAppPaymentActive
        self.personUserIds = club.personUserIds
    }
}

extension Club: Equatable {}

extension Club: Decodable {}

extension Club: Encodable {}

extension Club: Sendable {}

extension Club: Hashable {}
