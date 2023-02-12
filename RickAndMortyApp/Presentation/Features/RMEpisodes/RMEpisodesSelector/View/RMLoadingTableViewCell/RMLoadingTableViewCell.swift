//
//  RMLoadingTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import Foundation
import UIKit
import Lottie

// MARK: RMLoadingCollectionViewCell

final class RMLoadingTableViewCell: UITableViewCell {
    
    var animationView: LottieAnimationView = .init()
    
    func configure() {
        backgroundColor = .clear
        setupAnimationView()
    }
    
    func setupAnimationView() {
        addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.animation = LottieAnimation.named(LottieFiles.loading)
        animationView.loopMode = .loop
        animationView.play()
        
        setupAnimationViewConstraints()
    }
}
