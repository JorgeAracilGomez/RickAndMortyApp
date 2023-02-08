//
//  RMCharacterStatusEntity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 5/2/23.
//

import Foundation

enum RMCharacterStatusEntity: Equatable {
    
    /// Representation for all the Status available cases ('Alive', 'Dead' or 'unknown')
    case Alive, Dead, Unknown
    
    init(stringValue: String) {
        switch stringValue {
        case String(describing: RMCharacterStatusEntity.Alive):
            self = .Alive
        case String(describing: RMCharacterStatusEntity.Dead):
            self = .Dead
        default:
            self = .Unknown
        }
    }
    
    /// Return the String representation for all the Entity cases
//    var rawValue: String {
//        get {
//            switch self {
//            case .EUR, .USD, .GBP, .JPY, .AUD, .CAD, .SEK, .RUB, .INR:
//                return String(describing: self)
//            case .other(let value):
//                return value
//            }
//        }
//    }
    
    /// Equatable method for allow the Other case values
//    static func == (lhs: RMCharacterGenderEntity, rhs: RMCharacterGenderEntity) -> Bool {
//        lhs.rawValue == rhs.rawValue
//    }
}
