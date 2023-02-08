//
//  RMCharactersSelectorViewModel.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

protocol RMCharactersSelectorViewModel: RMCharactersSelectorViewModelInput, RMCharactersSelectorViewModelOutput {}


protocol RMCharactersSelectorViewModelInput {
    func viewDidLoad()
    func fetchNewCharacters()
    func filterCharacters(withSearchFilter searchFilter: String?)
    func selectCell(atIndex index: Int)
}

protocol RMCharactersSelectorViewModelOutput {
    var loadingStatus: Box<RMLoadingStatus?> { get }
    var model: Box<RMCharactersSelectorModel?> { get }
    var showEmptyStateModel: Box<Bool?> { get }
    var characterDetailModel: Box<RMCharacterEntity?> { get }
}

final class DefaultRMCharactersSelectorViewModel: RMCharactersSelectorViewModel {
    var loadingStatus: Box<RMLoadingStatus?> = Box(nil)
    var model: Box<RMCharactersSelectorModel?> = Box(nil)
    var showEmptyStateModel: Box<Bool?> = Box(nil)
    var characterDetailModel: Box<RMCharacterEntity?> = Box(nil)
    var charactersUseCase: RMCharactersUseCase
    
    init(charactersUseCase: RMCharactersUseCase = DefaultRMCharactersUseCase()) {
        self.charactersUseCase = charactersUseCase
    }
}

// MARK: ViewModel Input Methods

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

// MARK: Create Models

extension DefaultRMCharactersSelectorViewModel {
 
    func createModel(for entity: RMCharactersListEntity) {
        guard let newCharacters = entity.results else {
            // MISCO ERROR
            return
        }
        
        let currentCharacters = model.value?.characters ?? []
        let isFetchDataFinished: Bool = entity.info?.next == nil
        self.showEmptyStateModel.value = false
        self.model.value = RMCharactersSelectorModel(characters: currentCharacters + newCharacters,
                                                     isFetchDataFinished: isFetchDataFinished)
    }
    
    func createEmptyStateModel(forError: RMError) {
        self.model.value = RMCharactersSelectorModel(characters: [], isFetchDataFinished: true)
        self.showEmptyStateModel.value = true
    }
}
