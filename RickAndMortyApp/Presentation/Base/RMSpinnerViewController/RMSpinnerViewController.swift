//
//  RMSpinnerViewController.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import UIKit

// MARK: RMSpinnerViewController

final class RMSpinnerViewController: UIViewController {
    
    private (set) var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        spinner.startAnimating()
        return spinner
    }()
    
    override func loadView() {
        setupView()
    }
}

// MARK: Setup View

extension RMSpinnerViewController {
    
    private func setupView() {
        setupBackgroundView()
        setupSpinnerView()
    }
    
    private func setupBackgroundView() {
        view = UIView()
        view.backgroundColor = Colors.background
    }
    
    private func setupSpinnerView() {
        view.addSubview(spinner)
        setupSpinnerViewConstraints()
    }
}
