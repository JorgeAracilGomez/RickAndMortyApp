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
    
    private (set) var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
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
        setuptitleLabel()
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
        
    private func setuptitleLabel() {
        shadowView.addSubview(titleLabel)
//        titleLabel.font = Fonts.status // MISCO
        titleLabel.text = model?.name
        titleLabel.textAlignment = .center
        setuptitleLabelConstraints()
    }
}






// MISCO

import UIKit

// MARK: RMEpisodeDetailHeaderView - Constants

extension RMEpisodeDetailHeaderView {
 
    enum Constants {
        static let shadowViewCornerRadius: CGFloat = 3
        static let shadowViewOffset = CGSize(width: 0, height: 1.75)
        static let shadowViewRadius: CGFloat = 1
        static let shadowViewOpacity: Float = 0.45
    }
    
    enum Fonts {
        static let status = UIFont(name: "Helvetica-Bold", size: 16)
    }
}












// MISCO

import UIKit

// MARK: RMEpisodeDetailHeaderView - Constraints

extension RMEpisodeDetailHeaderView {
    
    private enum Constraints {
        static let shadowViewBotom: CGFloat = 3.0
        static let titleLabelTop: CGFloat = 20
        static let titleLabelLeading: CGFloat = 20
        static let titleLabelTrailing: CGFloat = 20
    }
    
    func setupShadowViewConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.shadowViewBotom),
        ])
    }
    
    func setuptitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: Constraints.titleLabelTop),
            titleLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: Constraints.titleLabelLeading),
            titleLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -Constraints.titleLabelTrailing),
            titleLabel.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        ])
    }
}
