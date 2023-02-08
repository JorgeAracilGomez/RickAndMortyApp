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
        static let messageTop: CGFloat = 100.0
        static let messageLeading: CGFloat = 20.0
        static let messageTrailing: CGFloat = 20.0
        static let animationViewLeading: CGFloat = 20.0
        static let animationViewTrailing: CGFloat = 20.0
        static let animationViewBottom: CGFloat = 20.0
    }
    
    func setupMessageLabelConstraints() {
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.messageTop),
            message.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.messageLeading),
            message.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.messageTrailing),
        ])
    }
    
    func setupAnimationViewConstraints() {
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: message.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.animationViewLeading),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.animationViewTrailing),
            animationView.heightAnchor.constraint(equalTo: widthAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constraints.animationViewBottom)
        ])
    }
}
