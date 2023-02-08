//
//  RMCharacterLocation+Entity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

struct RMCharacterLocationEntity {
    var name: String?
    var url: String?
    
    init(decodable: RMCharacterLocationDecodable) {
        self.name = decodable.name
        self.url = decodable.url
    }
}
