//
//  RMLocationsRepository.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import Foundation

// MARK: RMLocationsRepository Protocol

protocol RMLocationsRepository {
    
    /// Method that fetch the locations list
    /// - Parameter params: Input parameters for fetch the locations list.
    /// - Parameter completion: Returns a locations list Decodable or an error.
    func getLocations(params: RMLocationsRepositoryParameters,
                      completion: @escaping (Result<RMLocationsListDecodable, RMError>) -> Void)
}

// MARK: DefaultRMLocationsRepository Class

final class DefaultRMLocationsRepository: RMLocationsRepository {
    
    private weak var task: URLSessionTask?
    
    func getLocations(params: RMLocationsRepositoryParameters,
                      completion: @escaping (Result<RMLocationsListDecodable, RMError>) -> Void) {
        
        let endpoint = RMEndpoints.generateURLWithParams(for: .location, locationsFilter: params.locationsIDs)
                        
        task?.cancel()
        
        guard let url = URL(string: endpoint) else {
            let error: RMError = .serviceError(message: "Malformed URL for getTransactions in RMLocationsRepository")
            completion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            self.mannageResponse(data: data, response: response, error: error, completion: completion)
        })
        
        task?.resume()
    }
}

// MARK: DefaultRMLocationsRepository Response Mannagement

extension DefaultRMLocationsRepository {
    
    func mannageResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<RMLocationsListDecodable, RMError>) -> Void) {
        
        if let responsestatus = (response as? HTTPURLResponse)?.statusCode, responsestatus != 200 {
            let error: RMError = .serviceError(message: "Error when when fetching in RMLocationsRepository")
            completion(.failure(error))
        }
        
        guard let data = data else {
            let error: RMError = .serviceError(message: "No Data Received when fetching in RMLocationsRepository")
            completion(.failure(error))
            return
        }
        
        guard let decodable = try? JSONDecoder().decode(RMLocationsListDecodable.self, from: data) else {
            completion(.failure(RMError.decodeError(forDecodable: "RMLocationsListDecodable")))
            return
        }
        
        completion(.success(decodable))
    }
}
