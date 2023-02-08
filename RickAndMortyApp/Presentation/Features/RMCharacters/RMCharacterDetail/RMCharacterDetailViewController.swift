//
//  RMCharacterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {

    var coordinator: RMCharactersCoordinator?
    var characterInputModel: RMCharacterEntity
    
    init(characterInputModel: RMCharacterEntity) {
        self.characterInputModel = characterInputModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow
        
        self.title = characterInputModel.name

    }
}
