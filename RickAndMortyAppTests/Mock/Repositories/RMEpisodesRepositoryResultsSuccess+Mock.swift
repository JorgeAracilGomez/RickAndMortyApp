//
//  RMEpisodesRepositoryResultsSuccess+Mock.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 11/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMEpisodesRepositoryResultsSuccessMock: RMEpisodesRepository {
    
    func getEpisodes(params: RickAndMortyApp.RMEpisodesRepositoryParameters, completion: @escaping (Result<RickAndMortyApp.RMEpisodesListDecodable, RickAndMortyApp.RMError>) -> Void) {
        
        let json = RMEpisodesListMock.makeResultsJsonMock()
        guard let decodable = try? JSONDecoder().decode(RMEpisodesListDecodable.self, from: json) else { return }
        completion(.success(decodable))
    }
}
