//
//  RMCharacterDetail+Entity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import Foundation

struct RMCharacterDetailEntity {
    var locations: [RMLocationEntity]?
    var episodes: [RMEpisodeEntity]?
    
    init(locationsEntity: RMLocationsListEntity, episodesEntity: RMEpisodesListEntity) {
        self.locations = locationsEntity.locations
        self.episodes = episodesEntity.results
    }
}
