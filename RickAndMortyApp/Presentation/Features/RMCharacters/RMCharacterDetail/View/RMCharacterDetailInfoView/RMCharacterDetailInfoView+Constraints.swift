//
//  RMCharacterDetailInfoView+Constraints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import UIKit

// MARK: RMCharacterDetailInfoView -  Constraints

extension RMCharacterDetailInfoView {
    
    private enum Constraints {
        static let separatorViewHeight: CGFloat = 2
    }
    
    func setupStackViewContainersConstraints() {
        NSLayoutConstraint.activate([
            stackContainer.topAnchor.constraint(equalTo: topAnchor),
            stackContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupSeparatorViewConstraints() {
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: Constraints.separatorViewHeight),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupSecondaryDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            secondaryDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondaryDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

