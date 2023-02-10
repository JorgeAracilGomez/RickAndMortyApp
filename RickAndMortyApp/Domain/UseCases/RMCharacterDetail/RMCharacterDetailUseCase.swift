//
//  RMCharacterDetailUseCase.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import Foundation

// MARK: RMCharacterDetailUseCase - Protocol

protocol RMCharacterDetailUseCase {
    
    /// Method that fetch the characters basen on a input parameters.
    /// - Parameter params: Input parameters for fetch the characters list.
    /// - Parameter completion: Returns a characters list Entity or an error.
    func execute(params: RMCharacterDetailUseCaseParameters, completion: @escaping (Result<RMCharacterDetailEntity, RMError>) -> Void)
}

// MARK: DefaultRMCharacterDetailUseCase Class

final class DefaultRMCharacterDetailUseCase: RMCharacterDetailUseCase {
    
    private var locationsUseCase: RMLocationsUseCase
    private var episodesUseCase: RMEpisodesUseCase
    
    private var locationsEntity: RMLocationsListEntity?
    private var episodesEntity: RMEpisodesListEntity?
    
    init(locationsUseCase: RMLocationsUseCase = DefaultRMLocationsUseCase(),
         episodesUseCase: RMEpisodesUseCase = DefaultRMEpisodesUseCase()) {
        
        self.locationsUseCase = locationsUseCase
        self.episodesUseCase = episodesUseCase
    }
}

// MARK: DefaultRMCharacterDetailUseCase - Execute

extension DefaultRMCharacterDetailUseCase {
    
    func execute(params: RMCharacterDetailUseCaseParameters,
                 completion: @escaping (Result<RMCharacterDetailEntity, RMError>) -> Void) {
        
        // MISCO DISPATCH GROUP
        
        fetchLocations(params: params, completion: completion)
    }
}

// MARK: DefaultRMCharacterDetailUseCase - fetchLocations

extension DefaultRMCharacterDetailUseCase {
    
    private func fetchLocations(params: RMCharacterDetailUseCaseParameters,
                                  completion: @escaping (Result<RMCharacterDetailEntity, RMError>) -> Void) {
        
        let useCaseParemeters = RMLocationsUseCaseParameters(originID: params.originID, locationID: params.locationID)
        locationsUseCase.execute(params: useCaseParemeters) { [weak self] result in
            switch result {
            case .success(let locationsEntity):
                self?.locationsEntity = locationsEntity
                self?.fetchEpisodes(params: params, locationsEntity: locationsEntity, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: DefaultRMCharacterDetailUseCase - fetchEpisodes

extension DefaultRMCharacterDetailUseCase {
    
    private func fetchEpisodes(params: RMCharacterDetailUseCaseParameters,
                               locationsEntity: RMLocationsListEntity,
                               completion: @escaping (Result<RMCharacterDetailEntity, RMError>) -> Void) {
        
        let episodesUseCaseParameters = RMEpisodesUseCaseParameters(episodesIDs: params.episodesIDs)
        episodesUseCase.execute(params: episodesUseCaseParameters) { result in
            switch result {
            case .success(let episodesEntity):
                let entity = RMCharacterDetailEntity(locationsEntity: locationsEntity, episodesEntity: episodesEntity)
                completion(.success(entity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
