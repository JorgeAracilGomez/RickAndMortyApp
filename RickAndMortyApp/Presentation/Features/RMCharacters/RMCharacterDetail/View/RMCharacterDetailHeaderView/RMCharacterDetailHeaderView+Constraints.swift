//
//  RMCharacterDetailHeaderView+Constraints.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 9/2/23.
//

import UIKit

// MARK: RMCharacterDetailHeaderView - Constraints

extension RMCharacterDetailHeaderView {
    
    private enum Constraints {
        static let shadowViewBotom: CGFloat = 3.0
        static let imageViewTop: CGFloat = 20
        static let imageViewHeight: CGFloat = 160
        static let imageViewWidth: CGFloat = 160
        static let statusLabelHeight: CGFloat = 25
        static let statusLabelWidth: CGFloat = 80
        static let statusLabelCenterY: CGFloat = 12
        static let genderInfoViewTop: CGFloat = 20
        static let genderInfoViewLeading: CGFloat = 20
        static let speciesInfoViewLeading: CGFloat = 20
        static let speciesInfoViewTrailing: CGFloat = 20
        static let locationsInfoViewTop: CGFloat = 10
        static let locationsInfoViewLeading: CGFloat = 20
        static let locationsInfoViewTrailing: CGFloat = 20
        static let locationsInfoViewBottom: CGFloat = 18.0
    }
    
    func setupShadowViewConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.shadowViewBotom),
        ])
    }
    
    func setupCharacterImageViewConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: Constraints.imageViewTop),
            characterImageView.heightAnchor.constraint(equalToConstant: Constraints.imageViewHeight),
            characterImageView.widthAnchor.constraint(equalToConstant: Constraints.imageViewWidth),
            characterImageView.centerXAnchor.constraint(equalTo: shadowView.centerXAnchor)
        ])
    }
    
    func setupStatusLabelConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: Constraints.statusLabelHeight),
            statusLabel.widthAnchor.constraint(equalToConstant: Constraints.statusLabelWidth),
            statusLabel.centerYAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -Constraints.statusLabelCenterY),
            statusLabel.centerXAnchor.constraint(equalTo: shadowView.centerXAnchor)
        ])
    }
    
    func setupGenderInfoViewConstraints() {
        NSLayoutConstraint.activate([
            genderInfoView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: Constraints.genderInfoViewTop),
            genderInfoView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: Constraints.genderInfoViewLeading),
        ])
    }
    
    func setupSpeciesInfoViewConstraints() {
        NSLayoutConstraint.activate([
            speciesInfoView.topAnchor.constraint(equalTo: genderInfoView.topAnchor),
            speciesInfoView.leadingAnchor.constraint(equalTo: genderInfoView.trailingAnchor, constant: Constraints.speciesInfoViewLeading),
            speciesInfoView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -Constraints.speciesInfoViewTrailing),
            speciesInfoView.widthAnchor.constraint(equalTo: genderInfoView.widthAnchor),
            speciesInfoView.bottomAnchor.constraint(equalTo: genderInfoView.bottomAnchor),
        ])
    }
    
    func setupLocationsInfoViewConstraints() {
        NSLayoutConstraint.activate([
            locationsInfoView.topAnchor.constraint(equalTo: speciesInfoView.bottomAnchor, constant: Constraints.locationsInfoViewTop),
            locationsInfoView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: Constraints.locationsInfoViewLeading),
            locationsInfoView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -Constraints.locationsInfoViewTrailing),
            locationsInfoView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -Constraints.locationsInfoViewBottom),
        ])
    }
}
