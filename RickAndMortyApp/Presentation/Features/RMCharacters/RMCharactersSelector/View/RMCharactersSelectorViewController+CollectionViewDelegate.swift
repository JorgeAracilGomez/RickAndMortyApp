//
//  RMCharactersSelectorViewController+CollectionViewDelegate.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

// MARK: RMCharactersSelectorViewController - CollectionViewDelegate

final class RMCharactersCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    private var viewModel: RMCharactersSelectorViewModel
    
    init(viewModel: RMCharactersSelectorViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCell(atIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        mannageDownloadImage(forCell: cell)
        mannageDownloadNewData(forSection: indexPath.section)
    }
    
    func mannageDownloadImage(forCell cell: UICollectionViewCell) {
        if let cell = cell as? RMCharacterCollectionViewCell, let imageModel = cell.getModel()?.image {
            RMImageCacheMannager.shared.loadImage(forKey: imageModel, completion: { [weak self] imageData in
                guard let _ = self, let imageData = imageData, let image = UIImage(data: imageData) else { return }
                cell.showImageLoaded(image)
            })
        }
    }
    
    func mannageDownloadNewData(forSection section: Int) {
        if let section = RMCharactersCollectionSection(rawValue: section), section == .loader {
            viewModel.fetchNewCharacters()
        }
    }
}


extension RMCharactersCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        guard let customLayout = collectionViewLayout as? RMCharactersCollectionViewLayout,
              let section = RMCharactersCollectionSection(rawValue: indexPath.section) else {
            return CGSize()
        }
        
        switch section {
        case .charactersList:
            // Configuration for 2 items in a row
            let width: CGFloat = collectionView.bounds.width/2 - (2 * customLayout.minimumInteritemSpacing)
            return CGSize(width: width, height: width)
        case .loader:
            // Configuration for 1 item in a row
            let width: CGFloat = collectionView.bounds.width - (2 * customLayout.minimumInteritemSpacing)
            return CGSize(width: width, height: 50)
        }
    }
}

