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
        static let seasonLabelTop: CGFloat = 10
        static let seasonLabelLeading: CGFloat = 10
        static let releaseDateLabelTrailing: CGFloat = 10
        static let episodeLabelTop: CGFloat = 10
        static let episodeLabelBottom: CGFloat = 10
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
            nameLabel.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -10),
        ])
    }
    
    func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            characterImage.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: 80),
            characterImage.widthAnchor.constraint(equalTo: characterImage.heightAnchor),
            characterImage.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -10),
        ])
    }
    
    func setupCharacterInfoStackViewConstraints() {
        NSLayoutConstraint.activate([
            characterInfoStackView.topAnchor.constraint(equalTo: characterImage.topAnchor),
            characterInfoStackView.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 10),
            characterInfoStackView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            characterInfoStackView.bottomAnchor.constraint(equalTo: characterImage.bottomAnchor)
        ])
    }
}
