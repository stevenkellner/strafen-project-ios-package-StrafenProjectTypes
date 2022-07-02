//
//  ISignInData.swift
//  
//
//  Created by Steven on 02.07.22.
//

import Foundation

/// Sign in data of a person.
public protocol ISignInData {
    
    /// Indicates whether person is admin.
    var admin: Bool { get }
    
    /// Date of sign in of the person.
    var signInDate: Date { get }
    
    /// User id of the person.
    var userId: String { get }
}

extension ISignInData {
    
    /// Converts the protocol to the concrete `SignInData` type.
    public var concrete: SignInData {
        return SignInData(self)
    }
}
