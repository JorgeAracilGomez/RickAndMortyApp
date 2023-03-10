//
//  RMEpisodeDetailCharacterCell+Constraints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import UIKit

// MARK: RMEpisodeDetailCharacterCell - Constraints

extension RMEpisodeDetailCharacterCell {
    
    private enum Constraints {
        static let shadowViewTop: CGFloat = 7
        static let shadowViewLeading: CGFloat = 15
        static let shadowViewTrailing: CGFloat = 15
        static let shadowViewBottom: CGFloat = 7
        static let nameLabelTop: CGFloat = 10
        static let nameLabelLeading: CGFloat = 10
        static let nameLabelTrailing: CGFloat = 10
        static let characterImageTop: CGFloat = 10
        static let characterImageHeight: CGFloat = 80
        static let characterImageBottom: CGFloat = 10
        static let characterInfoLeading: CGFloat = 10
    }
    
    func setupShadowViewConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.shadowViewTop),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.shadowViewLeading),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.shadowViewTrailing),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.shadowViewBottom)
        ])
    }
    
    func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: Constraints.nameLabelTop),
            nameLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: Constraints.nameLabelLeading),
            nameLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -Constraints.nameLabelTrailing),
        ])
    }
    
    func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constraints.characterImageTop),
            characterImage.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: Constraints.characterImageHeight),
            characterImage.widthAnchor.constraint(equalTo: characterImage.heightAnchor),
            characterImage.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -Constraints.characterImageBottom),
        ])
    }
    
    func setupCharacterInfoStackViewConstraints() {
        NSLayoutConstraint.activate([
            characterInfoStackView.topAnchor.constraint(equalTo: characterImage.topAnchor),
            characterInfoStackView.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: Constraints.characterInfoLeading),
            characterInfoStackView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            characterInfoStackView.bottomAnchor.constraint(equalTo: characterImage.bottomAnchor)
        ])
    }
}
