//
//  RMError.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

enum RMError: Error {
    case serviceError(message: String)
    case decodeError(forDecodable: String)
    case parseError(message: String)
    case unknownError(message: String)
}
