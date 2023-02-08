//
//  RMEpisode+Decodable.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

struct RMEpisodeDecodable: Codable {
    var id: Int?
    var name: String?
    var airDate: String?
    var episode: String?
    var characters: [String]?
    var url: String?
    var created: String?

    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
}
