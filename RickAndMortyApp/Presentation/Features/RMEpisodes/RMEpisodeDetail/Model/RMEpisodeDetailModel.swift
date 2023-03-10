//
//  RMEpisodeDetailModel.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import Foundation

struct RMEpisodeDetailModel {
    var name: String?
    var season: Int?
    var episode: Int?
    var airDate: String?
    var characters: [RMCharacterEntity]
}
