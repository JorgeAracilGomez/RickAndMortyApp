//
//  RMEpisodeDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import Foundation

protocol RMEpisodeDetailViewModel: RMEpisodeDetailViewModelInput, RMEpisodeDetailViewModelOutput {}

protocol RMEpisodeDetailViewModelInput {
    func viewDidLoad(forInputModel model: RMEpisodeEntity)
}

protocol RMEpisodeDetailViewModelOutput {
    var loadingStatus: Box<RMLoadingStatus?> { get }
    var model: Box<RMEpisodeDetailModel?> { get }
    var error: Box<RMError?> { get }
}

final class DefaultRMEpisodeDetailViewModel: RMEpisodeDetailViewModel {
    var inputModel: RMEpisodeEntity?
    var loadingStatus: Box<RMLoadingStatus?> = Box(nil)
    var model: Box<RMEpisodeDetailModel?> = Box(nil)
    var error: Box<RMError?> = Box(nil)
    var charactersUseCase: RMCharactersUseCase

    init(charactersUseCase: RMCharactersUseCase = DefaultRMCharactersUseCase()) {
        self.charactersUseCase = charactersUseCase
    }
}

// MARK: ViewModel Input Methods

extension DefaultRMEpisodeDetailViewModel {
    
    func viewDidLoad(forInputModel model: RMEpisodeEntity) {
        self.inputModel = model
        fetchData()
    }
}

// MARK: Fetch Data Methods

extension DefaultRMEpisodeDetailViewModel {
    
    func fetchData() {
        
        let charactersIDs = inputModel?.characters?.compactMap({ $0.split(separator: "/").last.map(String.init) })
        
        let useCaseParameters = RMCharactersUseCaseParameters(charactersIDs: charactersIDs)
        self.loadingStatus.value = .start
        charactersUseCase.execute(params: useCaseParameters) { [weak self] result in
            switch result {
            case .success(let entity):
                self?.loadingStatus.value = .stop
                self?.createModel(with: entity)
            case .failure(let error):
                self?.loadingStatus.value = .stop
                self?.createErrorModel(error)
            }
        }
    }
}

// MARK: Create Models

extension DefaultRMEpisodeDetailViewModel {
 
    func createModel(with entity: RMCharactersListEntity) {
        guard let name = inputModel?.name,
              let episodeValues = inputModel?.episode?.dropFirst().split(separator: "E").map(String.init),
              let season = episodeValues.first,
              let episode = episodeValues.last,
              let airDate = inputModel?.airDate,
              let characters = entity.results else {

            self.error.value = RMError.unknownError(message: "Could not get detail model in RMEpisodeDetailViewModel")
            return
        }
        
        self.model.value = RMEpisodeDetailModel(name: name,
                                                season: Int(season),
                                                episode: Int(episode),
                                                airDate: airDate,
                                                characters: characters)
    }

    func createErrorModel(_ error: RMError) {
        self.error.value = error
    }
}
