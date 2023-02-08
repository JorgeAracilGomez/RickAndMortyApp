//
//  RMEndpoints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 5/2/23.
//

import Foundation

/// Enpoints enumeration for get RM API data
/// - character: endpoint to retrieve all the data of the characters
/// - episode: endpoint to retrieve all the data of the episodes
@frozen enum RMEndpoint: String {
    case character = "character"
    case episode = "episode"
}

// MARK: RMEndpoints

struct RMEndpoints {
    static let baseURL = "https://rickandmortyapi.com/api/"
    
    /// characters Key Filters
    static let pageKey = "/?page=%d"
    static let nameKey = "?name=%@"
    static let statusKey = "&status=%@" // MISCO Incluir filtro
}

// MARK: Generate URL Formatted

extension RMEndpoints {
    
    static func generateURLWithParams(for endpoint: RMEndpoint, searchFilter: String? = nil) -> String {
        var url = self.baseURL + endpoint.rawValue
        if let searchFilter = searchFilter {
            url += String(format: nameKey, searchFilter)
        }
        
        return url
    }
}













