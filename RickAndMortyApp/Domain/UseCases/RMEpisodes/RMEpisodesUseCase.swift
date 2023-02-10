//
//  RMEpisodesUseCase.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import Foundation

// MARK: RMEpisodesUseCase - Protocol

protocol RMEpisodesUseCase {
    
    /// Method that fetch the episodes basen on a input parameters.
    /// - Parameter params: Input parameters for fetch the episodes list.
    /// - Parameter completion: Returns a episodes list Entity or an error.
    func execute(params: RMEpisodesUseCaseParameters, completion: @escaping (Result<RMEpisodesListEntity, RMError>) -> Void)
}

// MARK: DefaultRMCharactersUseCase Class

final class DefaultRMEpisodesUseCase: RMEpisodesUseCase {
    
    private var repository: RMEpisodesRepository
    private var paginationUrl: String?
    private var hasFetchAllEpisodes: Bool = false
    
    init(repository: RMEpisodesRepository = DefaultRMEpisodesRepository()) {
        self.repository = repository
    }
}

// MARK: DefaultRMEpisodesUseCase - Execute

extension DefaultRMEpisodesUseCase {
    
    func execute(params: RMEpisodesUseCaseParameters,
                 completion: @escaping (Result<RMEpisodesListEntity, RMError>) -> Void) {
        
        let completion: (Result<RMEpisodesListDecodable, RMError>) -> Void = { [weak self] result in
            switch result {
            case .success(let decodable):
                let entity = RMEpisodesListEntity(decodable: decodable)
                if let nextPaginationUrl = entity.info?.next {
                    self?.paginationUrl = nextPaginationUrl
                } else {
                    self?.hasFetchAllEpisodes = true
                }
                completion(.success(entity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        let repositoryParams = RMEpisodesRepositoryParameters(paginationUrl: paginationUrl, episodeIDs: params.episodesIDs)
        repository.getEpisodes(params: repositoryParams, completion: completion)
    }
}
