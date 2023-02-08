//
//  RMCharacterGenderEntity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 5/2/23.
//

import Foundation

enum RMCharacterGenderEntity: Equatable {
    
    /// Representation for all the Gender available cases ('Female', 'Male', 'Genderless' or 'unknown')
    case Female, Male, Genderless, Unknown
    
    init(stringValue: String) {
        switch stringValue {
        case String(describing: RMCharacterGenderEntity.Female):
            self = .Female
        case String(describing: RMCharacterGenderEntity.Male):
            self = .Male
        case String(describing: RMCharacterGenderEntity.Genderless):
            self = .Genderless
        default:
            self = .Unknown
        }
    }
}
