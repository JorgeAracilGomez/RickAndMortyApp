//
//  RMCharacterCollectionViewCell+Constants.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

// MARK: RMCharacterCollectionViewCell - Constants

extension RMCharacterCollectionViewCell {
    
    enum Constants {
        static let nameLabelMaxLines = 0
    }
    
    enum Colors {
        static let nameLabelBackground = UIColor.black.withAlphaComponent(0.4)
    }
    
    enum Fonts {
        static let nameLabel = UIFont(name: "Arial-BoldItalicMT", size: 20.0)
    }
    
    enum AccessibilityIdentifiers {
        static let image = "RMCharacterCollectionViewCellImage"
        static let name = "RMCharacterCollectionViewCellNameLabel"
    }
}
