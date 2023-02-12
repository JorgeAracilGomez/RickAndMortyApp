//
//  RMCharacterDetailUseCase+Test.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 11/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMCharacterDetailUseCaseTest: XCTestCase {
    
    // Subject Under Test
    var successUseCase: RMCharacterDetailUseCase?
    var failureUseCaseForLocation: RMCharacterDetailUseCase?
    var failureUseCaseForEpisodes: RMCharacterDetailUseCase?
    var failureUseCaseForBoth: RMCharacterDetailUseCase?
    
    var locationsUseCaseSuccess: RMLocationsUseCase?
    var locationsUseCaseFailure: RMLocationsUseCase?
    var episodesUseCaseSuccess: RMEpisodesUseCase?
    var episodesUseCaseFailure: RMEpisodesUseCase?
    
    override func setUp() {
        super.setUp()
        locationsUseCaseSuccess = DefaultRMLocationsUseCase(repository: RMLocationsRepositorySuccessMock())
        locationsUseCaseFailure = DefaultRMLocationsUseCase(repository: RMLocationsRepositoryFailureMock())
        episodesUseCaseSuccess = DefaultRMEpisodesUseCase(repository: RMEpisodesRepositoryResultsSuccessMock())
        episodesUseCaseFailure = DefaultRMEpisodesUseCase(repository: RMEpisodesRepositoryFailureMock())
        
        successUseCase = DefaultRMCharacterDetailUseCase(locationsUseCase: locationsUseCaseSuccess!,episodesUseCase: episodesUseCaseSuccess!)
        failureUseCaseForLocation = DefaultRMCharacterDetailUseCase(locationsUseCase: locationsUseCaseFailure!, episodesUseCase: episodesUseCaseSuccess!)
        failureUseCaseForEpisodes = DefaultRMCharacterDetailUseCase(locationsUseCase: locationsUseCaseSuccess!, episodesUseCase: episodesUseCaseFailure!)
        failureUseCaseForBoth = DefaultRMCharacterDetailUseCase(locationsUseCase: locationsUseCaseFailure!, episodesUseCase: episodesUseCaseFailure!)
    }
    
    override func tearDown() {
        successUseCase = nil
        failureUseCaseForLocation = nil
        failureUseCaseForEpisodes = nil
        failureUseCaseForBoth = nil
        locationsUseCaseSuccess = nil
        locationsUseCaseFailure = nil
        episodesUseCaseSuccess = nil
        episodesUseCaseFailure = nil
        super.tearDown()
    }
    
    func testRMCharacterDetailUseCaseTest_Success() {
        let expectation = expectation(description: "You must obtain a valid entity that contains a valid Locations Info and a valid Episodes Info. In adition, the error closure do not be call")

        let parameters = RMCharacterDetailUseCaseParameters(originID: "FAKE", locationID: "FAKE")
        successUseCase?.execute(params: parameters) { result in
            switch result {
            case .success(let entity):

                // Entity Assertions
                XCTAssertNotNil(entity)
                
                // Entity Locations Assertions
                XCTAssertNotNil(entity.locations)
                XCTAssertEqual(entity.locations?.count, 2)
                for location in entity.locations! {
                    XCTAssertNotNil(location.id)
                    XCTAssertNotNil(location.name)
                    XCTAssertNotNil(location.type)
                    XCTAssertNotNil(location.dimension)
                    XCTAssertNotNil(location.residents)
                    XCTAssertNotNil(location.url)
                    XCTAssertNotNil(location.created)
                }
                
                // Entity Epidodes Assertions
                XCTAssertNotNil(entity.episodes)
                XCTAssertEqual(entity.episodes?.count, 51)
                for episode in entity.episodes! {
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
    
    func testRMCharacterDetailUseCaseTest_Failure_ForLocations() {
        let expectation = expectation(description: "You should get an error and it should not be nil")

        let parameters = RMCharacterDetailUseCaseParameters(originID: "FAKE", locationID: "FAKE")
        failureUseCaseForLocation?.execute(params: parameters) { result in
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
    
    func testRMCharacterDetailUseCaseTest_Failure_ForEpisodes() {
        let expectation = expectation(description: "You should get an error and it should not be nil")

        let parameters = RMCharacterDetailUseCaseParameters(originID: "FAKE", locationID: "FAKE")
        failureUseCaseForEpisodes?.execute(params: parameters) { result in
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
    
    func testRMCharacterDetailUseCaseTest_Failure_ForBoth() {
        let expectation = expectation(description: "You should get an error and it should not be nil")

        let parameters = RMCharacterDetailUseCaseParameters(originID: "FAKE", locationID: "FAKE")
        failureUseCaseForBoth?.execute(params: parameters) { result in
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
