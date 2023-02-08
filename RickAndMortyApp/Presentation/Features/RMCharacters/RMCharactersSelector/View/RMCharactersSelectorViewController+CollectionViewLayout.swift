//
//  RMCharactersSelectorViewController+CollectionViewLayout.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

// MARK: RMCharactersSelectorViewController - CollectionViewLayout

class RMCharactersCollectionViewLayout: UICollectionViewFlowLayout {
        
    override init() {
        super.init()
        
        let screenWidth = UIScreen.main.bounds.width
        let widthHeightConstant = UIScreen.main.bounds.width / 2.3
        self.itemSize = CGSize(width: widthHeightConstant, height: widthHeightConstant)
        let numberOfCellsInRow = floor(screenWidth / widthHeightConstant)
        let inset = (screenWidth - (numberOfCellsInRow * widthHeightConstant)) / (numberOfCellsInRow + 1)
        self.sectionInset = .init(top: inset, left: inset, bottom: inset, right: inset)
        self.minimumInteritemSpacing = inset
        self.minimumLineSpacing = inset
        self.scrollDirection = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
