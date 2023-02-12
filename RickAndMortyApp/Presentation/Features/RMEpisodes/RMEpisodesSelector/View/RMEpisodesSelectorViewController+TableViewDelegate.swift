//
//  RMEpisodesSelectorViewController+TableViewDelegate.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import UIKit

// MARK: RMEpisodesSelectorViewController - TableViewDelegate

final class RMEpisodesTableViewDelegate: NSObject, UITableViewDelegate {
    
    private var viewModel: RMEpisodesSelectorViewModel
    
    init(viewModel: RMEpisodesSelectorViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        mannageDownloadNewData(forSection: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCell(atIndex: indexPath.row)
    }
    
    func mannageDownloadNewData(forSection section: Int) {
        if let section = RMEpisodesTableSection(rawValue: section), section == .loader {
            viewModel.fetchNewEpisodes()
        }
    }
}
