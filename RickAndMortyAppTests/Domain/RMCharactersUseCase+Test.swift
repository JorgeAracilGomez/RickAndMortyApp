//
//  RMCharactersUseCase+Test.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 11/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMCharactersUseCaseTest: XCTestCase {
    
    var successUseCase: RMCharactersUseCase?
    var failureUseCase: RMCharactersUseCase?
    
    override func setUp() {
        super.setUp()
        successUseCase = DefaultRMCharactersUseCase(repository: RMCharactersRepositorySuccessMock())
        failureUseCase = DefaultRMCharactersUseCase(repository: RMCharactersRepositoryFailureMock())
    }
    
    override func tearDown() {
        successUseCase = nil
        failureUseCase = nil
        super.tearDown()
    }
    
    func testRMCharactersUseCaseTest_Success() {
        let expectation = expectation(description: "You must obtain a valid entity that contains a info model and a results model with a valid values. In adition, the error closure do not be call")

        let parameters = RMCharactersUseCaseParameters()
        successUseCase?.execute(params: parameters) { result in
            switch result {
            case .success(let entity):
                
                // Info Model Assertions
                XCTAssertNotNil(entity)
                XCTAssertNotNil(entity.info)
                XCTAssertNotNil(entity.info?.count)
                XCTAssertEqual(entity.info?.count, 826)
                XCTAssertNotNil(entity.info?.pages)
                XCTAssertEqual(entity.info?.pages, 42)
                XCTAssertNotNil(entity.info?.next)
                XCTAssertEqual(entity.info?.next, "https://rickandmortyapi.com/api/character?page=2")
                XCTAssertNil(entity.info?.previous)
                
                // Results Model Assertions
                XCTAssertNotNil(entity.results)
                XCTAssertEqual(entity.results?.count, 20)
                for character in entity.results! {
                    XCTAssertNotNil(character.id)
                    XCTAssertNotNil(character.name)
                    XCTAssertNotNil(character.status)
                    XCTAssertNotNil(character.species)
                    XCTAssertNotNil(character.type)
                    XCTAssertNotNil(character.gender)
                    XCTAssertNotNil(character.origin)
                    XCTAssertNotNil(character.location)
                    XCTAssertNotNil(character.image)
                    XCTAssertNotNil(character.episode)
                    XCTAssertNotNil(character.url)
                    XCTAssertNotNil(character.created)
                }

                expectation.fulfill()

            case .failure(_):
                XCTFail("Success test must not fail when the usecase is executed")
            }
        }

        wait(for: [expectation], timeout: 10)
    }
    
    func testRMCharactersUseCaseTest_Failure() {
        let expectation = expectation(description: "You should get an error and it should not be nil")

        let parameters = RMCharactersUseCaseParameters()
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
