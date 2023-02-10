//
//  RMLocationsList+Entity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import Foundation

struct RMLocationsListEntity {
    var locations: [RMLocationEntity]?
    
    init(decodable: RMLocationsListDecodable) {
        self.locations = decodable.locations?.map({ locationsDecodable in
            RMLocationEntity(decodable: locationsDecodable)
        })
    }
}
