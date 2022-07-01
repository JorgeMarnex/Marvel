//
//  CharactersMock.swift
//  MarvelTests
//
//  Created by Jorge Martínez on 1/7/22.
//

import Alamofire
import XCTest
@testable import Marvel

final class CharactersMock: CharactersDataSourceDelegate {
    
    var successResult = true
    var expectation: XCTestExpectation?
    
    func getCharacters(delegate: NetworkRequestProtocol?, offset: Int, success: @escaping (CharactersResponse) -> Void, failure: @escaping (AFError) -> Void) {
        
        if successResult {
            success(CharactersResponse(data: CharactersData(offset: 0, limit: 20, total: 1562, results: [Character(id: 1, name: "Jorge", description: "Description", thumbnail: CharacterThumbnail(path: "path", fileExtension: "jpg"))])))
        } else {
            failure(.explicitlyCancelled)
        }
        
        expectation?.fulfill()
    }
}
