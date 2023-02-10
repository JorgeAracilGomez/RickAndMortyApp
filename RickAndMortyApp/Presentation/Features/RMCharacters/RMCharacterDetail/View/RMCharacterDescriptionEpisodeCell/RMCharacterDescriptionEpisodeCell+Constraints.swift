//
//  RMCharacterDescriptionEpisodeCell+Constraints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import UIKit

// MARK: RMCharacterDescriptionEpisodeCell - Constraints

extension RMCharacterDescriptionEpisodeCell {
    
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
    
    func setupSeasonLabelConstraints() {
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: Constraints.seasonLabelTop),
            seasonLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: Constraints.seasonLabelLeading)
        ])
    }
    
    func setupReleaseDateLabelConstraints() {
        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: seasonLabel.topAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: seasonLabel.trailingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -Constraints.releaseDateLabelTrailing),
            releaseDateLabel.widthAnchor.constraint(equalTo: seasonLabel.widthAnchor),
            releaseDateLabel.heightAnchor.constraint(equalTo: seasonLabel.heightAnchor)
        ])
    }
    
    func setupEpisodeLabelConstraints() {
        NSLayoutConstraint.activate([
            episodeLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: Constraints.episodeLabelTop),
            episodeLabel.leadingAnchor.constraint(equalTo: seasonLabel.leadingAnchor),
            episodeLabel.trailingAnchor.constraint(equalTo: releaseDateLabel.trailingAnchor),
            episodeLabel.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -Constraints.episodeLabelBottom),
        ])
    }
}
