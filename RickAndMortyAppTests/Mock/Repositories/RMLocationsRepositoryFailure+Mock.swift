//
//  RMLocationsRepositoryFailure+Mock.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 11/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMLocationsRepositoryFailureMock: RMLocationsRepository {
    
    func getLocations(params: RickAndMortyApp.RMLocationsRepositoryParameters, completion: @escaping (Result<RickAndMortyApp.RMLocationsListDecodable, RickAndMortyApp.RMError>) -> Void) {
        
        let error: RMError = .serviceError(message: "Error when when fetching in RMLocationsRepositoryFailureMock")
        completion(.failure(error))
    }
}
