//
//  RMRequestInfo+Entity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

struct RMRequestInfoEntity {
    var count: Int?
    var pages: Int?
    var next: String?
    var previous: String?

    init(decodable: RMRequestInfoDecodable) {
        self.count = decodable.count
        self.pages = decodable.pages
        self.next = decodable.next
        self.previous = decodable.previous
    }
}
