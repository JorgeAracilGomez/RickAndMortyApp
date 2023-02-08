//
//  RMCharactersList+Decodable.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

struct RMCharactersListDecodable: Codable {
    var info: RMRequestInfoDecodable?
    var results: [RMCharacterDecodable]?
}
