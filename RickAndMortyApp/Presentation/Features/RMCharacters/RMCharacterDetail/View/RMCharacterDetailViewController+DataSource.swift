//
//  RMCharacterDetailViewController+DataSource.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import UIKit

// MARK: RMCharacterDetailTableViewDatasource - TableViewDatasource - CellIdentifiers

extension RMCharacterDetailTableViewDatasource {
    enum CellIdentifiers {
        static let episodeTableViewCell = "RMEpisodeTableViewCell"
    }
}

// MARK: RMCharacterDetailTableViewDatasource - TableViewDatasource

final class RMCharacterDetailTableViewDatasource: NSObject, UITableViewDataSource {
    
    var tableView: UITableView
    var viewModel: RMCharacterDetailViewModel
    
    init(tableView: UITableView, viewModel: RMCharacterDetailViewModel) {
        self.tableView = tableView
        self.viewModel = viewModel
    }
    
    func registerCells() {
        tableView.register(RMEpisodeTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.episodeTableViewCell)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Episodes_Featured_Title".localized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.value?.episodes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let episode = self.viewModel.model.value?.episodes[indexPath.row],
           let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.episodeTableViewCell, for: indexPath) as? RMEpisodeTableViewCell {
            
            cell.selectionStyle = .none
            cell.configure(withSeason: episode.episode, withReleaseDate: episode.airDate, withEpisode: episode.name)
            return cell
        }
        
        return UITableViewCell()
    }
}
