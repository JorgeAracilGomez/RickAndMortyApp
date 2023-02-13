//
//  RMCharactersSelectorViewModel.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

// MARK: RMCharactersSelectorViewModel

protocol RMCharactersSelectorViewModel: RMCharactersSelectorViewModelInput, RMCharactersSelectorViewModelOutput {}

/// This protocol defines the input methods that the ViewModel accepts for communication between the View-ViewModel.
protocol RMCharactersSelectorViewModelInput {
    func viewDidLoad()
    func fetchNewCharacters()
    func filterCharacters(withSearchFilter searchFilter: String?)
    func selectCell(atIndex index: Int)
}

/// This protocol defines the output getter Box variables that the ViewModel uses for communication between the ViewModel-View.
protocol RMCharactersSelectorViewModelOutput {
    var loadingStatus: Box<RMLoadingStatus?> { get }
    var model: Box<RMCharactersSelectorModel?> { get }
    var showEmptyStateError: Box<Bool?> { get }
    var characterDetailModel: Box<RMCharacterEntity?> { get }
}

// MARK: DefaultRMCharactersSelectorViewModel

final class DefaultRMCharactersSelectorViewModel: RMCharactersSelectorViewModel {
    var loadingStatus: Box<RMLoadingStatus?> = Box(nil)
    var model: Box<RMCharactersSelectorModel?> = Box(nil)
    var showEmptyStateError: Box<Bool?> = Box(nil)
    var characterDetailModel: Box<RMCharacterEntity?> = Box(nil)
    var charactersUseCase: RMCharactersUseCase
    
    init(charactersUseCase: RMCharactersUseCase = DefaultRMCharactersUseCase()) {
        self.charactersUseCase = charactersUseCase
    }
}

// MARK: Input Methods

extension DefaultRMCharactersSelectorViewModel {
    
    func viewDidLoad() {
        fetchData(withSearchFilter: nil)
    }
    
    func fetchNewCharacters() {
        fetchData(withSearchFilter: nil)
    }
    
    func filterCharacters(withSearchFilter searchFilter: String? = nil) {
        charactersUseCase.clearFilters()
        model.value = nil
        fetchData(withSearchFilter: searchFilter)
    }
    
    func selectCell(atIndex index: Int) {
        characterDetailModel.value = model.value?.characters[index]
    }
}

// MARK: Fetch Data Methods

extension DefaultRMCharactersSelectorViewModel {
    
    func fetchData(withSearchFilter searchFilter: String?) {
        
        loadingStatus.value = .start
        let useCaseParameters = RMCharactersUseCaseParameters(searchFilter: searchFilter)
        charactersUseCase.execute(params: useCaseParameters) { [weak self] result in
            switch result {
            case .success(let entity):
                self?.loadingStatus.value = .stop
                self?.createModel(for: entity)
            case .failure(let error):
                self?.loadingStatus.value = .stop
                self?.createEmptyStateModel(forError: error)
            }
        }
    }
}

// MARK: Mannage Output Models

extension DefaultRMCharactersSelectorViewModel {
    
    /// This method inflates a model of the view for data binding with the viewController
    /// - Parameter entity: Entity model result of the Characters request.
    func createModel(for entity: RMCharactersListEntity) {
        guard let newCharacters = entity.results else {
            let error = RMError.unknownError(message: "Could not get list of characters in RMCharactersSelectorViewModel")
            createEmptyStateModel(forError: error)
            return
        }
        
        let currentCharacters = model.value?.characters ?? []
        let isFetchDataFinished: Bool = entity.info?.next == nil
        self.showEmptyStateError.value = false
        self.model.value = RMCharactersSelectorModel(characters: currentCharacters + newCharacters,
                                                     isFetchDataFinished: isFetchDataFinished)
    }
    
    /// This method inflates an error model for data binding with the viewController
    /// - Parameter error: Value of the error occurred
    func createEmptyStateModel(forError: RMError) {
        self.model.value = RMCharactersSelectorModel(characters: [], isFetchDataFinished: true)
        self.showEmptyStateError.value = true
    }
}
