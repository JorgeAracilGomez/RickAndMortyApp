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
}
