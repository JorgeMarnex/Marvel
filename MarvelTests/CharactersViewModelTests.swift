//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by Jorge Martínez on 28/6/22.
//

import XCTest
@testable import Marvel

final class CharactersViewModelTests: XCTestCase {

    var sut: CharactersViewModel!
    var charactersMock: CharactersMock!

    override func setUpWithError() throws {
        // Arrange
        charactersMock = CharactersMock()
        sut = CharactersViewModel(coordinatorDelegate: nil, dataSourceDelegate: charactersMock, visualResponseDelegate: nil)
    }
    
    func test_whenCharactersResponseIsNotEmpty_thenViewModelContainsCharactersData() {
        // Act
        charactersMock.successResult = true
        charactersMock.expectation = self.expectation(description: "Contains Data")
        sut.viewDidLoad()
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(!(sut.characters.value?.isEmpty ?? true))
    }
    
    func test_whenCharactersResponseIsError_thenViewModelContainsCharactersEmptyData() {
        // Act
        charactersMock.successResult = false
        charactersMock.expectation = self.expectation(description: "Contains Error")
        sut.viewDidLoad()
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(sut.characters.value?.isEmpty ?? false)
    }
}
