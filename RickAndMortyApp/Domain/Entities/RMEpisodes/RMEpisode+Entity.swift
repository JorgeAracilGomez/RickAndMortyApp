//
//  RMEpisode+Entity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

struct RMEpisodeEntity {
    var id: Int?
    var name: String?
    var airDate: String?
    var episode: String?
    var characters: [String]?
    var url: String?
    var created: String?

    init(decodable: RMEpisodeDecodable) {
        self.id = decodable.id
        self.name = decodable.name
        self.airDate = decodable.airDate
        self.episode = decodable.episode
        self.characters = decodable.characters
        self.url = decodable.url
        self.created = decodable.created
    }
}
