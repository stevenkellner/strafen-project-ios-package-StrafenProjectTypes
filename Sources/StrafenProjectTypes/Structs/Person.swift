//
//  Person.swift
//  
//
//  Created by Steven on 17.06.22.
//

import Foundation

/// Person with id and a name.
public struct Person: IPerson {
    
    /// Type of the id of the person.
    public typealias ID = Tagged<(Person, id: ()), UUID>
    
    /// Id of the person.
    public private(set) var id: ID
    
    /// Name of the person.
    public private(set) var name: PersonName
    
    /// Sign in data of a person.
    public private(set) var signInData: SignInData?
}

extension Person {
    
    /// Initializes person with a `IPerson` protocol.
    /// - Parameter person: `IPerson` protocol to initialize the person.
    public init(_ person: some IPerson) {
        self.id = person.id
        self.name = PersonName(person.name)
        if let signInData = person.signInData {
            self.signInData = SignInData(signInData)
        }
    }
}

extension Person: Equatable {
    public static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.signInData == rhs.signInData
    }
}
