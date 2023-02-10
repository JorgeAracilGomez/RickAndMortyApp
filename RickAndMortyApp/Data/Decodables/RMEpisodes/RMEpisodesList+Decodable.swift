//
//  RMEpisodesList+Decodable.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

struct RMEpisodesListDecodable: Codable {
    var info: RMRequestInfoDecodable?
    var results: [RMEpisodeDecodable]?
    
    /// Decodes the info for non-primaryKey response json data.
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        results = try container.decode([RMEpisodeDecodable].self)
    }
}
