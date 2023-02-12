//
//  RMEpisodeDetailViewController+Datasource.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import UIKit

// MARK: RMEpisodeDetailTableViewDatasource - CellIdentifiers

extension RMEpisodeDetailTableViewDatasource {
    enum CellIdentifiers {
        static let characterTableViewCell = "RMEpisodeDetailCharacterCell"
    }
}

// MARK: RMEpisodeDetailTableViewDatasource - TableViewDatasource

final class RMEpisodeDetailTableViewDatasource: NSObject, UITableViewDataSource {
    
    var tableView: UITableView
    var viewModel: RMEpisodeDetailViewModel
    
    init(tableView: UITableView, viewModel: RMEpisodeDetailViewModel) {
        self.tableView = tableView
        self.viewModel = viewModel
    }
    
    func registerCells() {
        tableView.register(RMEpisodeDetailCharacterCell.self, forCellReuseIdentifier: CellIdentifiers.characterTableViewCell)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Characters_Featured_Title".localized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.value?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let character = self.viewModel.model.value?.characters[indexPath.row],
           let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.characterTableViewCell, for: indexPath) as? RMEpisodeDetailCharacterCell {
            
            cell.selectionStyle = .none
            cell.configure(forCharacter: character)
            return cell
        }
        
        return UITableViewCell()
    }
}
