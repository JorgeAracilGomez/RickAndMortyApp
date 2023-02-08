//
//  RMCharactersUseCase.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

// MARK: RMCharactersUseCase - Protocol

protocol RMCharactersUseCase {
    
    /// Method that fetch the characters basen on a input parameters.
    /// - Parameter params: Input parameters for fetch the characters list.
    /// - Parameter completion: Returns a characters list Entity or an error.
    func execute(params: RMCharactersUseCaseParameters, completion: @escaping (Result<RMCharactersListEntity, RMError>) -> Void)
    
    
    /// Method to clean the stored current filter parameters for the fetch query.
    func clearFilters()
}

// MARK: DefaultRMCharactersUseCase Class

final class DefaultRMCharactersUseCase: RMCharactersUseCase {
    
    private var repository: RMCharactersRepository
    private var paginationUrl: String?
    private var hasFetchAllCharacters: Bool = false
    
    init(repository: RMCharactersRepository = DefaultRMCharactersRepository()) {
        self.repository = repository
    }
}

// MARK: DefaultRMCharactersUseCase - Execute

extension DefaultRMCharactersUseCase {
    
    func execute(params: RMCharactersUseCaseParameters,
                 completion: @escaping (Result<RMCharactersListEntity, RMError>) -> Void) {
        
        let completion: (Result<RMCharactersListDecodable, RMError>) -> Void = { [weak self] result in
            switch result {
            case .success(let decodable):
                let entity = RMCharactersListEntity(decodable: decodable)
                if let nextPaginationUrl = entity.info?.next {
                    self?.paginationUrl = nextPaginationUrl
                } else {
                    self?.hasFetchAllCharacters = true
                }
                completion(.success(entity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        let repositoryParams = RMCharactersRepositoryParameters(paginationUrl: paginationUrl, searchFilter: params.searchFilter)
        repository.getCharacters(params: repositoryParams, completion: completion)
    }
}

// MARK: DefaultRMCharactersUseCase - Manage Filters

extension DefaultRMCharactersUseCase {
    
    func clearFilters() {
        self.paginationUrl = nil
    }
}
