//
//  RMCharacterDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import Foundation

// MARK: RMCharacterDetailViewModel

protocol RMCharacterDetailViewModel: RMCharacterDetailViewModelInput, RMCharacterDetailViewModelOutput {}

/// This protocol defines the input methods that the ViewModel accepts for communication between the View-ViewModel.
protocol RMCharacterDetailViewModelInput {
    func viewDidLoad(forInputModel model: RMCharacterEntity)
}

/// This protocol defines the output getter Box variables that the ViewModel uses for communication between the ViewModel-View.
protocol RMCharacterDetailViewModelOutput {
    var loadingStatus: Box<RMLoadingStatus?> { get }
    var model: Box<RMCharacterDetailModel?> { get }
    var error: Box<RMError?> { get }
}

// MARK: DefaultRMCharacterDetailViewModel

final class DefaultRMCharacterDetailViewModel: RMCharacterDetailViewModel {
    var inputModel: RMCharacterEntity?
    var loadingStatus: Box<RMLoadingStatus?> = Box(nil)
    var model: Box<RMCharacterDetailModel?> = Box(nil)
    var error: Box<RMError?> = Box(nil)
    var characterDetailUseCase: RMCharacterDetailUseCase

    init(characterDetailUseCase: RMCharacterDetailUseCase = DefaultRMCharacterDetailUseCase()) {
        self.characterDetailUseCase = characterDetailUseCase
    }
}

// MARK: Input Methods

extension DefaultRMCharacterDetailViewModel {
    
    func viewDidLoad(forInputModel model: RMCharacterEntity) {
        self.inputModel = model
        fetchData()
    }
}

// MARK: Fetch Data Methods

extension DefaultRMCharacterDetailViewModel {
    
    func fetchData() {
        
        let originID = inputModel?.origin?.url?.split(separator: "/").last.map(String.init) ?? "0"
        let locationID = inputModel?.location?.url?.split(separator: "/").last.map(String.init) ?? "0"
        let episodesIDs = inputModel?.episode?.compactMap({ $0.split(separator: "/").last.map(String.init) ?? "0" })
        
        let useCaseParameters = RMCharacterDetailUseCaseParameters(originID: originID, locationID: locationID, episodesIDs: episodesIDs)
        self.loadingStatus.value = .start
        characterDetailUseCase.execute(params: useCaseParameters) { [weak self] result in
            switch result {
            case .success(let entity):
                self?.loadingStatus.value = .stop
                self?.createModel(withEntity: entity, forParameters: useCaseParameters)
            case .failure(let error):
                self?.loadingStatus.value = .stop
                self?.createErrorModel(error)
            }
        }
    }
}

// MARK: Create Models

extension DefaultRMCharacterDetailViewModel {
   
    /// This method inflates a model of the view for data binding with the viewController
    /// - Parameters:
    ///   - entity: Entity model result of the Character Detail request.
    ///   - params: Parameters model for the  Character Detail request.
    func createModel(withEntity entity: RMCharacterDetailEntity, forParameters params: RMCharacterDetailUseCaseParameters) {
        guard let imagePath = inputModel?.image,
              let status = inputModel?.status,
              let gender = inputModel?.gender?.rawValue,
              let species = inputModel?.species,
              let origin = entity.locations?.filter({ $0.id == Int(params.originID) ?? 0 }).first,
              let location = entity.locations?.filter({ $0.id == Int(params.locationID) ?? 0 }).first,
              let episodes = entity.episodes else {
            
            self.error.value = RMError.unknownError(message: "Could not get detail model in RMCharacterDetailViewModel")            
            return
        }
        
        self.model.value = RMCharacterDetailModel(imagePath: imagePath,
                                                  status: status,
                                                  gender: gender,
                                                  species: species,
                                                  origin: origin,
                                                  location: location,
                                                  episodes: episodes)
    }

    /// This method inflates an error model for data binding with the viewController
    /// - Parameter error: Value of the error occurred
    func createErrorModel(_ error: RMError) {
        self.error.value = error
    }
}
