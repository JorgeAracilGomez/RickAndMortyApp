//
//  RMCharacterDetailViewModel+Test.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMCharacterDetailViewModelTest: XCTestCase {
    
    // Subject Under Test
    var successViewModel: RMCharacterDetailViewModel?
    var failureViewModel: RMCharacterDetailViewModel?
    
    // Injected Objects
    var successUseCase: RMCharacterDetailUseCase?
    var failureUseCase: RMCharacterDetailUseCase?
    var locationsUseCaseSuccess: RMLocationsUseCase?
    var locationsUseCaseFailure: RMLocationsUseCase?
    var episodesUseCaseSuccess: RMEpisodesUseCase?
    var episodesUseCaseFailure: RMEpisodesUseCase?
    
    // Auxiliar Objects
    var charactersUseCase: RMCharactersUseCase?
    var charactersSelectorViewModel: RMCharactersSelectorViewModel?
    
    override func setUp() {
        super.setUp()
        charactersUseCase = DefaultRMCharactersUseCase(repository: RMCharactersRepositorySuccessMock())
        charactersSelectorViewModel = DefaultRMCharactersSelectorViewModel(charactersUseCase: charactersUseCase!)
        locationsUseCaseSuccess = DefaultRMLocationsUseCase(repository: RMLocationsRepositorySuccessMock())
        locationsUseCaseFailure = DefaultRMLocationsUseCase(repository: RMLocationsRepositoryFailureMock())
        episodesUseCaseSuccess = DefaultRMEpisodesUseCase(repository: RMEpisodesRepositoryResultsSuccessMock())
        episodesUseCaseFailure = DefaultRMEpisodesUseCase(repository: RMEpisodesRepositoryFailureMock())
        successUseCase = DefaultRMCharacterDetailUseCase(locationsUseCase: locationsUseCaseSuccess!,episodesUseCase: episodesUseCaseSuccess!)
        failureUseCase = DefaultRMCharacterDetailUseCase(locationsUseCase: locationsUseCaseFailure!, episodesUseCase: episodesUseCaseFailure!)
        successViewModel = DefaultRMCharacterDetailViewModel(characterDetailUseCase: successUseCase!)
        failureViewModel = DefaultRMCharacterDetailViewModel(characterDetailUseCase: failureUseCase!)
    }
    
    override func tearDown() {
        charactersUseCase = nil
        charactersSelectorViewModel = nil
        locationsUseCaseSuccess = nil
        locationsUseCaseFailure = nil
        episodesUseCaseSuccess = nil
        episodesUseCaseFailure = nil
        successUseCase = nil
        failureUseCase = nil
        successViewModel = nil
        failureViewModel = nil
        super.tearDown()
    }
    
    func testViewDidLoad_UseCaseSucces() {
        let expectation = expectation(description: "When the UseCase executes successfully, it must correctly format the data in the inputModel to generate the model of the view. This model should have a valid data and must be binded to the view.")

        successViewModel?.model.bind { model in
            guard let model = model else { return }
            XCTAssertNotNil(model)
            XCTAssertEqual(model.imagePath, "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
            XCTAssertEqual(model.status, .Alive)
            XCTAssertEqual(model.gender, "Male")
            XCTAssertEqual(model.species, "Human")
            XCTAssertEqual(model.origin.name, "Earth (C-137)")
            XCTAssertEqual(model.origin.url, "https://rickandmortyapi.com/api/location/1")
            XCTAssertEqual(model.location.name, "Citadel of Ricks")
            XCTAssertEqual(model.location.url, "https://rickandmortyapi.com/api/location/3")
            XCTAssertEqual(model.episodes.count, 51)
            for episode in model.episodes {
                XCTAssertNotNil(episode.id)
                XCTAssertNotNil(episode.name)
                XCTAssertNotNil(episode.airDate)
                XCTAssertNotNil(episode.episode)
                XCTAssertNotNil(episode.characters)
                XCTAssertNotNil(episode.url)
                XCTAssertNotNil(episode.created)
            }

            expectation.fulfill()
        }

        successViewModel?.error.bind { error in
            guard let _ = error else { return }
            XCTFail("Successfully test must not have an error when the usecase is executed")
        }

        charactersSelectorViewModel?.model.bind { model in
            guard let model = model else { return }
            XCTAssertNotNil(model)
            self.charactersSelectorViewModel?.selectCell(atIndex: 0)
        }

        charactersSelectorViewModel?.characterDetailModel.bind { characterDetailModel in
            guard let characterDetailModel = characterDetailModel else { return }
            self.successViewModel?.viewDidLoad(forInputModel: characterDetailModel)
        }

        charactersSelectorViewModel?.viewDidLoad()

        wait(for: [expectation], timeout: 10)
    }
    
    func testViewDidLoad_UseCaseFailure() {
        let expectation = expectation(description: "After the execution error of the UseCase, an error should be received and it should not be null")

        failureViewModel?.error.bind { error in
            guard let error = error else { return }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        successViewModel?.model.bind { model in
            guard let _ = model else { return }
            XCTFail("Failure test must not have a model binding when the usecase is executed")
        }

        failureViewModel?.viewDidLoad(forInputModel: RMCharacterEntity(decodable: RMCharacterDecodable()))

        wait(for: [expectation], timeout: 10)
    }
}
