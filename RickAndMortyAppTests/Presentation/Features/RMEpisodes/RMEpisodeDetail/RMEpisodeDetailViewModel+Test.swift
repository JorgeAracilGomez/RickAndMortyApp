//
//  RMEpisodeDetailViewModel+Test.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMEpisodeDetailViewModelTest: XCTestCase {
    
    // Subject Under Test
    var successViewModel: RMEpisodeDetailViewModel?
    var failureViewModel: RMEpisodeDetailViewModel?
    
    // Injected Objects
    var succesUseCase: RMCharactersUseCase?
    var failureUseCase: RMCharactersUseCase?
    
    // Auxiliar Objects
    var episodesUseCase: RMEpisodesUseCase?
    var episodesSelectorViewModel: RMEpisodesSelectorViewModel?
    
    override func setUp() {
        super.setUp()
        episodesUseCase = DefaultRMEpisodesUseCase(repository: RMEpisodesRepositoryFullSuccessMock())
        episodesSelectorViewModel = DefaultRMEpisodesSelectorViewModel(episodesUseCase: episodesUseCase!)
        succesUseCase = DefaultRMCharactersUseCase(repository: RMCharactersRepositorySuccessMock())
        failureUseCase = DefaultRMCharactersUseCase(repository: RMCharactersRepositoryFailureMock())
        successViewModel = DefaultRMEpisodeDetailViewModel(charactersUseCase: succesUseCase!)
        failureViewModel = DefaultRMEpisodeDetailViewModel(charactersUseCase: failureUseCase!)
    }
    
    override func tearDown() {
        episodesUseCase = nil
        episodesSelectorViewModel = nil
        succesUseCase = nil
        failureUseCase = nil
        successViewModel = nil
        failureViewModel = nil
        super.tearDown()
    }
    
    func testViewDidLoad_UseCaseSucces() {
        let expectation = expectation(description: "When the UseCase executes successfully, it must correctly format the data in the inputModel to generate the view model. This model should have a product name (sku), totalBalance, and a correctly formatted transaction array.") // MISCO

        successViewModel?.model.bind { model in
            guard let model = model else { return }
            XCTAssertNotNil(model)
            XCTAssertEqual(model.name, "Pilot")
            XCTAssertEqual(model.season, 1)
            XCTAssertEqual(model.episode, 1)
            XCTAssertEqual(model.airDate, "December 2, 2013")
            XCTAssertEqual(model.characters.count, 20)
            
            expectation.fulfill()
        }

        successViewModel?.error.bind { error in
            guard let _ = error else { return }
            XCTFail("Successfully test must not have an error when the usecase is executed")
        }

        episodesSelectorViewModel?.model.bind { model in
            guard let model = model else { return }
            XCTAssertNotNil(model)
            self.episodesSelectorViewModel?.selectCell(atIndex: 0)
        }

        episodesSelectorViewModel?.episodeDetailModel.bind { productDetailModel in
            guard let productDetailModel = productDetailModel else { return }
            self.successViewModel?.viewDidLoad(forInputModel: productDetailModel) // MISCO
        }

        episodesSelectorViewModel?.viewDidLoad()

        wait(for: [expectation], timeout: 10)
    }
    
    func testViewDidLoad_UseCaseFailure() {
        let expectation = expectation(description: "After the execution error of the UseCase, an error should be received and it should not be null")

        // MISCO FALTA EL MODEL
        
        failureViewModel?.error.bind { error in
            guard let error = error else { return }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        failureViewModel?.viewDidLoad(forInputModel: RMEpisodeEntity(decodable: RMEpisodeDecodable()))

        wait(for: [expectation], timeout: 10)
    }
}
