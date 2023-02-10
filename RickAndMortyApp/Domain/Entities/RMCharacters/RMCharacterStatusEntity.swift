//
//  RMCharacterStatusEntity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 5/2/23.
//

import Foundation

enum RMCharacterStatusEntity: String, Equatable {
    
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
}
