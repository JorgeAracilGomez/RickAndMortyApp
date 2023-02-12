//
//  RMEpisodeDetailCharacterCell+Constants.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import UIKit

// MARK: RMEpisodeDetailCharacterCell - Constants

extension RMEpisodeDetailCharacterCell {
    
    enum Constants {
        static let shadowViewCornerRadius: CGFloat = 3
        static let shadowViewOffset = CGSize(width: 0, height: 1.75)
        static let shadowViewRadius: CGFloat = 1.7
        static let shadowViewOpacity: Float = 0.45
        static let nameLabelMaxLines = 2
        static let characterImageCornerRadius: CGFloat = 3
        static let stackViewSpacing: CGFloat = 10
    }
    
    enum Fonts {
        static let name = UIFont(name: "Helvetica-Bold", size: 24)
    }
    
    enum Localizables {
        static let status = "Characters_status_Title"
        static let gender = "Characters_gender_Title"
        static let species = "Characters_species_Title"
        static let unknown = "unknown"
    }
}
