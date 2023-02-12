//
//  RMCharactersRepository.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

// MARK: RMCharactersRepository Protocol

protocol RMCharactersRepository {
    
    /// Method that fetch the characters list
    /// - Parameter params: Input parameters for fetch the characters list.
    /// - Parameter completion: Returns a characters list Decodable or an error.
    func getCharacters(params: RMCharactersRepositoryParameters,
                       completion: @escaping (Result<RMCharactersListDecodable, RMError>) -> Void)
}

// MARK: DefaultRMCharactersRepository Class

final class DefaultRMCharactersRepository: RMCharactersRepository {
    
    private weak var task: URLSessionTask?
    
    func getCharacters(params: RMCharactersRepositoryParameters,
                       completion: @escaping (Result<RMCharactersListDecodable, RMError>) -> Void) {
        
        let endpoint = params.paginationUrl ?? RMEndpoints.generateURLWithParams(for: .character, searchFilter: params.searchFilter, charactersFilter: params.charactersIDs)
                
        task?.cancel()
        
        guard let url = URL(string: endpoint) else {
            let error: RMError = .serviceError(message: "Malformed URL for getTransactions in RMCharactersRepository")
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

// MARK: DefaultRMCharactersRepository Response Mannagement

extension DefaultRMCharactersRepository {
    
    func mannageResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<RMCharactersListDecodable, RMError>) -> Void) {
        
        if let responsestatus = (response as? HTTPURLResponse)?.statusCode, responsestatus != 200 {
            let error: RMError = .serviceError(message: "Error when when fetching in RMCharactersRepository")
            completion(.failure(error))
        }
        
        guard let data = data else {
            let error: RMError = .serviceError(message: "No Data Received when fetching in RMCharactersRepository")
            completion(.failure(error))
            return
        }
        
        guard let decodable = try? JSONDecoder().decode(RMCharactersListDecodable.self, from: data) else {
            completion(.failure(RMError.decodeError(forDecodable: "RMCharactersListDecodable")))
            return
        }
        
        completion(.success(decodable))
    }
}
