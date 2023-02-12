//
//  RMEpisodesSelectorViewController+Constraints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import UIKit

// MARK: RMEpisodesSelectorViewController - Constraints

extension RMEpisodesSelectorViewController {
    
    func setupEpisodesTableViewConstraints() {
        NSLayoutConstraint.activate([
            episodesTableView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            episodesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            episodesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            episodesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
