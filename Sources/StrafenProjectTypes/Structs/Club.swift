//
//  Club.swift
//  
//
//  Created by Steven on 02.07.22.
//

import Foundation

public struct Club: IClub {
    
    /// Type of the id of the club.
    public typealias ID = Tagged<(Person, id: ()), UUID>
    
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

extension Club: Equatable {
    public static func ==(lhs: Club, rhs: Club) -> Bool {
        return lhs.id == rhs.id && lhs.identifier == rhs.identifier && lhs.name == rhs.name && lhs.regionCode == rhs.regionCode &&
            lhs.inAppPaymentActive == rhs.inAppPaymentActive && lhs.personUserIds == rhs.personUserIds
    }
}
