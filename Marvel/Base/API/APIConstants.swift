//
//  APIConstants.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import Alamofire

struct APIConstants {
    static let baseURL = "http://gateway.marvel.com"
    static let ts = "1"
    static let apiKey = "3c98b2e96b2bece901c87ab863a65d5c"
    static let hash = "571f972e293b0c868296dc95011e6bb7"
    static let sessionParameters = ["ts": ts, "apikey": apiKey, "hash": hash]
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "Application/json"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
    case none
}
