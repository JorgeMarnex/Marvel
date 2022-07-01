//
//  APIConfiguration.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams  { get }
}
