//
//  RMEmptyStateView+Constraints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 6/2/23.
//

import UIKit

// MARK: RMEmptyStateView - Constraints

extension RMEmptyStateView {
    
    private enum Constraints {
        static let animationViewLeading: CGFloat = 20.0
        static let animationViewTrailing: CGFloat = 20.0
        static let animationViewBottom: CGFloat = 20.0
    }
    
    func setupAnimationViewConstraints() {
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.animationViewLeading),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.animationViewTrailing),
            animationView.heightAnchor.constraint(equalTo: widthAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constraints.animationViewBottom)
        ])
    }
    
    func setupMessageLabelConstraints() {
        NSLayoutConstraint.activate([
            message.leadingAnchor.constraint(equalTo: leadingAnchor),
            message.trailingAnchor.constraint(equalTo: trailingAnchor),
            message.bottomAnchor.constraint(equalTo: animationView.topAnchor)
        ])
    }
}
