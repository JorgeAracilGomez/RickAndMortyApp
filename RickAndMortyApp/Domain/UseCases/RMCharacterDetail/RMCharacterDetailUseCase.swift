//
//  RMCharacterDetailUseCase.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import Foundation

// MARK: RMCharacterDetailUseCase - Protocol

protocol RMCharacterDetailUseCase {
    
    /// Method that fetch the character detail info basen on a input parameters.
    /// - Parameter params: Input parameters for fetch the character detail info.
    /// - Parameter completion: Returns a character detail Entity or an error.
    func execute(params: RMCharacterDetailUseCaseParameters, completion: @escaping (Result<RMCharacterDetailEntity, RMError>) -> Void)
}

// MARK: DefaultRMCharacterDetailUseCase Class

final class DefaultRMCharacterDetailUseCase: RMCharacterDetailUseCase {
    
    private var locationsUseCase: RMLocationsUseCase
    private var episodesUseCase: RMEpisodesUseCase
    private var locationsEntity: RMLocationsListEntity?
    private var episodesEntity: RMEpisodesListEntity?
    private let dispatchGroup = DispatchGroup()
    private var dispatchGroupError: RMError?
    
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
        
        fetchLocations(intoGroup: dispatchGroup, params: params, completion: completion)
        fetchEpisodes(intoGroup: dispatchGroup, params: params, completion: completion)
        
        dispatchGroup.notify(queue: .main) {
            
            if let error = self.dispatchGroupError {
                completion(.failure(error))
            }
            
            guard let locationsEntity = self.locationsEntity, let episodesEntity = self.episodesEntity else {
                let error = RMError.unknownError(message: "Could not get the data to build RMCharacterDetailEntity in RMCharacterDetailUseCase")
                return
            }
            
            let entity = RMCharacterDetailEntity(locationsEntity: locationsEntity, episodesEntity: episodesEntity)
            completion(.success(entity))
        }
    }
}

// MARK: DefaultRMCharacterDetailUseCase - fetchLocations

extension DefaultRMCharacterDetailUseCase {
    
    private func fetchLocations(intoGroup group: DispatchGroup,
                                params: RMCharacterDetailUseCaseParameters,
                                completion: @escaping (Result<RMCharacterDetailEntity, RMError>) -> Void) {
        
        group.enter()
        
        let useCaseParemeters = RMLocationsUseCaseParameters(originID: params.originID, locationID: params.locationID)
        locationsUseCase.execute(params: useCaseParemeters) { [weak self] result in
            defer { group.leave() }
            switch result {
            case .success(let locationsEntity):
                self?.locationsEntity = locationsEntity
            case .failure(let error):
                self?.dispatchGroupError = error
            }
        }
    }
}

// MARK: DefaultRMCharacterDetailUseCase - fetchEpisodes

extension DefaultRMCharacterDetailUseCase {
    
    private func fetchEpisodes(intoGroup group: DispatchGroup,
                               params: RMCharacterDetailUseCaseParameters,
                               completion: @escaping (Result<RMCharacterDetailEntity, RMError>) -> Void) {
        
        group.enter()
        
        let episodesUseCaseParameters = RMEpisodesUseCaseParameters(episodesIDs: params.episodesIDs)
        episodesUseCase.execute(params: episodesUseCaseParameters) { [weak self] result in
            defer { group.leave() }
            switch result {
            case .success(let episodesEntity):
                self?.episodesEntity = episodesEntity
            case .failure(let error):
                self?.dispatchGroupError = error
            }
        }
    }
}
