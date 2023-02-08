//
//  RMCoordinator.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import Foundation

protocol RMCoordinator: AnyObject {
    var childCoordinators: [RMChildCoordinator] { get set }
}
