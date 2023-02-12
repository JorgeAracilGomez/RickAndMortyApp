//
//  RMLocationsRepositorySuccess+Mock.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 11/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMLocationsRepositorySuccessMock: RMLocationsRepository {
    
    func getLocations(params: RickAndMortyApp.RMLocationsRepositoryParameters, completion: @escaping (Result<RickAndMortyApp.RMLocationsListDecodable, RickAndMortyApp.RMError>) -> Void) {
        
        let json = RMLocationsListMock.makeJsonMock()
        guard let decodable = try? JSONDecoder().decode(RMLocationsListDecodable.self, from: json) else { return }
        completion(.success(decodable))
    }
}
