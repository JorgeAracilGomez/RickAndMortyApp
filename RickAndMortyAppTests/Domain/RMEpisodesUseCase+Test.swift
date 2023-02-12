//
//  RMEpisodesUseCase+Test.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 11/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMEpisodesUseCaseTest: XCTestCase {
    
    var successUseCase: RMEpisodesUseCase?
    var failureUseCase: RMEpisodesUseCase?
    
    override func setUp() {
        super.setUp()
        successUseCase = DefaultRMEpisodesUseCase(repository: RMEpisodesRepositoryFullSuccessMock())
        failureUseCase = DefaultRMEpisodesUseCase(repository: RMEpisodesRepositoryFailureMock())
    }
    
    override func tearDown() {
        successUseCase = nil
        failureUseCase = nil
        super.tearDown()
    }
    
    func testRMEpisodesUseCaseTest_Success() {
        let expectation = expectation(description: "You must obtain a valid entity that contains a valid Episodes info. In adition, the error closure do not be call")

        let parameters = RMEpisodesUseCaseParameters()
        successUseCase?.execute(params: parameters) { result in
            switch result {
            case .success(let entity):

                // Info Model Assertions
                XCTAssertNotNil(entity)
                XCTAssertNotNil(entity.info)
                XCTAssertNotNil(entity.info?.count)
                XCTAssertEqual(entity.info?.count, 51)
                XCTAssertNotNil(entity.info?.pages)
                XCTAssertEqual(entity.info?.pages, 3)
                XCTAssertNotNil(entity.info?.next)
                XCTAssertEqual(entity.info?.next, "https://rickandmortyapi.com/api/episode?page=2")
                XCTAssertNil(entity.info?.previous)
                
                // Results Model Assertions
                XCTAssertNotNil(entity.results)
                XCTAssertEqual(entity.results?.count, 20)
                for episode in entity.results! {
                    XCTAssertNotNil(episode.id)
                    XCTAssertNotNil(episode.name)
                    XCTAssertNotNil(episode.airDate)
                    XCTAssertNotNil(episode.episode)
                    XCTAssertNotNil(episode.characters)
                    XCTAssertNotNil(episode.url)
                    XCTAssertNotNil(episode.created)
                }

                expectation.fulfill()

            case .failure(_):
                XCTFail("Success test must not fail when the usecase is executed")
            }
        }

        wait(for: [expectation], timeout: 10)
    }
    
    func testRMEpisodesUseCaseTest_Failure() {
        let expectation = expectation(description: "You should get an error and it should not be nil")

        let parameters = RMEpisodesUseCaseParameters()
        failureUseCase?.execute(params: parameters) { result in
            switch result {
            case .success(_):
                XCTFail("Failure test must not succedd when the usecase is executed")
            case .failure(let error):
                XCTAssertNotNil(error)

                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5)
    }
}
