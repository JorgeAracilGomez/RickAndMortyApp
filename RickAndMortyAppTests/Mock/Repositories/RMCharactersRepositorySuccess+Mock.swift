//
//  RMCharactersRepositorySuccess+Mock.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 11/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMCharactersRepositorySuccessMock: RMCharactersRepository {
    
    func getCharacters(params: RickAndMortyApp.RMCharactersRepositoryParameters, completion: @escaping (Result<RickAndMortyApp.RMCharactersListDecodable, RickAndMortyApp.RMError>) -> Void) {
        
        let json = RMCharactersListMock.makeJsonMock()
        guard let decodable = try? JSONDecoder().decode(RMCharactersListDecodable.self, from: json) else { return }
        completion(.success(decodable))
    }
}
