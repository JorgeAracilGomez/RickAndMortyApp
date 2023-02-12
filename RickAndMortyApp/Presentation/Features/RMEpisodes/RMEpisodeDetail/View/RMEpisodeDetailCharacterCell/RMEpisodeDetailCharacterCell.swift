//
//  RMEpisodeDetailCharacterCell.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import UIKit

// MARK: RMEpisodeDetailCharacterCell

final class RMEpisodeDetailCharacterCell: UITableViewCell {
    
    private var character: RMCharacterEntity?
    
    private (set) var shadowView: UIView = {
        let shadowView = UIView(frame: .zero)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        return shadowView
    }()
    
    private (set) var nameLabel: UILabel = {
        let nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private (set) var characterImage: UIImageView = {
        let characterImage = UIImageView(frame: .zero)
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        return characterImage
    }()
    
    private (set) var characterInfoStackView: UIStackView = {
        let characterInfoStackView = UIStackView(frame: .zero)
        characterInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        return characterInfoStackView
    }()
    
    private (set) var statusView: RMCharacterDetailInfoView = {
        let statusView = RMCharacterDetailInfoView(frame: .zero)
        statusView.translatesAutoresizingMaskIntoConstraints = false
        return statusView
    }()
    
    private (set) var genderView: RMCharacterDetailInfoView = {
        let genderView = RMCharacterDetailInfoView(frame: .zero)
        genderView.translatesAutoresizingMaskIntoConstraints = false
        return genderView
    }()
    
    private (set) var speciesView: RMCharacterDetailInfoView = {
        let speciesView = RMCharacterDetailInfoView(frame: .zero)
        speciesView.translatesAutoresizingMaskIntoConstraints = false
        return speciesView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        characterImage.image = nil
    }
}

// MARK: RMEpisodeDetailCharacterCell - Public Methods

extension RMEpisodeDetailCharacterCell {
    
    func configure(forCharacter character: RMCharacterEntity?) {
        self.character = character
        setupView()
    }
}

// MARK: RMEpisodeDetailCharacterCell - Setup View

extension RMEpisodeDetailCharacterCell {
    
    private func setupView() {
        self.backgroundColor = .clear
        setupShadowView()
        setupNameLabel()
        setupCharacterImageView()
        setupCharacterInfoStackView()
        setupStatusView()
        setupGenderView()
        setupSpeciesView()
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
    
    private func setupNameLabel() {
        shadowView.addSubview(nameLabel)
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        nameLabel.font = Fonts.name
        nameLabel.numberOfLines = Constants.nameLabelMaxLines
        nameLabel.text = character?.name
        nameLabel.backgroundColor = .white
        setupNameLabelConstraints()
    }
    
    private func setupCharacterImageView() {
        addSubview(characterImage)
        characterImage.layer.cornerRadius = Constants.characterImageCornerRadius
        characterImage.layer.masksToBounds = true
        if let imageKey = character?.image {
            RMImageCacheMannager.shared.loadImage(forKey: imageKey, completion: { [weak self] imageData in
                guard let _ = self, let imageData = imageData, let image = UIImage(data: imageData) else { return }
                self?.showImageLoaded(image)
            })
        }
        setupImageViewConstraints()
    }
    
    func showImageLoaded(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.characterImage.image = image
        }
    }
    
    private func setupCharacterInfoStackView() {
        shadowView.addSubview(characterInfoStackView)
        characterInfoStackView.distribution = .fillEqually
        characterInfoStackView.axis = .horizontal
        characterInfoStackView.alignment = .center
        characterInfoStackView.spacing = Constants.stackViewSpacing
        setupCharacterInfoStackViewConstraints()
    }
    
    private func setupStatusView() {
        characterInfoStackView.addArrangedSubview(statusView)
        statusView.configure(withTitle: Localizables.status.localized,
                             withDescription: character?.status?.rawValue ?? Localizables.unknown.localized)
    }
    
    private func setupGenderView() {
        characterInfoStackView.addArrangedSubview(genderView)
        genderView.configure(withTitle: Localizables.gender.localized,
                             withDescription: character?.gender?.rawValue ?? Localizables.unknown.localized)
    }
    
    private func setupSpeciesView() {
        characterInfoStackView.addArrangedSubview(speciesView)
        speciesView.configure(withTitle: Localizables.species.localized,
                              withDescription: character?.species ?? Localizables.unknown.localized)
    }
}
