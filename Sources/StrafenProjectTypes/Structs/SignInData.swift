//
//  SignInData.swift
//  
//
//  Created by Steven on 02.07.22.
//

import Foundation

/// Sign in data of a person.
public struct SignInData: ISignInData {
    
    /// Indicates whether person is admin.
    public private(set) var admin: Bool
    
    /// Date of sign in of the person.
    public private(set) var signInDate: Date
    
    /// User id of the person.
    public private(set) var userId: String
}

extension SignInData {
    
    /// Initializes sign in data with a `ISignInData` protocol.
    /// - Parameter signInData: `ISignInData` protocol to initialize the sign in data.
    public init(_ signInData: some ISignInData) {
        self.admin = signInData.admin
        self.signInDate = signInData.signInDate
        self.userId = signInData.userId
    }
}

extension SignInData: Equatable {
    public static func ==(lhs: SignInData, rhs: SignInData) -> Bool {
        return lhs.admin == rhs.admin && lhs.signInDate == rhs.signInDate && lhs.userId == rhs.userId
    }
}