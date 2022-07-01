//
//  CharactersDataSourceTests.swift
//  MarvelTests
//
//  Created by Jorge Martínez on 1/7/22.
//

import XCTest
@testable import Marvel

final class CharactersDataSourceTests: XCTestCase {

    var sut: CharactersDataSourceDelegate!

    override func setUpWithError() throws {
        // Arrange
        sut = CharactersDataSource()
    }
    
    func test_whenOffsetIsLowerThanTotalItems_shouldGetNotEmptyResults() {
        // Act
        let expectation = self.expectation(description: "GET Characters Response data")
        sut.getCharacters(delegate: nil, offset: 0) { response in
            XCTAssertTrue(!(response.data?.results?.isEmpty ?? true))
            expectation.fulfill()
        } failure: { error in
            XCTFail(error.localizedDescription)
        }

        
        // Assert
        self.wait(for: [expectation], timeout: 5)
    }
    
    func test_whenOffsetIsGreaterThanTotalItems_shouldGetEmptyResults() {
        // Act
        let expectation = self.expectation(description: "GET Characters Response empty data")
        sut.getCharacters(delegate: nil, offset: 0) { response in
            
            self.sut.getCharacters(delegate: nil, offset: response.data?.total ?? 0) { response in
                XCTAssertTrue(response.data?.results?.isEmpty ?? false)
                expectation.fulfill()
            } failure: { error in
                XCTFail(error.localizedDescription)
            }
            
        } failure: { error in
            XCTFail(error.localizedDescription)
        }

        
        // Assert
        self.wait(for: [expectation], timeout: 5)
    }
}
