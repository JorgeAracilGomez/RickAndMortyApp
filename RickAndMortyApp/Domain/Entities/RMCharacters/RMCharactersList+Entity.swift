//
//  RMCharactersList+Entity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

struct RMCharactersListEntity {
    var info: RMRequestInfoEntity?
    var results: [RMCharacterEntity]?
    
    init(decodable: RMCharactersListDecodable) {
        if let decodableInfo = decodable.info {
            self.info = RMRequestInfoEntity(decodable: decodableInfo)
        }
        self.results = decodable.results?.map({ characterDecodable in
            RMCharacterEntity(decodable: characterDecodable)
        })
    }
}
