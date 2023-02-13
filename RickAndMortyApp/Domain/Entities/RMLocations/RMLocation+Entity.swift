//
//  RMLocation+Entity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import Foundation

struct RMLocationEntity {
    /// The id of the location.
    var id: Int?
    /// The name of the location.
    var name: String?
    /// The type of the location.
    var type: String?
    /// The dimension in which the location is located.
    var dimension: String?
    /// List of character who have been last seen in the location.
    var residents: [String]?
    /// Link to the location's own endpoint.
    var url: String?
    /// Time at which the location was created in the database.
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
