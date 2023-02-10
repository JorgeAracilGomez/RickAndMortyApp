//
//  RMEpisodesRepository.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import Foundation

// MARK: RMEpisodesRepository Protocol

protocol RMEpisodesRepository {
    
    /// Method that fetch the characters list
    /// - Parameter params: Input parameters for fetch the characters list.
    /// - Parameter completion: Returns a characters list Decodable or an error.
    func getEpisodes(params: RMEpisodesRepositoryParameters,
                     completion: @escaping (Result<RMEpisodesListDecodable, RMError>) -> Void)
}

// MARK: DefaultRMEpisodesRepository Class

final class DefaultRMEpisodesRepository: RMEpisodesRepository {
    
    private weak var task: URLSessionTask?
    
    func getEpisodes(params: RMEpisodesRepositoryParameters,
                     completion: @escaping (Result<RMEpisodesListDecodable, RMError>) -> Void) {
    
        let endpoint = params.paginationUrl ?? RMEndpoints.generateURLWithParams(for: .episode, episodesFilter: params.episodeIDs)
        
        task?.cancel()
        
        guard let url = URL(string: endpoint) else {
            let error: RMError = .serviceError(message: "Malformed URL for getTransactions in RMEpisodesRepository")
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

// MARK: DefaultRMEpisodesRepository Response Mannagement

extension DefaultRMEpisodesRepository {
    
    func mannageResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<RMEpisodesListDecodable, RMError>) -> Void) {
        
        if let responsestatus = (response as? HTTPURLResponse)?.statusCode, responsestatus != 200 {
            let error: RMError = .serviceError(message: "Error when when fetching in RMEpisodesRepository")
            completion(.failure(error))
        }
        
        guard let data = data else {
            let error: RMError = .serviceError(message: "No Data Received when fetching in RMEpisodesRepository")
            completion(.failure(error))
            return
        }
        
        guard let decodable = try? JSONDecoder().decode(RMEpisodesListDecodable.self, from: data) else {
            completion(.failure(RMError.decodeError(forDecodable: "RMEpisodesListDecodable")))
            return
        }
        
        completion(.success(decodable))
    }
}
