//
//  RMCharactersRepositoryFailure+Mock.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 11/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMCharactersRepositoryFailureMock: RMCharactersRepository {
    
    func getCharacters(params: RickAndMortyApp.RMCharactersRepositoryParameters, completion: @escaping (Result<RickAndMortyApp.RMCharactersListDecodable, RickAndMortyApp.RMError>) -> Void) {
        
        let error: RMError = .serviceError(message: "Error when when fetching in RMCharactersRepositoryFailureMock")
        completion(.failure(error))
    }
}
