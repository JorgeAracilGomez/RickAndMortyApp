//
//  RMRequestInfo+Decodable.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

struct RMRequestInfoDecodable: Codable {
    var count: Int?
    var pages: Int?
    var next: String?
    var previous: String?

    enum CodingKeys: String, CodingKey {
        case count, pages, next
        case previous = "prev"
    }
}
