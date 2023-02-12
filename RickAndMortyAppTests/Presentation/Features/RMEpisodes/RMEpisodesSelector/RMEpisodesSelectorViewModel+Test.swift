//
//  RMEpisodesSelectorViewModel+Test.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMEpisodesSelectorViewModelTest: XCTestCase {
    
    // Subject Under Test
    var successViewModel: RMEpisodesSelectorViewModel?
    var failureViewModel: RMEpisodesSelectorViewModel?
    
    // Injected Objects
    var succesUseCase: RMEpisodesUseCase?
    var failureUseCase: RMEpisodesUseCase?
    
    override func setUp() {
        super.setUp()
        succesUseCase = DefaultRMEpisodesUseCase(repository: RMEpisodesRepositoryFullSuccessMock())
        failureUseCase = DefaultRMEpisodesUseCase(repository: RMEpisodesRepositoryFailureMock())
        
        successViewModel = DefaultRMEpisodesSelectorViewModel(episodesUseCase: succesUseCase!)
        failureViewModel = DefaultRMEpisodesSelectorViewModel(episodesUseCase: failureUseCase!)
    }
    
    override func tearDown() {
        succesUseCase = nil
        failureUseCase = nil
        successViewModel = nil
        failureViewModel = nil
        super.tearDown()
    }
    
    func testViewDidLoad_UseCaseSucces() {
        let expectation = expectation(description: "After the correct execution of the UseCase, the model of the view must be created and it is binded, obtaining 20 episodes and a false value for Fetching Data Finished flag.")

        successViewModel?.model.bind { model in
            guard let model = model else { return }
            XCTAssertNotNil(model)
            XCTAssertFalse(model.isFetchDataFinished)
            XCTAssertTrue(model.episodes.count == 20)

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

        successViewModel?.showEmptyStateError.bind { error in
            guard let error = error, error else { return }
            XCTFail("Successfully test must not have an error when the usecase is executed")
        }

        successViewModel?.viewDidLoad()

        wait(for: [expectation], timeout: 10)
    }
    
    func testViewDidLoad_UseCaseFailure() {
        let expectationModel = expectation(description: "After the execution error of the UseCase, a empty model should be received and it should not be null, but must contains an empty array of episodes an a true boolean flag for not try to fetch more data")
        let expectationError = expectation(description: "After the execution error of the UseCase, an error flag should be received and it should be a true boolean state indicating that the empty state view must be showed")
                
        failureViewModel?.model.bind { model in
            guard let model = model else { return }
            XCTAssertNotNil(model)
            XCTAssertTrue(model.episodes.isEmpty)
            XCTAssertTrue(model.isFetchDataFinished)
            expectationModel.fulfill()
        }
        
        failureViewModel?.showEmptyStateError.bind { error in
            guard let error = error else { return }
            XCTAssertNotNil(error)
            XCTAssertTrue(error)
            expectationError.fulfill()
        }
        
        failureViewModel?.viewDidLoad()
        
        wait(for: [expectationModel, expectationError], timeout: 10)
    }
    
    func testFetchNewEpisodes_UseCaseSucces() {
        let expectation = expectation(description: "After the correct execution of viewDidLoad, when calling for first time the fetchNewEpisodes method we need to fetch another 20 Episodes, append it to the model an bind it again to the view controller, obtaining 40 episodes and a false value for Fetching Data Finished flag.")

        successViewModel?.model.bind { [weak self] model in
            guard let self = self, let model = model else { return }
            if model.episodes.count == 20 {
                self.successViewModel?.fetchNewEpisodes()
            } else {
                XCTAssertNotNil(model)
                XCTAssertFalse(model.isFetchDataFinished)
                XCTAssertTrue(model.episodes.count == 40)

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
        }

        successViewModel?.showEmptyStateError.bind { error in
            guard let error = error, error else { return }
            XCTFail("Successfully test must not have an error when the usecase is executed")
        }

        successViewModel?.viewDidLoad()

        wait(for: [expectation], timeout: 10)
    }
    
    func testSelectCell_Success() {
        let expectation = expectation(description: "When selecting any of the available episoded, a valid model must be created to propagate it that contains valid values ​​for each variable of the model")

        successViewModel?.model.bind { [weak self] model in
            guard let self = self,
                  let model = model else { return }

            XCTAssertNotNil(model)
            self.successViewModel?.selectCell(atIndex: 0)
        }

        successViewModel?.episodeDetailModel.bind { model in
            guard let model = model else { return }
            XCTAssertNotNil(model)
            XCTAssertNotNil(model.id)
            XCTAssertEqual(model.id, 1)
            XCTAssertNotNil(model.name)
            XCTAssertEqual(model.name, "Pilot")
            XCTAssertNotNil(model.airDate)
            XCTAssertEqual(model.airDate, "December 2, 2013")
            XCTAssertNotNil(model.episode)
            XCTAssertEqual(model.episode, "S01E01")
            XCTAssertNotNil(model.characters)
            XCTAssertNotNil(model.url)
            XCTAssertEqual(model.url, "https://rickandmortyapi.com/api/episode/1")
            XCTAssertNotNil(model.created)
            XCTAssertEqual(model.created, "2017-11-10T12:56:33.798Z")

            expectation.fulfill()
        }

        successViewModel?.showEmptyStateError.bind { error in
            guard let error = error, error else { return }
            XCTFail("Successfully test must not have an error when the usecase is executed")
        }

        successViewModel?.viewDidLoad()

        wait(for: [expectation], timeout: 10)
    }
}
