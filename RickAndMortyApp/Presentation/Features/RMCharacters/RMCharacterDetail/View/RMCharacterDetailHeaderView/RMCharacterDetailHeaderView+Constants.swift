//
//  RMCharacterDetailHeaderView+Constants.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 9/2/23.
//

import UIKit

// MARK: RMCharacterDetailHeaderView - Constants

extension RMCharacterDetailHeaderView {
 
    enum Constants {
        static let characterImageBorderWidth: CGFloat = 4
        static let characterImageCornerRadius: CGFloat = 80
        static let statusLabelCornerRadius: CGFloat = 5
        static let shadowViewCornerRadius: CGFloat = 3
        static let shadowViewOffset = CGSize(width: 0, height: 1.75)
        static let shadowViewRadius: CGFloat = 1
        static let shadowViewOpacity: Float = 0.45
    }
    
    enum Localizables {
        static let genderTitle = "Characters_gender_Title"
        static let speciesTitle = "Characters_species_Title"
        static let originLocationTitle = "Characters_OriginLocation_Title"
        static let unknown = "unknown"
    }
    
    enum Colors {
        static let alive: UIColor = .green
        static let dead: UIColor = .red
        static let unknown: UIColor = .gray
    }
    
    enum Fonts {
        static let status = UIFont(name: "Helvetica-Bold", size: 16)
    }
}
