//
//  RMEpisode+Entity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

struct RMEpisodeEntity {
    /// The id of the episode.
    var id: Int?
    /// The name of the episode.
    var name: String?
    /// The air date of the episode.
    var airDate: String?
    /// The code of the episode.
    var episode: String?
    /// List of characters who have been seen in the episode.
    var characters: [String]?
    /// Link to the episode's own endpoint.
    var url: String?
    /// Time at which the episode was created in the database.
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
