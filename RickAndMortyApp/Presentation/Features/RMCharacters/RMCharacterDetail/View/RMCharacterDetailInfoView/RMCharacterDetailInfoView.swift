//
//  RMCharacterDetailInfoView.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import UIKit

// MARK: RMCharacterDetailInfoView

final class RMCharacterDetailInfoView: UIView {
    
    private var titleText: String?
    private var descriptionText: String?
    private var secondaryDescriptionText: String?
    
    private (set) var stackContainer: UIStackView = {
        let stackContainer = UIStackView()
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        return stackContainer
    }()
    
    private (set) var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private (set) var separatorView: UIView = {
        let separatorView = UILabel(frame: .zero)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()
    
    private (set) var descriptionIcon: UIImageView = {
        let descriptionIcon = UIImageView(frame: .zero)
        descriptionIcon.translatesAutoresizingMaskIntoConstraints = false
        return descriptionIcon
    }()
    
    private (set) var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private (set) var secondaryDescriptionIcon: UIImageView = {
        let secondaryDescriptionIcon = UIImageView(frame: .zero)
        secondaryDescriptionIcon.translatesAutoresizingMaskIntoConstraints = false
        return secondaryDescriptionIcon
    }()
    
    private (set) var secondaryDescriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
}

// MARK: RMCharacterDetailInfoView - Public methods

extension RMCharacterDetailInfoView {
    
    public func configure(withTitle title: String,
                          withDescription description: String,
                          withSecondaryDescription secondaryDescription: String? = nil) {
        self.titleText = title
        self.descriptionText = description
        self.secondaryDescriptionText = secondaryDescription
        setupView()
    }
}

// MARK: RMCharacterDetailLocationInnerView - Setup View

extension RMCharacterDetailInfoView {
    
    private func setupView() {
        setupStackViewContainer()
        setupTitleLabel()
        setupSeparatorView()
        setupDescriptionLabel()
        setupSecondaryDescriptionLabel()
    }
    
    private func setupStackViewContainer() {
        addSubview(stackContainer)
        stackContainer.axis = NSLayoutConstraint.Axis.vertical
        stackContainer.distribution = UIStackView.Distribution.equalSpacing
        stackContainer.alignment = UIStackView.Alignment.center
        stackContainer.spacing = Constants.stackContainerSpacing
        setupStackViewContainersConstraints()
    }
    
    private func setupTitleLabel() {
        stackContainer.addArrangedSubview(titleLabel)
        let title = titleText?.isEmpty ?? true ? Localizables.unknown.localized : titleText
        titleLabel.font = Fonts.title
        titleLabel.text = title
        titleLabel.textAlignment = .center
        setupTitleLabelConstraints()
    }
    
    private func setupSeparatorView() {
        stackContainer.addArrangedSubview(separatorView)
        separatorView.backgroundColor = Colors.seperator
        setupSeparatorViewConstraints()
    }
    
    private func setupDescriptionLabel() {
        stackContainer.addArrangedSubview(descriptionLabel)
        let description = descriptionText?.isEmpty ?? true ? Localizables.unknown.localized : descriptionText
        descriptionLabel.font = Fonts.description
        descriptionLabel.text = description
        descriptionLabel.textAlignment = .center
        setupDescriptionLabelConstraints()
    }
    
    private func setupSecondaryDescriptionLabel() {
        guard let secondaryDescriptionText else { return }
        stackContainer.addArrangedSubview(secondaryDescriptionLabel)
        let secondaryDescription = secondaryDescriptionText.isEmpty ? Localizables.unknown.localized : secondaryDescriptionText
        secondaryDescriptionLabel.font = Fonts.description
        secondaryDescriptionLabel.text = secondaryDescription
        secondaryDescriptionLabel.textAlignment = .center
        setupSecondaryDescriptionLabelConstraints()
    }
}
