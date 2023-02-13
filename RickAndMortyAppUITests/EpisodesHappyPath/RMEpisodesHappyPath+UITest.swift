//
//  RMEpisodesHappyPath+UITest.swift
//  RickAndMortyAppUITests
//
//  Created by Jorge Aracil Gomez on 12/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class RMEpisodesHappyPathUITest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testUIHappyPathViews() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        // MARK: Go to Episode Operative
        
        let tabBarEpisodeButton = app.tabBars.firstMatch.buttons.element(boundBy: 1)
        XCTAssert(tabBarEpisodeButton.waitForExistence(timeout: 5.0))
        tabBarEpisodeButton.tap()
        
        // MARK: Episode Selection View Assertions
        
        let episodesSelectionViewExpectation = expectation(description: "When the episodes selection screen has loaded, it should have a navigation bar containing a title, a episodes table view where there should be the same number of cell components as there are cells in the table View.")
        
        let episodesSelectionNavigationBarTitle = app.navigationBars.children(matching: .staticText).firstMatch
        XCTAssert(episodesSelectionNavigationBarTitle.waitForExistence(timeout: 5.0))

        let episodesTableView = app.tables["RMEpisodesTableView"]
        XCTAssert(episodesTableView.waitForExistence(timeout: 5.0))
        
        let numberOfCellsInEpisodesTableView = episodesTableView.cells.count
        let numberOfSeasonLabelsInTableViewCells = app.staticTexts.matching(identifier: "RMEpisodeTableViewCellSeasonLabel").count
        let numberOfReleasedLabelsInTableViewCells = app.staticTexts.matching(identifier: "RMEpisodeTableViewCellReleasedLabel").count
        let numberOfNameLabelsInTableViewCells = app.staticTexts.matching(identifier: "RMEpisodeTableViewCellTitleLabel").count
        
        XCTAssertEqual(numberOfCellsInEpisodesTableView, numberOfSeasonLabelsInTableViewCells)
        XCTAssertEqual(numberOfCellsInEpisodesTableView, numberOfReleasedLabelsInTableViewCells)
        XCTAssertEqual(numberOfCellsInEpisodesTableView, numberOfNameLabelsInTableViewCells)

        episodesSelectionViewExpectation.fulfill()
        
        
        // MARK: Character Cell Assertions

        let topEpisodeCellExpectation = expectation(description: "For a given cell, it must exist in the view and contain the labels to select the episode.")

        let topEpisodeCell = episodesTableView.cells.firstMatch
        let topEpisodeSeasonLabel = topEpisodeCell.staticTexts.matching(identifier: "RMEpisodeTableViewCellSeasonLabel").firstMatch
        let topEpisodeReleaseLabel = topEpisodeCell.staticTexts.matching(identifier: "RMEpisodeTableViewCellReleasedLabel").firstMatch
        let topEpisodeNameLabel = topEpisodeCell.staticTexts.matching(identifier: "RMEpisodeTableViewCellTitleLabel").firstMatch

        XCTAssert(topEpisodeCell.exists)
        XCTAssert(topEpisodeSeasonLabel.exists)
        XCTAssert(topEpisodeReleaseLabel.exists)
        XCTAssert(topEpisodeNameLabel.exists)

        topEpisodeCellExpectation.fulfill()
        
        
        // MARK: Episode Detail View Assertions

        let episodeDetailViewExpectation = expectation(description: "When the episode detail screen has loaded, it should have a navigation bar containing a title, a seasons, episode and release Labels and a characters table where there should be the same number of cell components as there are cells in the table View.")

        topEpisodeCell.tap()

        let episodeDetailNavigationBarTitle = app.navigationBars.children(matching: .staticText).firstMatch
        XCTAssert(episodeDetailNavigationBarTitle.waitForExistence(timeout: 5.0))

        let characterDetailHeaderSeasonLabel = app.staticTexts.matching(identifier: "RMEpisodeDetailHeaderViewSeasonLabel").firstMatch
        let characterDetailHeaderEpisodeLabel = app.staticTexts.matching(identifier: "RMEpisodeDetailHeaderViewEpisodeLabel").firstMatch
        let characterDetailHeaderReleaseLabel = app.staticTexts.matching(identifier: "RMEpisodeDetailHeaderViewReleasedLabel").firstMatch
        
        XCTAssert(characterDetailHeaderSeasonLabel.exists)
        XCTAssert(characterDetailHeaderEpisodeLabel.exists)
        XCTAssert(characterDetailHeaderReleaseLabel.exists)

        let episodeDetailTable = app.tables["RMEpisodeDetailTableView"]
        let numberOfCellsInEpisodeDetailTableView = episodeDetailTable.cells.count
        let numberOfImagesInEpisodeDetailTableView = app.images.matching(identifier: "RMEpisodeDetailCharacterCellImage").count
        let numberOfNameLabelsInEpisodeDetailTableView = app.staticTexts.matching(identifier: "RMEpisodeDetailCharacterCellNameLabel").count
        let numberOfTitleLabelsInEpisodeDetailTableView = app.staticTexts.matching(identifier: "RMCharacterDetailInfoViewTitle").count
        let numberOfDescriptionLabelsInEpisodeDetailTableView = app.staticTexts.matching(identifier: "RMCharacterDetailInfoViewDescription").count

        XCTAssert(episodeDetailTable.waitForExistence(timeout: 5.0))
        XCTAssertEqual(numberOfCellsInEpisodeDetailTableView, numberOfImagesInEpisodeDetailTableView)
        XCTAssertEqual(numberOfCellsInEpisodeDetailTableView, numberOfNameLabelsInEpisodeDetailTableView)
        XCTAssertEqual(numberOfCellsInEpisodeDetailTableView, numberOfTitleLabelsInEpisodeDetailTableView/3)
        XCTAssertEqual(numberOfCellsInEpisodeDetailTableView, numberOfDescriptionLabelsInEpisodeDetailTableView/3)

        episodeDetailViewExpectation.fulfill()
        
        
        // MARK: Character Detail Cell Assertions

        let topCharacterDetailCellExpectation = expectation(description: "For a given cell, it must exist in the view and contain the left and right image, the name Label as well as the three detail viws with his own Labels.")
        
        let topEpisodesDetailCell = episodeDetailTable.cells.firstMatch
        let episodeDetailImageViewCount = topEpisodesDetailCell.images.matching(identifier: "RMEpisodeDetailCharacterCellImage").count
        let episodeDetailNameLabelsCount = topEpisodesDetailCell.staticTexts.matching(identifier: "RMEpisodeDetailCharacterCellNameLabel").count
        let episodeDetailInfoViewTitleLabelsCount = topEpisodesDetailCell.staticTexts.matching(identifier: "RMCharacterDetailInfoViewTitle").count
        let episodeDetailInfoViewDescriptionLabelsCount = topEpisodesDetailCell.staticTexts.matching(identifier: "RMCharacterDetailInfoViewDescription").count

        XCTAssert(topEpisodesDetailCell.exists)
        XCTAssertEqual(episodeDetailImageViewCount, 1)
        XCTAssertEqual(episodeDetailNameLabelsCount, 1)
        XCTAssertEqual(episodeDetailInfoViewTitleLabelsCount, 3)
        XCTAssertEqual(episodeDetailInfoViewDescriptionLabelsCount, 3)

        topCharacterDetailCellExpectation.fulfill()
        
        wait(for: [episodesSelectionViewExpectation, topEpisodeCellExpectation, episodeDetailViewExpectation, topCharacterDetailCellExpectation], timeout: 20)
    }
}
