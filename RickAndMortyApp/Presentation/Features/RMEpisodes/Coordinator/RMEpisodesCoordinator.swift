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
        let episodeDetailViewController = RMEpisodeDetailViewController(episodeInputModel: model)
        episodeDetailViewController.coordinator = self
        navigationController.pushViewController(episodeDetailViewController, animated: true)
    }
    
    /// This method shows an error popup of type Alert
    /// - Parameter error: Model of the error that has occurred
    func showAlert(error: RMError?) {
        let alertTitle = "Error_Alert_Title".localized
        let alertDescription = "Error_Alert_Description".localized
        let alertButtonText = "Error_Alert_Accept".localized
        let alertController = UIAlertController(title: alertTitle, message: alertDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: alertButtonText, style: .default) { _ in
            self.navigationController.popViewController(animated: true)
        }
        alertController.addAction(action)
        navigationController.present(alertController, animated: true)
    }
}

