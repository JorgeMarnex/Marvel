//
//  APIRouter.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import Foundation
import Alamofire

enum APIRequests: APIConfiguration {
    
    case getCharacters(offset: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getCharacters(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getCharacters(_):
            return "/v1/public/characters"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getCharacters(offset: let offset):
            return .url(["offset": offset])
        }
    }
}
