//
//  RMCharacterDetailInfoView+Constants.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import UIKit

// MARK: RMCharacterDetailInfoView - Constants

extension RMCharacterDetailInfoView {
    
    enum Constants {
        static let stackContainerSpacing: CGFloat = 5
    }
    
    enum Localizables {
        static let unknown = "unknown"
    }
    
    enum Colors {
        static let seperator: UIColor = .black
    }
    
    enum Fonts {
        static let title = UIFont(name: "Helvetica-Bold", size: 12)
        static let description = UIFont(name: "Helvetica-Light", size: 16)
    }
    
    enum AccessibilityIdentifiers {
        static let title = "RMCharacterDetailInfoViewTitle"
        static let separator = "RMCharacterDetailInfoViewSeparator"
        static let description = "RMCharacterDetailInfoViewDescription"
        static let secondaryDescription = "RMCharacterDetailInfoViewSecondaryDescription"
    }
}
