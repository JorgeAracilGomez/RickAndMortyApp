//
//  RMLocationsUseCase.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import Foundation

// MARK: RMLocationsUseCase

protocol RMLocationsUseCase {
    
    /// Method that fetch the locations
    /// - Parameter completion: Returns a locations list Entity or an error.
    func execute(params: RMLocationsUseCaseParameters,
                 completion: @escaping (Result<RMLocationsListEntity, RMError>) -> Void)
}

// MARK: DefaultRMLocationsUseCase

final class DefaultRMLocationsUseCase: RMLocationsUseCase {
    
    private var repository: RMLocationsRepository
    
    init(repository: RMLocationsRepository = DefaultRMLocationsRepository()) {
        self.repository = repository
    }
    
    func execute(params: RMLocationsUseCaseParameters,
                 completion: @escaping (Result<RMLocationsListEntity, RMError>) -> Void) {
        
        let completion: (Result<RMLocationsListDecodable, RMError>) -> Void = { result in
            switch result {
            case .success(let decodable):
                let entity = RMLocationsListEntity(decodable: decodable)
                completion(.success(entity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        let repositoryParams = RMLocationsRepositoryParameters(locationsIDs: [params.originID, params.locationID])
        repository.getLocations(params: repositoryParams, completion: completion)
    }
}
