//
//  RMEpisodeDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

final class RMEpisodeDetailViewController: RMBaseViewController {

    var coordinator: RMEpisodesCoordinator?
    var episodeInputModel: RMEpisodeEntity
    var viewModel: RMEpisodeDetailViewModel
    
    init(episodeInputModel: RMEpisodeEntity, viewModel: RMEpisodeDetailViewModel = DefaultRMEpisodeDetailViewModel()) {
        
        self.episodeInputModel = episodeInputModel
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private (set) var episodeHeaderView: RMEpisodeDetailHeaderView = {
        let episodeHeaderView = RMEpisodeDetailHeaderView(frame: .zero)
        episodeHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return episodeHeaderView
    }()
    
    private (set) var charactersTableView: UITableView = {
        let charactersTableView = UITableView(frame: .zero, style: .grouped)
        charactersTableView.translatesAutoresizingMaskIntoConstraints = false
        return charactersTableView
    }()
    
    private lazy var charactersTableViewDataSource: RMEpisodeDetailTableViewDatasource = {
        let datasource = RMEpisodeDetailTableViewDatasource(tableView: charactersTableView, viewModel: viewModel)
        datasource.registerCells()
        return datasource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        setupView()
        viewModel.viewDidLoad(forInputModel: episodeInputModel)
    }
}

// MARK: Setup Binding

extension RMEpisodeDetailViewController {
    
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

// MARK: Setup View

extension RMEpisodeDetailViewController {
    
    private func setupView() {
        self.view.backgroundColor = .white
        setupNavigationTitle()
        setupEpisodeHeaderView()
        setupCharactersTableView()
    }
    private func setupNavigationTitle() {
        self.title = episodeInputModel.name
        navigationItem.setValue(1, forKey: "__largeTitleTwoLineMode")
    }
    
    private func setupEpisodeHeaderView() {
        view.addSubview(episodeHeaderView)
        setupEpisodeHeaderViewConstraints()
    }
    
    private func setupCharactersTableView() {
        self.view.addSubview(charactersTableView)
        charactersTableView.backgroundColor = .systemGroupedBackground
        charactersTableView.separatorStyle = .none
        charactersTableView.dataSource = charactersTableViewDataSource
        charactersTableView.delegate = nil
        setupCharactersTableViewConstraints()
    }
}

// MARK: RMEpisodeDetailViewController - Mannage Reload View

extension RMEpisodeDetailViewController {
    
    private func reloadView(with model: RMEpisodeDetailModel) {
        DispatchQueue.main.async {
            self.episodeHeaderView.configure(withModel: model)
            self.charactersTableView.reloadData()
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

// MARK: RMEpisodeDetailViewController - User Actions

extension RMEpisodeDetailViewController {
    
    func showErrorAlert(for error: RMError) {
        DispatchQueue.main.async {
            self.coordinator?.showAlert(error: error)
        }
    }
}
