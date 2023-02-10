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
        static let imageViewTop: CGFloat = 20
        static let imageViewHeight: CGFloat = 200
        static let imageViewWidth: CGFloat = 200
        static let statusLabelHeight: CGFloat = 25
        static let statusLabelWidth: CGFloat = 80
        static let statusLabelCenterY: CGFloat = 10
        static let genderInfoViewTop: CGFloat = 20
        static let genderInfoViewLeading: CGFloat = 20
        static let speciesInfoViewLeading: CGFloat = 20
        static let speciesInfoViewTrailing: CGFloat = 20
        static let locationsInfoViewTop: CGFloat = 10
        static let locationsInfoViewLeading: CGFloat = 20
        static let locationsInfoViewTrailing: CGFloat = 20
    }
    
    func setupCharacterImageViewConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.imageViewTop),
            characterImageView.heightAnchor.constraint(equalToConstant: Constraints.imageViewHeight),
            characterImageView.widthAnchor.constraint(equalToConstant: Constraints.imageViewWidth),
            characterImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupStatusLabelConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: Constraints.statusLabelHeight),
            statusLabel.widthAnchor.constraint(equalToConstant: Constraints.statusLabelWidth),
            statusLabel.centerYAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -Constraints.statusLabelCenterY),
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupGenderInfoViewConstraints() {
        NSLayoutConstraint.activate([
            genderInfoView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: Constraints.genderInfoViewTop),
            genderInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.genderInfoViewLeading),
        ])
    }
    
    func setupSpeciesInfoViewConstraints() {
        NSLayoutConstraint.activate([
            speciesInfoView.topAnchor.constraint(equalTo: genderInfoView.topAnchor),
            speciesInfoView.leadingAnchor.constraint(equalTo: genderInfoView.trailingAnchor, constant: Constraints.speciesInfoViewLeading),
            speciesInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.speciesInfoViewTrailing),
            speciesInfoView.widthAnchor.constraint(equalTo: genderInfoView.widthAnchor),
            speciesInfoView.bottomAnchor.constraint(equalTo: genderInfoView.bottomAnchor),
        ])
    }
    
    func setupLocationsInfoViewConstraints() {
        NSLayoutConstraint.activate([
            locationsInfoView.topAnchor.constraint(equalTo: speciesInfoView.bottomAnchor, constant: Constraints.locationsInfoViewTop),
            locationsInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.locationsInfoViewLeading),
            locationsInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.locationsInfoViewTrailing),
            locationsInfoView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
