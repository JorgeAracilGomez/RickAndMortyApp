//
//  RMEpisodesSelectorViewModel.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import Foundation

protocol RMEpisodesSelectorViewModel: RMEpisodesSelectorViewModelInput, RMEpisodesSelectorViewModelOutput {}


protocol RMEpisodesSelectorViewModelInput {
    func viewDidLoad()
    func fetchNewEpisodes()
    func selectCell(atIndex index: Int)
}

protocol RMEpisodesSelectorViewModelOutput {
    var loadingStatus: Box<RMLoadingStatus?> { get }
    var model: Box<RMEpisodesSelectorModel?> { get }
    var showEmptyStateError: Box<Bool?> { get }
    var episodeDetailModel: Box<RMEpisodeEntity?> { get }
}

final class DefaultRMEpisodesSelectorViewModel: RMEpisodesSelectorViewModel {
    var loadingStatus: Box<RMLoadingStatus?> = Box(nil)
    var model: Box<RMEpisodesSelectorModel?> = Box(nil)
    var showEmptyStateError: Box<Bool?> = Box(nil)
    var episodeDetailModel: Box<RMEpisodeEntity?> = Box(nil)
    var episodesUseCase: RMEpisodesUseCase
    
    init(episodesUseCase: RMEpisodesUseCase = DefaultRMEpisodesUseCase()) {
        self.episodesUseCase = episodesUseCase
    }
}

// MARK: ViewModel Input Methods

extension DefaultRMEpisodesSelectorViewModel {
    
    func viewDidLoad() {
        fetchData()
    }
    
    func fetchNewEpisodes() {
        fetchData()
    }

    func selectCell(atIndex index: Int) {
        episodeDetailModel.value = model.value?.episodes[index]
    }
}

// MARK: Fetch Data Methods

extension DefaultRMEpisodesSelectorViewModel {
    
    func fetchData() {
        
        loadingStatus.value = .start
        let useCaseParameters = RMEpisodesUseCaseParameters()
        episodesUseCase.execute(params: useCaseParameters) { [weak self] result in
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

extension DefaultRMEpisodesSelectorViewModel {
 
    func createModel(for entity: RMEpisodesListEntity) {
        guard let newEpisodes = entity.results else {
            let error = RMError.unknownError(message: "Could not get list of episodes in RMEpisodesSelectorViewModel")
            createEmptyStateModel(forError: error)
            return
        }
        
        let currentEpisodes = model.value?.episodes ?? []
        let isFetchDataFinished: Bool = entity.info?.next == nil
        self.showEmptyStateError.value = false
        self.model.value = RMEpisodesSelectorModel(episodes: currentEpisodes + newEpisodes,
                                                   isFetchDataFinished: isFetchDataFinished)
    }
    
    func createEmptyStateModel(forError: RMError) {
        self.model.value = RMEpisodesSelectorModel(episodes: [], isFetchDataFinished: true)
        self.showEmptyStateError.value = true
    }
}
