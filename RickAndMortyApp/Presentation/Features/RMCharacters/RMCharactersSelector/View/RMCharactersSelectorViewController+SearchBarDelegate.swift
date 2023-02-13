//
//  RMCharactersSelectorViewController+SearchBarDelegate.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import UIKit

// MARK: RMCharactersSelectorViewController - SearchBarDelegate

extension RMCharactersSelectorViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.filterCharacters(withSearchFilter: text)
    }
    
    func searchBarSearchButtonClicked(_: UISearchBar) {
        self.search.searchBar.endEditing(true)
    }
}
