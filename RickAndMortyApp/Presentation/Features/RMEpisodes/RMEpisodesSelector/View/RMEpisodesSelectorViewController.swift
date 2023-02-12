//
//  RMEpisodesSelectorViewController.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

final class RMEpisodesSelectorViewController: RMBaseViewController {
    
    var coordinator: RMEpisodesCoordinator?
    var viewModel: RMEpisodesSelectorViewModel
    
    init(viewModel: RMEpisodesSelectorViewModel = DefaultRMEpisodesSelectorViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private (set) var episodesTableView: UITableView = {
        let episodesTableView = UITableView(frame: .zero)
        episodesTableView.translatesAutoresizingMaskIntoConstraints = false
        return episodesTableView
    }()
    
    private lazy var episodesTableViewDataSource: RMEpisodesTableViewDataSource = {
        let datasource = RMEpisodesTableViewDataSource(tableView: episodesTableView, viewModel: viewModel)
        datasource.registerCells()
        return datasource
    }()
    
    private lazy var episodesTableViewDelegate: RMEpisodesTableViewDelegate = {
        let delegate = RMEpisodesTableViewDelegate(viewModel: viewModel)
        return delegate
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        setupView()
        viewModel.viewDidLoad()
    }
}

// MARK: Setup Binding

extension RMEpisodesSelectorViewController {
    
    func setupBinding() {
        
        viewModel.loadingStatus.bind { [weak self] status in
            guard let self = self,
                  let status = status else { return }
            
            self.showLoader(status: status)
        }
        
        viewModel.model.bind { [weak self] model in
            guard let _ = model,
                  let self = self else { return }
            
            self.reloadView()
        }
        
        viewModel.showEmptyStateError.bind { [weak self] emptyState in
            guard let emptyState = emptyState,
                  let self = self else { return }
            
            self.mannageEmptyStateView(for: emptyState)
        }
        
//        viewModel.episodeDetailModel.bind { [weak self] detailModel in
//            guard let detailModel = detailModel,
//                  let self = self else { return }
//
//            self.showEpisodeDetailView(for: detailModel)
//        }
    }
}

// MARK: Setup View

extension RMEpisodesSelectorViewController {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        setupEpisodesTableView()
    }
    
    func setupEpisodesTableView() {
        view.addSubview(episodesTableView)
        episodesTableView.separatorStyle = .none
        episodesTableView.dataSource = episodesTableViewDataSource
        episodesTableView.delegate = episodesTableViewDelegate
        episodesTableView.backgroundColor = .systemGroupedBackground
        setupEpisodesTableViewConstraints()
    }
}

// MARK: Mannage Reload View

extension RMEpisodesSelectorViewController {
    
    func reloadView() {
        DispatchQueue.main.async {
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
    
    func mannageEmptyStateView(for state: Bool) {
        
        DispatchQueue.main.async {
            if state {
                let background = RMEmptyStateView(frame: .zero)
                background.configure()
                self.episodesTableView.backgroundView = background
            } else {
                self.episodesTableView.backgroundView = nil
            }
        }
    }
}

// MARK: User Actions

extension RMEpisodesSelectorViewController {
    
    func showEpisodeDetailView(for model: RMEpisodeEntity) {
        coordinator?.showEpisodeDetail(for: model)
    }
}
