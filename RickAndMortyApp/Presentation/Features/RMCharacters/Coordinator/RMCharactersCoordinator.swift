//
//  RMCharactersCoordinator.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

class RMCharactersCoordinator: RMChildCoordinator {
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

extension RMCharactersCoordinator {
   
    /// This method is responsible for initializing the Operative.
    func start() {
        let characterSelectionViewController = RMCharactersSelectorViewController()
        characterSelectionViewController.coordinator = self
        characterSelectionViewController.title = "Characters" // MISCO LOCALIZABLE
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(characterSelectionViewController, animated: false)
    }
    
    /// This method navigates to the Character detail screen.
    /// - Parameter model: Model that contains the information of the character for which you want to obtain the detail view.
    func showCharacterDetail(for model: RMCharacterEntity) {
        let characterDetailViewController = RMCharacterDetailViewController(characterInputModel: model)
        characterDetailViewController.coordinator = self
        navigationController.pushViewController(characterDetailViewController, animated: true)
    }
}
