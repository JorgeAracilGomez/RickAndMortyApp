//
//  RMEpisodeDetailHeaderView.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import UIKit

// MARK: RMEpisodeDetailHeaderView

final class RMEpisodeDetailHeaderView: UIView {
    
    private var model: RMEpisodeDetailModel?
    
    private (set) var shadowView: UIView = {
        let shadowView = UIView(frame: .zero)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        return shadowView
    }()
    
    private (set) var seasonLabel: UILabel = {
        let seasonLabel = UILabel(frame: .zero)
        seasonLabel.translatesAutoresizingMaskIntoConstraints = false
        return seasonLabel
    }()
    
    private (set) var episodeLabel: UILabel = {
        let episodeLabel = UILabel(frame: .zero)
        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        return episodeLabel
    }()
    
    private (set) var releasedLabel: UILabel = {
        let releasedLabel = UILabel(frame: .zero)
        releasedLabel.translatesAutoresizingMaskIntoConstraints = false
        return releasedLabel
    }()
}

// MARK: RMEpisodeDetailHeaderView - Public methods

extension RMEpisodeDetailHeaderView {
    
    public func configure(withModel model: RMEpisodeDetailModel) {
        self.model = model
        setupView()
    }
}

// MARK: RMEpisodeDetailHeaderView - Setup View

extension RMEpisodeDetailHeaderView {
    
    private func setupView() {
        setupShadowView()
        setupSeasonLabel()
        setupEpisodeLabel()
        setupReleasedLabel()
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
        
    private func setupSeasonLabel() {
        shadowView.addSubview(seasonLabel)
        seasonLabel.textAlignment = .left
        seasonLabel.textColor = .darkGray
        seasonLabel.font = Fonts.primary
        if let season = model?.season {
            seasonLabel.text = String(format: Localizables.seasonInfo.localized, season)
        }
        seasonLabel.accessibilityIdentifier = AccessibilityIdentifiers.seasonLabel
        setupSeasonLabelConstraints()
    }
    
    private func setupEpisodeLabel() {
        shadowView.addSubview(episodeLabel)
        episodeLabel.textAlignment = .left
        episodeLabel.textColor = .darkGray
        episodeLabel.font = Fonts.primary
        if let episode = model?.episode {
            episodeLabel.text = String(format: Localizables.episodeInfo.localized, episode)
        }
        episodeLabel.accessibilityIdentifier = AccessibilityIdentifiers.episodeLabel
        setupEpisodeLabelConstraints()
    }
    
    private func setupReleasedLabel() {
        shadowView.addSubview(releasedLabel)
        releasedLabel.textAlignment = .left
        releasedLabel.textColor = .darkGray
        releasedLabel.font = Fonts.primary
        if let airDate = model?.airDate {
            releasedLabel.text = String(format: Localizables.releasedInfo.localized, airDate)
        }
        releasedLabel.accessibilityIdentifier = AccessibilityIdentifiers.releasedLabel
        setupReleasedLabelConstraints()
    }
}
