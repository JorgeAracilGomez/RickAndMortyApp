//
//  RMCharacterDescriptionEpisodeCell.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 10/2/23.
//

import UIKit

// MARK: RMCharacterDescriptionEpisodeCell

final class RMCharacterDescriptionEpisodeCell: UITableViewCell {
    
    private var seasonTitle: String?
    private var releaseDate: String?
    private var espisodeTitle: String?
    
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
    
    private (set) var releaseDateLabel: UILabel = {
        let releaseDateLabel = UILabel(frame: .zero)
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return releaseDateLabel
    }()
    
    private (set) var episodeLabel: UILabel = {
        let episodeLabel = UILabel(frame: .zero)
        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        return episodeLabel
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.seasonLabel.text = nil
        self.releaseDateLabel.text = nil
        self.episodeLabel.text = nil
    }
}

// MARK: RMCharacterDescriptionEpisodeCell - Public Methods

extension RMCharacterDescriptionEpisodeCell {
    
    func configure(withSeason season: String?,
                   withReleaseDate releaseDate: String?,
                   withEpisode episode: String?) {
        
        self.seasonTitle = season
        self.releaseDate = releaseDate
        self.espisodeTitle = episode
        setupView()
    }
}

// MARK: RMCharacterDescriptionEpisodeCell - Setup View

extension RMCharacterDescriptionEpisodeCell {
    
    private func setupView() {
        self.backgroundColor = .clear
        setupShadowView()
        setupSeasonLabel()
        setupReleaseDateLabel()
        setupEpisodeLabel()
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
        seasonLabel.textColor = .black
        seasonLabel.font = Fonts.season
        seasonLabel.text = seasonTitle
        setupSeasonLabelConstraints()
    }
    
    private func setupReleaseDateLabel() {
        shadowView.addSubview(releaseDateLabel)
        releaseDateLabel.textAlignment = .right
        releaseDateLabel.textColor = .gray
        releaseDateLabel.font = Fonts.releaseDate
        releaseDateLabel.text = releaseDate
        setupReleaseDateLabelConstraints()
    }
    
    private func setupEpisodeLabel() {
        shadowView.addSubview(episodeLabel)
        episodeLabel.textAlignment = .left
        episodeLabel.textColor = .black
        episodeLabel.font = Fonts.episode
        episodeLabel.text = espisodeTitle
        setupEpisodeLabelConstraints()
    }
}
