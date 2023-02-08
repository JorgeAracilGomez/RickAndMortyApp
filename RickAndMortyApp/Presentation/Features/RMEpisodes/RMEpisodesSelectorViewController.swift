//
//  RMEpisodesSelectorViewController.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

final class RMEpisodesSelectorViewController: UIViewController {
    
    var coordinator: RMEpisodesCoordinator?

    private (set) var episodesTableView: UITableView = {
        let episodesTableView = UITableView(frame: .zero)
        episodesTableView.translatesAutoresizingMaskIntoConstraints = false
        return episodesTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
//        title = "Episodes" // MISCO LOCALIZABLE
        
        view.addSubview(episodesTableView)
        
        NSLayoutConstraint.activate([
            episodesTableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            episodesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            episodesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            episodesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -50)
        ])
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
            print("EPISODES Button tapped!")
        }
}
