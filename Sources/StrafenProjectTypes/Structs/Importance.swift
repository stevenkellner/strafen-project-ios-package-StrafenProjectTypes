//
//  Importance.swift
//  
//
//  Created by Steven on 17.06.22.
//

import Foundation

/// Contains the importance of a fine or reason template.
public enum Importance: IImportance {
    
    /// Fine / reason template has high importance.
    case high
    
    /// Fine / reason template has medium importance.
    case medium
    
    /// Fine / reason template has low importance.
    case low
    
    public var concreteImportance: Importance { self }
}

extension Importance {

    /// Initializes importance with a `IImportance` protocol.
    /// - Parameter importance: `IImportance` protocol to initialize the importance.
    public init(_ importance: some IImportance) {
        self = importance.concreteImportance
    }
}

extension Importance: Equatable {}

extension Importance: Comparable {
    public static func <(lhs: Importance, rhs: Importance) -> Bool {
        switch (lhs, rhs) {
        case (.low, .medium), (.low, .high), (.medium, .high): return true
        case (.high, .low), (.high, .medium), (.medium, .low): return false
        case (.low, .low), (.medium, .medium), (.high, .high): return false
        }
    }
}

extension Importance: Decodable {}

extension Importance: Encodable {}

extension Importance: Sendable {}

extension Importance: Hashable {}
