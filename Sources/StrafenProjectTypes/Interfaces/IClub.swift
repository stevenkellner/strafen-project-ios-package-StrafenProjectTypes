//
//  IClub.swift
//  
//
//  Created by Steven on 02.07.22.
//

import Foundation

public protocol IClub {
    
    /// Id of the club.
    var id: Club.ID { get }
    
    /// Identifier of the club.
    var identifier: String { get }
    
    /// Name of the club.
    var name: String { get }
    
    /// Region code of the club.
    var regionCode: String { get }
    
    /// Indicates whether in app payment is active.
    var inAppPaymentActive: Bool { get }
    
    /// User ids of signed in persons.
    var personUserIds: Dictionary<String, Person.ID> { get }
}

extension IClub {
    
    /// Converts the protocol to the concrete `Club` type.
    public var concrete: Club {
        return Club(self)
    }
}
