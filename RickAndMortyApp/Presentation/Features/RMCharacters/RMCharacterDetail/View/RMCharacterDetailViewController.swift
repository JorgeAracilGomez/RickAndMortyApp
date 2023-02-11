//
//  RMCharacterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

final class RMCharacterDetailViewController: RMBaseViewController {

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
    
    private (set) var episodesTableView: UITableView = {
        let episodesTableView = UITableView(frame: .zero, style: .grouped)
        episodesTableView.translatesAutoresizingMaskIntoConstraints = false
        return episodesTableView
    }()
    
    private lazy var episodesTableViewDataSource: RMCharacterDetailTableViewDatasource = {
        let datasource = RMCharacterDetailTableViewDatasource(tableView: episodesTableView, viewModel: viewModel)
        datasource.registerCells()
        return datasource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        setupView()
        viewModel.viewDidLoad(forInputModel: characterInputModel)
    }
}

// MARK: RMCharacterDetailViewController - Setup Binding

extension RMCharacterDetailViewController {
    
    private func setupBinding() {
        
        viewModel.loadingStatus.bind { [weak self] status in
            guard let self = self,
                  let status = status else { return }
            
            self.showLoader(status: status)
        }
        
        viewModel.model.bind { [weak self] model in
            guard let self = self,
                  let model = model else { return }
            
            self.reloadView(with: model)
        }
        
        viewModel.error.bind { [weak self] error in
            guard let self = self,
                  let error = error else { return }
            
            self.showErrorAlert(for: error)
        }
    }
}

// MARK: RMCharacterDetailViewController - Setup View

extension RMCharacterDetailViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        setupNavigationTitle()
        setupCharacterHeaderView()
        setupEpisodesTableView()
    }
    
    private func setupNavigationTitle() {
        self.title = characterInputModel.name
    }
    
    private func setupCharacterHeaderView() {
        view.addSubview(characterHeaderView)
        setupCharacterHeaderViewConstraints()
    }
    
    private func setupEpisodesTableView() {
        self.view.addSubview(episodesTableView)
        episodesTableView.backgroundColor = .systemGroupedBackground
        episodesTableView.separatorStyle = .none
        episodesTableView.dataSource = episodesTableViewDataSource
        episodesTableView.delegate = nil
        setupEpisodesTableViewConstraints()
    }
}

// MARK: RMCharacterDetailViewController - Mannage Reload View

extension RMCharacterDetailViewController {
    
    private func reloadView(with model: RMCharacterDetailModel) {
        DispatchQueue.main.async {
            self.characterHeaderView.configure(withModel: model)
            self.episodesTableView.reloadData()
        }
    }
    
    func showLoader(status: RMLoadingStatus) {
        switch status {
        case .start:
            self.showSpinner()
        case .stop:
            self.hideSpinner()
        }
    }
}

// MARK: RMCharacterDetailViewController - User Actions

extension RMCharacterDetailViewController {
    
    func showErrorAlert(for error: RMError) {
        DispatchQueue.main.async {
            self.coordinator?.showAlert(error: error)
        }
    }
}
