//
//  RMCharactersSelectorViewController.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import UIKit

final class RMCharactersSelectorViewController: UIViewController {
    
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
    
    private lazy var charactersCollectionEmptyStateView: RMEmptyStateView = {
        let emptyStateView = RMEmptyStateView(frame: .zero)
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.configure()
        return emptyStateView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
//        title = "Characters" // MISCO LOCALZABLE

        setupBinding()
        setupView()
        viewModel.viewDidLoad()
    }
}

// MARK: Setup Binding

extension RMCharactersSelectorViewController {
    
    func setupBinding() {
        
        viewModel.model.bind { [weak self] model in
            guard let _ = model,
                  let self = self else { return }
            
            self.reloadView()
        }
        
        viewModel.showEmptyStateModel.bind { [weak self] emptyState in
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
        setupSearchBarView()
        setupCharactersCollectionView()
    }
    
    func setupSearchBarView() {
        search.searchBar.delegate = self
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Type something here to search" // MISCO LOCALIZABLE
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
    }
    
    func setupCharactersCollectionView() {
        self.view.addSubview(charactersCollectionView)
        let background = RMEmptyStateView(frame: .zero)
        background.configure()
        charactersCollectionView.dataSource = charactersCollectionViewDataSource
        charactersCollectionView.delegate = charactersCollectionViewDelegate
        charactersCollectionView.backgroundColor = .systemGroupedBackground
        charactersCollectionView.backgroundView = background
        charactersCollectionView.backgroundView?.isHidden = true
        
        // MISCO REVISAR CONSTRAINTS
        
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
    
    func mannageEmptyStateView(for state: Bool) {
        DispatchQueue.main.async {
            self.charactersCollectionView.backgroundView?.isHidden = !state
        }
    }
}

// MARK: User Actions

extension RMCharactersSelectorViewController {
    
    func showCharacterDetailView(for model: RMCharacterEntity) {
        coordinator?.showCharacterDetail(for: model)
    }
}
