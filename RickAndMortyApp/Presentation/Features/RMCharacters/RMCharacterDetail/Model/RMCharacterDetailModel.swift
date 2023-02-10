//
//  RMCharacterDetailModel.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 9/2/23.
//

import Foundation

struct RMCharacterDetailModel {
    var imagePath: String
    var status: RMCharacterStatusEntity
    var gender: String
    var species: String
    var origin: RMLocationEntity
    var location: RMLocationEntity
}
