//
//  RMLocationsUseCase+Test.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 11/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMLocationsUseCaseTest: XCTestCase {
    
    var successUseCase: RMLocationsUseCase?
    var failureUseCase: RMLocationsUseCase?
    
    override func setUp() {
        super.setUp()
        successUseCase = DefaultRMLocationsUseCase(repository: RMLocationsRepositorySuccessMock())
        failureUseCase = DefaultRMLocationsUseCase(repository: RMLocationsRepositoryFailureMock())
    }
    
    override func tearDown() {
        successUseCase = nil
        failureUseCase = nil
        super.tearDown()
    }
    
    func testRMLocationsUseCaseTest_Success() {
        let expectation = expectation(description: "You must obtain a valid entity that contains a valid locations info. In adition, the error closure do not be call")

        let parameters = RMLocationsUseCaseParameters(originID: "FAKE", locationID: "FAKE")
        successUseCase?.execute(params: parameters) { result in
            switch result {
            case .success(let entity):

                // Entity Assertions
                XCTAssertNotNil(entity)
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

                expectation.fulfill()

            case .failure(_):
                XCTFail("Success test must not fail when the usecase is executed")
            }
        }

        wait(for: [expectation], timeout: 10)
    }
    
    func testRMLocationsUseCaseTest_Failure() {
        let expectation = expectation(description: "You should get an error and it should not be nil")

        let parameters = RMLocationsUseCaseParameters(originID: "FAKE", locationID: "FAKE")
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
