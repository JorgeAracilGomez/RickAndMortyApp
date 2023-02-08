//
//  RMEpisodesList+Entity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

struct RMEpisodesListEntity {
    var info: RMRequestInfoEntity?
    var results: [RMEpisodeEntity]?
    
    init(decodable: RMEpisodesListDecodable) {
        if let decodableInfo = decodable.info {
            self.info = RMRequestInfoEntity(decodable: decodableInfo)
        }
        self.results = decodable.results?.map({ resultsDecodable in
            RMEpisodeEntity(decodable: resultsDecodable)
        })
    }
}
