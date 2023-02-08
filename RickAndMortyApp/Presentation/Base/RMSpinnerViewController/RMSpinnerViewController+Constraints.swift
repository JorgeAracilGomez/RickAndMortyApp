//
//  RMSpinnerViewController+Constraints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import UIKit

// MARK: RMSpinnerViewController - Constraints

extension RMSpinnerViewController {
    
    func setupSpinnerViewConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
