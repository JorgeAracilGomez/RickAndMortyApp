//
//  RMEpisodeDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {

    var coordinator: RMEpisodesCoordinator?
    var episodeInputModel: RMEpisodeEntity
//    var viewModel: RMEpisodeDetailViewModel
    
    init(episodeInputModel: RMEpisodeEntity
//         , viewModel: RMEpisodeDetailViewModel = DefaultRMEpisodeDetailViewModel() // MISCO
    ) {
        
        self.episodeInputModel = episodeInputModel
//        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow

    }
}
