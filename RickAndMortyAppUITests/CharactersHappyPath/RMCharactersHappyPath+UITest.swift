//
//  RMCharactersHappyPath+UITest.swift
//  RickAndMortyAppUITests
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMCharactersHappyPathUITest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testUIHappyPathViews() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        // MARK: Character Selection View Assertions
        
        let characterSelectionViewExpectation = expectation(description: "When the character selection screen has loaded, it should have a navigation bar containing a title, a characters collection view where there should be the same number of cell components as there are cells in the collection View.")
        
        let charactersSelectionNavigationBarTitle = app.navigationBars.children(matching: .staticText).firstMatch
        XCTAssert(charactersSelectionNavigationBarTitle.waitForExistence(timeout: 5.0))
        
        let charactersCollectionView = app.collectionViews["RMCharactersCollectionView"]
        let numberOfCellsInCharactersCollectionView = charactersCollectionView.cells.count
        let numberOfCharactersImagesInCollectionCells = app.images.matching(identifier: "RMCharacterCollectionViewCellImage").count
        let numberOfNameLabelsInCollectionCells = app.staticTexts.matching(identifier: "RMCharacterCollectionViewCellNameLabel").count

        XCTAssert(charactersCollectionView.exists)
        XCTAssertEqual(numberOfCellsInCharactersCollectionView, numberOfCharactersImagesInCollectionCells)
        XCTAssertEqual(numberOfCellsInCharactersCollectionView, numberOfNameLabelsInCollectionCells)
        
        characterSelectionViewExpectation.fulfill()
        
        
        // MARK: Character Cell Assertions

        let topCharacterCellExpectation = expectation(description: "For a given cell, it must exist in the view and contain the image and the name label to select the character.")

        let topCharacterCell = charactersCollectionView.cells.firstMatch
        let topCharacterImage = topCharacterCell.images["RMCharacterCollectionViewCellImage"]
        let topCharacterNameLabel = topCharacterCell.staticTexts.matching(identifier: "RMCharacterCollectionViewCellNameLabel").firstMatch

        XCTAssert(topCharacterCell.exists)
        XCTAssert(topCharacterImage.exists)
        XCTAssert(topCharacterNameLabel.exists)

        topCharacterCellExpectation.fulfill()
        
        
        // MARK: Character Detail View Assertions

        let characterDetailViewExpectation = expectation(description: "When the character detail screen has loaded, it should have a navigation bar containing a title, an image of the character, the status label, and three detail views (with title and subtitle) one of them with a secondary subtitle Label, and an episodes table where there should be the same number of cell components as there are cells in the collection View.")

        topCharacterCell.tap()

        let characterDetailNavigationBarTitle = app.navigationBars.children(matching: .staticText).firstMatch
        XCTAssert(characterDetailNavigationBarTitle.waitForExistence(timeout: 5.0))

        let characterDetailHeaderImage = app.images.matching(identifier: "RMCharacterDetailHeaderViewImage").firstMatch
        let characterDetailHeaderStatusLabel = app.staticTexts.matching(identifier: "RMCharacterDetailHeaderViewStatusLabel").firstMatch
        let characterDetailInfoViewTitleLabelsCount = app.staticTexts.matching(identifier: "RMCharacterDetailInfoViewTitle").count
        let characterDetailInfoViewSeparatorsCount = app.staticTexts.matching(identifier: "RMCharacterDetailInfoViewSeparator").count
        let characterDetailInfoViewDescriptionLabelsCount = app.staticTexts.matching(identifier: "RMCharacterDetailInfoViewDescription").count
        let characterDetailInfoViewSecondaryDescriptionLabelsCount = app.staticTexts.matching(identifier: "RMCharacterDetailInfoViewSecondaryDescription").count

        XCTAssert(characterDetailHeaderImage.exists)
        XCTAssert(characterDetailHeaderStatusLabel.exists)
        XCTAssertEqual(characterDetailInfoViewTitleLabelsCount, 3)
        XCTAssertEqual(characterDetailInfoViewSeparatorsCount, 3)
        XCTAssertEqual(characterDetailInfoViewDescriptionLabelsCount, 3)
        XCTAssertEqual(characterDetailInfoViewSecondaryDescriptionLabelsCount, 1)
        
        let characterDetailTable = app.tables["GNBCharacterDetailTableView"]
        let numberOfCellsInCharacterDetailTableView = characterDetailTable.cells.count
        let numberOfSeasonLabelInCharacterDetailCells = app.staticTexts.matching(identifier: "RMEpisodeTableViewCellSeasonLabel").count
        let numberOfReleasedLabelInCharacterDetailCells = app.staticTexts.matching(identifier: "RMEpisodeTableViewCellReleasedLabel").count
        let numberOfTitleLabelInCharacterDetailCells = app.staticTexts.matching(identifier: "RMEpisodeTableViewCellTitleLabel").count
        
        XCTAssert(characterDetailTable.exists)
        XCTAssertEqual(numberOfCellsInCharacterDetailTableView, numberOfSeasonLabelInCharacterDetailCells)
        XCTAssertEqual(numberOfCellsInCharacterDetailTableView, numberOfReleasedLabelInCharacterDetailCells)
        XCTAssertEqual(numberOfCellsInCharacterDetailTableView, numberOfTitleLabelInCharacterDetailCells)

        characterDetailViewExpectation.fulfill()
        
        
        // MARK: Character Detail Cell Assertions

        let topCharacterDetailCellExpectation = expectation(description: "For a given cell, it must exist in the view and contain the left and right labels, as well as the name center Label.")

        let topCharacterDetailCell = characterDetailTable.cells.firstMatch
        let topCharacterDetailCellSeasonLabel = topCharacterDetailCell.staticTexts.matching(identifier: "RMEpisodeTableViewCellSeasonLabel").firstMatch
        let topTCharacterDetailCellReleasedLabel = topCharacterDetailCell.staticTexts.matching(identifier: "RMEpisodeTableViewCellReleasedLabel").firstMatch
        let topCharacterDetailCellTitleLabel = topCharacterDetailCell.staticTexts.matching(identifier: "RMEpisodeTableViewCellTitleLabel").firstMatch

        XCTAssert(topCharacterDetailCell.exists)
        XCTAssert(topCharacterDetailCellSeasonLabel.exists)
        XCTAssert(topTCharacterDetailCellReleasedLabel.exists)
        XCTAssert(topCharacterDetailCellTitleLabel.exists)
        
        topCharacterDetailCellExpectation.fulfill()
        
        wait(for: [characterSelectionViewExpectation, topCharacterCellExpectation, characterDetailViewExpectation, topCharacterDetailCellExpectation], timeout: 20)
    }
}
