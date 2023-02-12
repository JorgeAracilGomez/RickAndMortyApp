//
//  RMEpisodesRepositoryFailure+Mock.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 11/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMEpisodesRepositoryFailureMock: RMEpisodesRepository {
    
    func getEpisodes(params: RickAndMortyApp.RMEpisodesRepositoryParameters, completion: @escaping (Result<RickAndMortyApp.RMEpisodesListDecodable, RickAndMortyApp.RMError>) -> Void) {
        
        let error: RMError = .serviceError(message: "Error when when fetching in RMEpisodesRepositoryFailureMock")
        completion(.failure(error))
    }
}
