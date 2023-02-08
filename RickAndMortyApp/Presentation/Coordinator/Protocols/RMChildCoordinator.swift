//
//  RMChildCoordinator.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import UIKit

protocol RMChildCoordinator: RMCoordinator {
    var parentCoordinator: RMMainCoordinator { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
