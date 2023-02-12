//
//  RMCharactersSelectorViewModel+Test.swift
//  RickAndMortyAppTests
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMCharactersSelectorViewModelTest: XCTestCase {
    
    // Subject Under Test
    var successViewModel: RMCharactersSelectorViewModel?
    var failureViewModel: RMCharactersSelectorViewModel?
    
    // Injected Objects
    var succesUseCase: RMCharactersUseCase?
    var failureUseCase: RMCharactersUseCase?
    
    override func setUp() {
        super.setUp()
        succesUseCase = DefaultRMCharactersUseCase(repository: RMCharactersRepositorySuccessMock())
        failureUseCase = DefaultRMCharactersUseCase(repository: RMCharactersRepositoryFailureMock())
        
        successViewModel = DefaultRMCharactersSelectorViewModel(charactersUseCase: succesUseCase!)
        failureViewModel = DefaultRMCharactersSelectorViewModel(charactersUseCase: failureUseCase!)
    }
    
    override func tearDown() {
        succesUseCase = nil
        failureUseCase = nil
        successViewModel = nil
        failureViewModel = nil
        super.tearDown()
    }
    
    func testViewDidLoad_UseCaseSucces() {
        let expectation = expectation(description: "After the correct execution of the UseCase, the model of the view must be created and it is binded, obtaining 20 characters and a false value for Fetching Data Finished flag.")

        successViewModel?.model.bind { model in
            guard let model = model else { return }
            XCTAssertNotNil(model)
            XCTAssertFalse(model.isFetchDataFinished)
            XCTAssertTrue(model.characters.count == 20)
            
            for character in model.characters {
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
        }

        successViewModel?.showEmptyStateError.bind { error in
            guard let error = error, error else { return }
            XCTFail("Successfully test must not have an error when the usecase is executed")
        }

        successViewModel?.viewDidLoad()

        wait(for: [expectation], timeout: 10)
    }
    
    func testViewDidLoad_UseCaseFailure() {
        let expectationModel = expectation(description: "After the execution error of the UseCase, a empty model should be received and it should not be null, but must contains an empty array of characters an a true boolean flag for not try to fetch more data")
        let expectationError = expectation(description: "After the execution error of the UseCase, an error flag should be received and it should be a true boolean state indicating that the empty state view must be showed")

        failureViewModel?.model.bind { model in
            guard let model = model else { return }
            XCTAssertNotNil(model)
            XCTAssertTrue(model.characters.isEmpty)
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
    
    func testFetchNewCharacters_UseCaseSucces() {
        let expectation = expectation(description: "After the correct execution of viewDidLoad, when calling for first time the fetchNewCharacters method we need to fetch another 20 Characters, append it to the model an bind it again to the view controller, obtaining 40 characters and a false value for Fetching Data Finished flag.")

        successViewModel?.model.bind { [weak self] model in
            guard let self = self, let model = model else { return }
            if model.characters.count == 20 {
                self.successViewModel?.fetchNewCharacters()
            } else {
                XCTAssertNotNil(model)
                XCTAssertFalse(model.isFetchDataFinished)
                XCTAssertTrue(model.characters.count == 40)

                for character in model.characters {
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
        let expectation = expectation(description: "When selecting any of the available character, a valid model must be created to propagate it that contains valid values ​​for each variable of the model")

        successViewModel?.model.bind { [weak self] model in
            guard let self = self,
                  let model = model else { return }

            XCTAssertNotNil(model)
            self.successViewModel?.selectCell(atIndex: 0)
        }

        successViewModel?.characterDetailModel.bind { model in
            guard let model = model else { return }
            XCTAssertNotNil(model)
            XCTAssertNotNil(model.id)
            XCTAssertEqual(model.id, 1)
            XCTAssertNotNil(model.name)
            XCTAssertEqual(model.name, "Rick Sanchez")
            XCTAssertNotNil(model.status)
            XCTAssertEqual(model.status, .Alive)
            XCTAssertNotNil(model.species)
            XCTAssertEqual(model.species, "Human")
            XCTAssertNotNil(model.type)
            XCTAssertEqual(model.type, "")
            XCTAssertNotNil(model.gender)
            XCTAssertEqual(model.gender, .Male)
            XCTAssertNotNil(model.origin)
            XCTAssertEqual(model.origin?.name, "Earth (C-137)")
            XCTAssertEqual(model.origin?.url, "https://rickandmortyapi.com/api/location/1")
            XCTAssertNotNil(model.location)
            XCTAssertEqual(model.location?.name, "Citadel of Ricks")
            XCTAssertEqual(model.location?.url, "https://rickandmortyapi.com/api/location/3")
            XCTAssertNotNil(model.image)
            XCTAssertEqual(model.image, "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
            XCTAssertNotNil(model.episode)
            XCTAssertEqual(model.episode?.count, 51)
            XCTAssertNotNil(model.url)
            XCTAssertEqual(model.url, "https://rickandmortyapi.com/api/character/1")
            XCTAssertNotNil(model.created)
            XCTAssertEqual(model.created, "2017-11-04T18:48:46.250Z")

            expectation.fulfill()
        }

        successViewModel?.showEmptyStateError.bind { error in
            guard let error = error, error else { return }
            XCTFail("Successfully test must not have an error when the usecase is executed")
        }

        successViewModel?.viewDidLoad()

        wait(for: [expectation], timeout: 10)
    }
    
    func testFilterCharacters_UseCaseSucces() {
        let expectation = expectation(description: "After the correct execution of viewDidLoad, when calling for first time the filterCharacters method we need to fetch a diferent 20 Characters that are obtained with the search filter and bind it again to the view controller, obtaining only 20 characters and a false value for Fetching Data Finished flag.")

        var viewDidLoadCalledFlag: Bool = false
        
        successViewModel?.model.bind { [weak self] model in
            guard let self = self, let model = model else { return }
            if !viewDidLoadCalledFlag {
                viewDidLoadCalledFlag = true
                self.successViewModel?.filterCharacters(withSearchFilter: "Fake")
            } else {
                XCTAssertNotNil(model)
                XCTAssertFalse(model.isFetchDataFinished)
                XCTAssertTrue(model.characters.count == 20)

                for character in model.characters {
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
            }
        }

        successViewModel?.showEmptyStateError.bind { error in
            guard let error = error, error else { return }
            XCTFail("Successfully test must not have an error when the usecase is executed")
        }

        successViewModel?.viewDidLoad()

        wait(for: [expectation], timeout: 10)
    }
}

