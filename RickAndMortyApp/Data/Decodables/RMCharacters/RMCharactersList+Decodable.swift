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
    
    enum ConfigKeys: String, CodingKey {
        case info
        case results
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.info = try values.decode(RMRequestInfoDecodable.self, forKey: .info)
            self.results = try values.decode([RMCharacterDecodable].self, forKey: .results)
            return
        } catch {
            let container = try decoder.singleValueContainer()
            results = try container.decode([RMCharacterDecodable].self)
            return
        }
    }
}
