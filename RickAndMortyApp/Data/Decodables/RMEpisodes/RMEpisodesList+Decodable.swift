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
    
    enum ConfigKeys: String, CodingKey {
        case info
        case results
    }
    
    enum OnlyResultsKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.info = try values.decode(RMRequestInfoDecodable.self, forKey: .info)
            self.results = try values.decode([RMEpisodeDecodable].self, forKey: .results)
            return
        } catch {
            let container = try decoder.singleValueContainer()
            results = try container.decode([RMEpisodeDecodable].self)
            return
        }
    }
}
