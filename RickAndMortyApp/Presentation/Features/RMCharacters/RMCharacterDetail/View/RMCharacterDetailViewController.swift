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
    var viewModel: RMCharacterDetailViewModel
    
    init(characterInputModel: RMCharacterEntity,
         viewModel: RMCharacterDetailViewModel = DefaultRMCharacterDetailViewModel()) {
        
        self.characterInputModel = characterInputModel
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private (set) var characterHeaderView: RMCharacterDetailHeaderView = {
        let characterHeaderView = RMCharacterDetailHeaderView(frame: .zero)
        characterHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return characterHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.title = characterInputModel.name // MISCO
        view.backgroundColor = .white
        
        setupBinding()
        setupView()
        viewModel.viewDidLoad(forInputModel: characterInputModel)
    }
}

// MARK: RMCharacterDetailViewController - Setup Binding

extension RMCharacterDetailViewController {
    
    private func setupBinding() {
        viewModel.model.bind { [weak self] model in
            guard let self = self, let model = model else { return }
            
            DispatchQueue.main.async {
                self.characterHeaderView.configure(withModel: model)
            }
        }
    }
}

// MARK: RMCharacterDetailViewController - Setup View

extension RMCharacterDetailViewController {
    
    private func setupView() {
        setupCharacterHeaderView()
    }
    
    private func setupCharacterHeaderView() {
        view.addSubview(characterHeaderView)
        setupCharacterHeaderViewConstraints()
    }
}
