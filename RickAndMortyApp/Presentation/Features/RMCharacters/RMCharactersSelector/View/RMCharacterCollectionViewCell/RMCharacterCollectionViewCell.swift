//
//  RMCharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation
import UIKit

// MARK: RMCharacterCollectionViewCell

final class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    private var model: RMCharacterEntity?
        
    private (set) var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private (set) var nameLabel: UILabel = {
        let nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = Constants.nameLabelMaxLines
        return nameLabel
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.nameLabel.text = nil
    }
}

// MARK: RMCharacterCollectionViewCell - Public Methods

extension RMCharacterCollectionViewCell {
    
    func configure(withModel model: RMCharacterEntity) {
        self.model = model
        setupView()
    }
    
    func getModel() -> RMCharacterEntity? {
        return self.model
    }
}

// MARK: RMCharacterCollectionViewCell - SetupView

extension RMCharacterCollectionViewCell {
    
    private func setupView() {
        setupImageView()
        setupNameLabel()
    }
    
    private func setupImageView() {
        addSubview(imageView)
        setupImageViewConstraints()
    }
    
    func showImageLoaded(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    private func setupNameLabel() {
        guard let name = model?.name else { return }
        addSubview(nameLabel)
        
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.font = Fonts.nameLabel
        nameLabel.text = name
        nameLabel.backgroundColor = Colors.nameLabelBackground
        
        setupNameLabelConstraints()
    }
}
