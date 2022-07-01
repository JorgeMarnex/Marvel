//
//  HomeModel.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import Foundation

struct CharactersResponse: Codable {
    let data: CharactersData?
}

struct CharactersData: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let results: [Character]?
}

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: CharacterThumbnail?
}

struct CharacterThumbnail: Codable {
    let path: String?
    let fileExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}

extension Character {
    var characterImageURL: URL? {
        let thumbnail: CharacterThumbnail? = self.thumbnail
        let path: String = thumbnail?.path ?? ""
        let fileExtension: String = thumbnail?.fileExtension ?? ""
        return URL(string: path + "." + fileExtension)
    }
}
