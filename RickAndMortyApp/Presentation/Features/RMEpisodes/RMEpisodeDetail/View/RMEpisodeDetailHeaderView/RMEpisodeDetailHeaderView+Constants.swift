//
//  RMEpisodeDetailHeaderView+Constants.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import UIKit

// MARK: RMEpisodeDetailHeaderView - Constants

extension RMEpisodeDetailHeaderView {
 
    enum Constants {
        static let shadowViewCornerRadius: CGFloat = 3
        static let shadowViewOffset = CGSize(width: 0, height: 1.75)
        static let shadowViewRadius: CGFloat = 1
        static let shadowViewOpacity: Float = 0.45
    }
    
    enum Localizables {
        static let seasonInfo = "Episodes_Detail_Season"
        static let episodeInfo = "Episodes_Detail_Episode"
        static let releasedInfo = "Episodes_Detail_Released"
    }
    
    enum Fonts {
        static let primary = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
    }
}
