//
//  RMCharacter+Decodable.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

struct RMCharacterDecodable: Codable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: RMCharacterLocationDecodable?
    var location: RMCharacterLocationDecodable?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
}
