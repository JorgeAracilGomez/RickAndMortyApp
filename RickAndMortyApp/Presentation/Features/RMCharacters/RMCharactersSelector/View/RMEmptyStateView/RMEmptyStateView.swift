//
//  RMEmptyStateView.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 6/2/23.
//

import UIKit
import Lottie

// MARK: RMEmptyStateView

final class RMEmptyStateView: UIView {
    
    private (set) var message: UILabel = {
        let message = UILabel(frame: .zero)
        message.translatesAutoresizingMaskIntoConstraints = false
        return message
    }()
        
    private (set) var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView.init()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    func configure() {
        setupMessageLabel()
        setupAnimationView()
    }
    
    func setupMessageLabel() {
        addSubview(message)
        message.numberOfLines = Constants.messageNumberOfLines
        message.textAlignment = .center
        message.text = "Theres nothing here" // MISCO LOCALIZABLE
        message.font = Fonts.messageFont
        
        setupMessageLabelConstraints()
    }
    
    func setupAnimationView() {
        addSubview(animationView)
        animationView.animation = LottieAnimation.named(LottieFiles.loading)
        animationView.loopMode = .loop
        animationView.play()
        
        setupAnimationViewConstraints()
    }
}
