//
//  MainCoordinator.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation
import UIKit

// MARK: RMMainCoordinator

final class RMMainCoordinator: RMCoordinator {
    var childCoordinators = [RMChildCoordinator]()
}

// MARK: RMMainCoordinator - Show Operative Methods

extension RMMainCoordinator {
    
    /// This method is responsible for show the characters Operative.
    /// - Parameter navigationController: Navigation controller for the characters Operative
    func showCharactersOperativeWith(navigationController: UINavigationController) {
        let charactersCoordinator = RMCharactersCoordinator(navigationController: navigationController, parentCoordinator: self)
        charactersCoordinator.start()
        self.childCoordinators.append(charactersCoordinator)
    }
    
    /// This method is responsible for show the episodes Operative.
    /// - Parameter navigationController: Navigation controller for the episodes Operative
    func showEpisodesOperativeWith(navigationController: UINavigationController) {
        let episodesCoordinator = RMEpisodesCoordinator(navigationController: navigationController, parentCoordinator: self)
        episodesCoordinator.start()
        self.childCoordinators.append(episodesCoordinator)
    }
}

// MARK: Managge Remove Child Coordinators

extension RMMainCoordinator {
    
    func childDidFinish(_ child: RMCoordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
