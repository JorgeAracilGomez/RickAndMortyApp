//
//  RMEpisodeTableViewCell+Constants.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import UIKit

// MARK: RMEpisodeTableViewCell - Constants

extension RMEpisodeTableViewCell {
    
    enum Constants {
        static let shadowViewCornerRadius: CGFloat = 3
        static let shadowViewOffset = CGSize(width: 0, height: 1.75)
        static let shadowViewRadius: CGFloat = 1.7
        static let shadowViewOpacity: Float = 0.45
    }
    
    enum Fonts {
        static let season = UIFont(name: "Helvetica-Bold", size: 12)
        static let releaseDate = UIFont(name: "Helvetica-LightOblique", size: 12)
        static let episode = UIFont(name: "Helvetica-Light", size: 16)
    }
    
    enum AccessibilityIdentifiers {
        static let season = "RMEpisodeTableViewCellSeasonLabel"
        static let released = "RMEpisodeTableViewCellReleasedLabel"
        static let title = "RMEpisodeTableViewCellTitleLabel"
    }
}
