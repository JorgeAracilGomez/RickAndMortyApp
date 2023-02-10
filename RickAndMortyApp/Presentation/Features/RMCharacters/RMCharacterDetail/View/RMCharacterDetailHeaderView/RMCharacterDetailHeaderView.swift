//
//  RMCharacterDetailHeaderView.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 9/2/23.
//

import UIKit

// MARK: RMCharacterDetailHeaderView

final class RMCharacterDetailHeaderView: UIView {
    
    private var model: RMCharacterDetailModel?
    
    private (set) var shadowView: UIView = {
        let shadowView = UIView(frame: .zero)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        return shadowView
    }()
    
    private (set) var characterImageView: UIImageView = {
        let characterImageView = UIImageView(frame: .zero)
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        return characterImageView
    }()
    
    private (set) var statusLabel: UILabel = {
        let statusLabel = UILabel(frame: .zero)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    private (set) var genderInfoView: RMCharacterDetailInfoView = {
        let genderInfoView = RMCharacterDetailInfoView(frame: .zero)
        genderInfoView.translatesAutoresizingMaskIntoConstraints = false
        return genderInfoView
    }()
    
    private (set) var speciesInfoView: RMCharacterDetailInfoView = {
        let speciesInfoView = RMCharacterDetailInfoView(frame: .zero)
        speciesInfoView.translatesAutoresizingMaskIntoConstraints = false
        return speciesInfoView
    }()
    
    private (set) var locationsInfoView: RMCharacterDetailInfoView = {
        let locationsInfoView = RMCharacterDetailInfoView(frame: .zero)
        locationsInfoView.translatesAutoresizingMaskIntoConstraints = false
        return locationsInfoView
    }()
}

// MARK: RMCharacterDetailHeaderView - Public methods

extension RMCharacterDetailHeaderView {
    
    public func configure(withModel model: RMCharacterDetailModel) {
        self.model = model
        setupView()
    }
}

// MARK: RMCharacterDetailHeaderView - Setup View

extension RMCharacterDetailHeaderView {
    
    private func setupView() {
        setupShadowView()
        setupCharacterImageView()
        setupStatusLabel()
        setupGenderInfoView()
        setupSpeciesInfoView()
        setupLocationsInfoView()
    }
    
    private func setupShadowView() {
        addSubview(shadowView)
        shadowView.backgroundColor = .white
        shadowView.layer.cornerRadius = Constants.shadowViewCornerRadius
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOffset = Constants.shadowViewOffset
        shadowView.layer.shadowRadius = Constants.shadowViewRadius
        shadowView.layer.shadowOpacity = Constants.shadowViewOpacity
        setupShadowViewConstraints()
    }
    
    private func setupCharacterImageView() {
        shadowView.addSubview(characterImageView)
        characterImageView.layer.borderWidth = Constants.characterImageBorderWidth
        characterImageView.layer.cornerRadius = Constants.characterImageCornerRadius
        characterImageView.layer.borderColor = getStatusColor(for: model?.status).cgColor
        characterImageView.layer.masksToBounds = true
        
        if let imageKey = model?.imagePath {
            RMImageCacheMannager.shared.loadImage(forKey: imageKey, completion: { [weak self] imageData in
                guard let self = self, let imageData = imageData else { return }
                DispatchQueue.main.async {
                    self.characterImageView.image = UIImage(data: imageData)
                }
            })
        }
        
        setupCharacterImageViewConstraints()
    }
    
    private func setupStatusLabel() {
        shadowView.addSubview(statusLabel)
        statusLabel.backgroundColor = getStatusColor(for: model?.status)
        statusLabel.font = Fonts.status
        statusLabel.text = model?.status.rawValue
        statusLabel.textAlignment = .center
        statusLabel.layer.cornerRadius = Constants.statusLabelCornerRadius
        statusLabel.layer.masksToBounds = true
        setupStatusLabelConstraints()
    }
    
    private func getStatusColor(for status: RMCharacterStatusEntity?) -> UIColor {
        switch status {
        case .Alive:
            return Colors.alive
        case .Dead:
            return Colors.dead
        case .Unknown, .none:
            return Colors.unknown
        }
    }
    
    private func setupGenderInfoView() {
        shadowView.addSubview(genderInfoView)
        genderInfoView.configure(withTitle: Localizables.genderTitle.localized,
                                 withDescription: model?.gender ?? Localizables.unknown.localized)
        setupGenderInfoViewConstraints()
    }
    
    private func setupSpeciesInfoView() {
        shadowView.addSubview(speciesInfoView)
        speciesInfoView.configure(withTitle: Localizables.speciesTitle.localized,
                                   withDescription: model?.species ?? Localizables.unknown.localized)
        setupSpeciesInfoViewConstraints()
    }
    
    private func setupLocationsInfoView() {
        shadowView.addSubview(locationsInfoView)
        locationsInfoView.configure(withTitle: Localizables.originLocationTitle.localized,
                                    withDescription: model?.origin.name ?? Localizables.unknown.localized,
                                    withSecondaryDescription: model?.location.name)
        setupLocationsInfoViewConstraints()
    }
}
