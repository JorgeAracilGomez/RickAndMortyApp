//
//  RMLocation+Entity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import Foundation

struct RMLocationEntity {
    var id: Int?
    var name: String?
    var type: String?
    var dimension: String?
    var residents: [String]?
    var url: String?
    var created: String?
    
    init(decodable: RMLocationDecodable) {
        self.id = decodable.id
        self.name = decodable.name
        self.type = decodable.type
        self.dimension = decodable.dimension
        self.residents = decodable.residents
        self.url = decodable.url
        self.created = decodable.created
    }
}
