//
//  RMLocationsList+Decodable.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import Foundation

struct RMLocationsListDecodable: Codable {
    var locations: [RMLocationDecodable]?
    
    /// Decodes the info for non-primaryKey response json data.
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        locations = try container.decode([RMLocationDecodable].self)
    }
}
