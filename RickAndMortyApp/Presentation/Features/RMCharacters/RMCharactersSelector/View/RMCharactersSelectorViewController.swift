//
//  RMCharactersSelectorViewController.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

// MARK: RMCharactersSelectorViewController

final class RMCharactersSelectorViewController: RMBaseViewController {
    
    var coordinator: RMCharactersCoordinator?
    var viewModel: RMCharactersSelectorViewModel
    
    init(viewModel: RMCharactersSelectorViewModel = DefaultRMCharactersSelectorViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let search = UISearchController(searchResultsController: nil)
    
    private (set) var charactersCollectionView: UICollectionView = {
        let layout = RMCharactersCollectionViewLayout()
        let charactersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        charactersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return charactersCollectionView
    }()
    
    private lazy var charactersCollectionViewDataSource: RMCharactersCollectionViewDataSource = {
        let datasource = RMCharactersCollectionViewDataSource(collectionView: charactersCollectionView, viewModel: viewModel)
        datasource.registerCells()
        return datasource
    }()
    
    private lazy var charactersCollectionViewDelegate: RMCharactersCollectionViewDelegate = {
        let delegate = RMCharactersCollectionViewDelegate(viewModel: viewModel)
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

extension RMCharactersSelectorViewController {
    
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
        
        viewModel.characterDetailModel.bind { [weak self] detailModel in
            guard let detailModel = detailModel,
                  let self = self else { return }
             
            self.showCharacterDetailView(for: detailModel)
        }
    }
}

// MARK: Setup View

extension RMCharactersSelectorViewController {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        setupSearchBarView()
        setupCharactersCollectionView()
    }
    
    func setupSearchBarView() {
        search.searchBar.delegate = self
        search.searchResultsUpdater = self
        search.searchBar.placeholder = Localizables.searchBarPlaceHolder.localized
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
    }
    
    func setupCharactersCollectionView() {
        self.view.addSubview(charactersCollectionView)
        charactersCollectionView.dataSource = charactersCollectionViewDataSource
        charactersCollectionView.delegate = charactersCollectionViewDelegate
        charactersCollectionView.backgroundColor = .systemGroupedBackground
        charactersCollectionView.accessibilityIdentifier = AccessibilityIdentifiers.charactersCollectionView
        setupCharactersCollectionViewConstraints()
    }
}

// MARK: Mannage Reload View

extension RMCharactersSelectorViewController {
    
    func reloadView() {
        DispatchQueue.main.async {
            self.charactersCollectionView.reloadData()
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
                self.charactersCollectionView.backgroundView = background
            } else {
                self.charactersCollectionView.backgroundView = nil
            }
        }
    }
}

// MARK: User Actions

extension RMCharactersSelectorViewController {
    
    func showCharacterDetailView(for model: RMCharacterEntity) {
        coordinator?.showCharacterDetail(for: model)
    }
}
