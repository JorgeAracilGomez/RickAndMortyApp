//
//  RMEpisodesSelectorViewController+TableViewDatasource.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import UIKit

// MARK: RMEpisodesSelectorViewController - TableViewDatasource - CellIdentifiers

extension RMEpisodesTableViewDataSource {
    enum CellIdentifiers {
        static let episodeTableViewCell = "RMEpisodeTableViewCell"
        static let loadingTableViewCell = "RMLoadingTableViewCell"
    }
}

// MARK: RMEpisodesSelectorViewController - TableViewDatasource

final class RMEpisodesTableViewDataSource: NSObject, UITableViewDataSource {
    
    var tableView: UITableView
    var viewModel: RMEpisodesSelectorViewModel
    let pageLimit: Int = 20
    
    init(tableView: UITableView, viewModel: RMEpisodesSelectorViewModel) {
        self.tableView = tableView
        self.viewModel = viewModel
    }
    
    func registerCells() {
        tableView.register(RMEpisodeTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.episodeTableViewCell)
        tableView.register(RMLoadingTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.loadingTableViewCell)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // According to RMEpisodesTableSection:
        // returns 1 section if it has finished downloading information and 2 if not (Loading)
        return viewModel.model.value?.isFetchDataFinished ?? false ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = RMEpisodesTableSection(rawValue: section),
              let episodesCount = self.viewModel.model.value?.episodes.count else { return 0 }
        
        switch listSection {
        case .episodesList:
            return episodesCount
        case .loader:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = RMEpisodesTableSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .episodesList:
            if let episode = self.viewModel.model.value?.episodes[indexPath.row],
               let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.episodeTableViewCell, for: indexPath) as? RMEpisodeTableViewCell {
                
                cell.selectionStyle = .none
                cell.configure(withSeason: episode.episode,
                               withReleaseDate: episode.airDate,
                               withEpisode: episode.name)
                return cell
            }
        case .loader:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.loadingTableViewCell, for: indexPath) as? RMLoadingTableViewCell {
                
                cell.configure()
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

