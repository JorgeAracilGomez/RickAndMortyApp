//
//  RMCharactersSelectorViewController+CollectionViewDataSource.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

// MARK: CellIdentifiers

extension RMCharactersCollectionViewDataSource {
    enum CellIdentifiers {
        static let characterCollectionViewCell = "RMCharacterCollectionViewCell"
        static let loadingCollectionViewCell = "RMLoadingCollectionViewCell"
    }
}

// MARK: RMCharactersSelectorViewController - CollectionViewDatasource

final class RMCharactersCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var collectionView: UICollectionView
    var viewModel: RMCharactersSelectorViewModel
    var isFetchDataFinished: Bool = false
    
    init(collectionView: UICollectionView, viewModel: RMCharactersSelectorViewModel) {
        self.collectionView = collectionView
        self.viewModel = viewModel
    }
    
    func registerCells() {
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.characterCollectionViewCell)
        collectionView.register(RMLoadingCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.loadingCollectionViewCell)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // According to CharactersCollectionSection:
        // returns 1 section if it has finished downloading information and 2 if not (Loading)
        return viewModel.model.value?.isFetchDataFinished ?? false ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let listSection = RMCharactersCollectionSection(rawValue: section),
              let charactersCount = self.viewModel.model.value?.characters.count else { return 0 }
        switch listSection {
        case .charactersList:
            return charactersCount
        case .loader:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = RMCharactersCollectionSection(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch section {
        case .charactersList:
            if let model = self.viewModel.model.value?.characters[indexPath.row],
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.characterCollectionViewCell, for: indexPath) as? RMCharacterCollectionViewCell {
                            
                cell.configure(withModel: model)
                return cell
            }
        case .loader:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.loadingCollectionViewCell, for: indexPath) as? RMLoadingCollectionViewCell {
                
                cell.configure()
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}
