//
//  RMHomeTabBarViewController.swift.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

final class RMHomeTabBarViewController: UITabBarController {
    var coordinator: RMMainCoordinator

    init(coordinator: RMMainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        
        let charactersNavigationController = UINavigationController()
        coordinator.showCharactersOperativeWith(navigationController: charactersNavigationController)
        
        let episodesNavigationController = UINavigationController()
        coordinator.showEpisodesOperativeWith(navigationController: episodesNavigationController)

        setViewControllers([charactersNavigationController, episodesNavigationController], animated: true)
    }
}
