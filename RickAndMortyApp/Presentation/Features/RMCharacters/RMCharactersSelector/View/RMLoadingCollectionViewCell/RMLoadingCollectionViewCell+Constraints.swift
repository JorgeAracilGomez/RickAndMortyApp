//
//  RMLoadingCollectionViewCell+Constraints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

// MARK: RMLoadingCollectionViewCell - Constraints

extension RMLoadingCollectionViewCell {
    
    func setupAnimationViewConstraints() {
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
