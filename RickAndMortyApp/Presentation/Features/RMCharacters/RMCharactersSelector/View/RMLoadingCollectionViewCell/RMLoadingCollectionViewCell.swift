//
//  RMLoadingCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation
import UIKit
import Lottie

// MARK: RMLoadingCollectionViewCell

final class RMLoadingCollectionViewCell: UICollectionViewCell {
    
    var animationView: LottieAnimationView = .init()
    
    func configure() {
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
