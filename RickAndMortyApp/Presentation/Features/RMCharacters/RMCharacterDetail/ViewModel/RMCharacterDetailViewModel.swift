//
//  RMCharacterDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import Foundation

protocol RMCharacterDetailViewModel: RMCharacterDetailViewModelInput, RMCharacterDetailViewModelOutput {}


protocol RMCharacterDetailViewModelInput {
    func viewDidLoad(forInputModel model: RMCharacterEntity)
}

protocol RMCharacterDetailViewModelOutput {
    var loadingStatus: Box<RMLoadingStatus?> { get }
    var model: Box<RMCharacterDetailModel?> { get }
    var error: Box<RMError?> { get }
}

final class DefaultRMCharacterDetailViewModel: RMCharacterDetailViewModel {
    var inputModel: RMCharacterEntity?
    var loadingStatus: Box<RMLoadingStatus?> = Box(nil)
    var model: Box<RMCharacterDetailModel?> = Box(nil)
    var error: Box<RMError?> = Box(nil)
    var locationsUseCase: RMLocationsUseCase

    init(locationsUseCase: RMLocationsUseCase = DefaultRMLocationsUseCase()) {
        self.locationsUseCase = locationsUseCase
    }
}

// MARK: ViewModel Input Methods

extension DefaultRMCharacterDetailViewModel {
    
    func viewDidLoad(forInputModel model: RMCharacterEntity) {
        self.inputModel = model
        fetchData()
    }
}

// MARK: Fetch Data Methods

extension DefaultRMCharacterDetailViewModel {
    
    func fetchData() {
        
        let originID = inputModel?.origin?.url?.split(separator: "/").last.map(String.init) ?? ""
        let locationID = inputModel?.location?.url?.split(separator: "/").last.map(String.init) ?? ""
        let useCaseParemeters = RMLocationsUseCaseParameters(originID: originID, locationID: locationID)
        
        loadingStatus.value = .start
        locationsUseCase.execute(params: useCaseParemeters) { [weak self] result in
            switch result {
            case .success(let entity):
                self?.loadingStatus.value = .stop
                self?.createModel(with: entity, originID: originID, locationID: locationID)
//                print("MISCO LOCATIONS ENTITY: \(entity)")
            case .failure(let error):
                self?.loadingStatus.value = .stop
                print("MISCO LOCATIONS ERROR: \(error)")
                self?.createErrorModel(error)
            }
        }
    }
}

// MARK: Create Models

extension DefaultRMCharacterDetailViewModel {
 
    func createModel(with entity: RMLocationsListEntity, originID: String, locationID: String) {
        let originID: Int = Int(originID) ?? 0
        let locationID: Int = Int(locationID) ?? 0
        
        guard let imagePath = inputModel?.image,
              let status = inputModel?.status,
              let gender = inputModel?.gender?.rawValue,
              let species = inputModel?.species,
              let origin = entity.locations?.filter({ $0.id == originID }).first,
              let location = entity.locations?.filter({ $0.id == locationID }).first else {
            
            print("MISCO ERROR DE MODELO DE DETALLE")
            
            return
        }
        
        self.model.value = RMCharacterDetailModel(imagePath: imagePath,
                                                  status: status,
                                                  gender: gender,
                                                  species: species,
                                                  origin: origin,
                                                  location: location)        
    }

    func createErrorModel(_ error: RMError) {
        self.error.value = error
    }
}
