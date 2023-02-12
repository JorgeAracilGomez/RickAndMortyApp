//
//  RMEpisodeDetailHeaderView+Constraints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import UIKit

// MARK: RMEpisodeDetailHeaderView - Constraints

extension RMEpisodeDetailHeaderView {
    
    private enum Constraints {
        static let shadowViewBotom: CGFloat = 3.0
        static let titleLabelLeading: CGFloat = 20
        static let titleLabelTrailing: CGFloat = 20
        static let releasedLabelBottom: CGFloat = 20
    }
    
    func setupShadowViewConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.shadowViewBotom),
        ])
    }
    
    func setupSeasonLabelConstraints() {
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: shadowView.topAnchor),
            seasonLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: Constraints.titleLabelLeading),
            seasonLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -Constraints.titleLabelTrailing),
        ])
    }
    
    func setupEpisodeLabelConstraints() {
        NSLayoutConstraint.activate([
            episodeLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            episodeLabel.leadingAnchor.constraint(equalTo: seasonLabel.leadingAnchor),
            episodeLabel.trailingAnchor.constraint(equalTo: seasonLabel.trailingAnchor),
        ])
    }
    
    func setupReleasedLabelConstraints() {
        NSLayoutConstraint.activate([
            releasedLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor),
            releasedLabel.leadingAnchor.constraint(equalTo: seasonLabel.leadingAnchor),
            releasedLabel.trailingAnchor.constraint(equalTo: seasonLabel.trailingAnchor),
            releasedLabel.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -Constraints.releasedLabelBottom)
        ])
    }
}
