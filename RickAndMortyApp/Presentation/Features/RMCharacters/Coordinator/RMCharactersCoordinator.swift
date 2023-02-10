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
        characterSelectionViewController.title = "Characters_Navigation_Title".localized
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
