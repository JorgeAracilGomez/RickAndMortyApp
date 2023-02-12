//
//  RMEpisodeDetailViewController+Constraints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import UIKit

// MARK: RMEpisodeDetailViewController - Constraints

extension RMEpisodeDetailViewController {
    
    func setupEpisodeHeaderViewConstraints() {
        NSLayoutConstraint.activate([
            episodeHeaderView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            episodeHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            episodeHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupCharactersTableViewConstraints() {
        NSLayoutConstraint.activate([
            charactersTableView.topAnchor.constraint(equalTo: episodeHeaderView.bottomAnchor),
            charactersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
        ])
    }
}
