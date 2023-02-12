//
//  RMEpisodesCoordinator.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

class RMEpisodesCoordinator: RMChildCoordinator {
    var parentCoordinator: RMMainCoordinator
    var childCoordinators = [RMChildCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinator: RMMainCoordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func didFinishForCharacters() {
        parentCoordinator.childDidFinish(self)
    }
}

// MARK: Show Characters Operative Views

extension RMEpisodesCoordinator {
   
    /// This method is responsible for initializing the Operative.
    func start() {
        let episodesSelectionViewController = RMEpisodesSelectorViewController()
        episodesSelectionViewController.coordinator = self
        episodesSelectionViewController.title = "Episodes_Navigation_Title".localized
        episodesSelectionViewController.tabBarItem = UITabBarItem(title: "Episodes_Navigation_Title".localized, image: UIImage(systemName: "play.tv")?.withRenderingMode(.automatic), tag: 1)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(episodesSelectionViewController, animated: false)
    }
    
    /// This method navigates to the episode detail screen.
    /// - Parameter model: Model that contains the information of the episodes for which you want to obtain the detail view.
    func showEpisodeDetail(for model: RMEpisodeEntity) {
//        let characterDetailViewController = RMCharacterDetailViewController(characterInputModel: model)
//        characterDetailViewController.coordinator = self
//        navigationController.pushViewController(characterDetailViewController, animated: true)
    }
}

