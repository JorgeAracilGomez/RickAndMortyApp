//
//  RMCharacterDetailViewController+Constraints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import UIKit

// MARK: RMCharacterDetailViewController - Constraints

extension RMCharacterDetailViewController {
    
    func setupCharacterHeaderViewConstraints() {
        NSLayoutConstraint.activate([
            characterHeaderView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            characterHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
