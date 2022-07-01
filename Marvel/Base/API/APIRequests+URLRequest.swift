//
//  APIRequests+URLRequest.swift
//  Marvel
//
//  Created by Jorge Martínez on 29/6/22.
//

import Alamofire

extension APIRequests {
    
    func asURLRequest() throws -> URLRequest {
        
        func setURLComponents(_ params: [URLQueryItem]) {
            var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }
        
        // Base URL + endpoint
        let url = try APIConstants.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Session parameters
        var queryParams = APIConstants.sessionParameters.map({ URLQueryItem(name: $0.key, value: "\($0.value)") })
        setURLComponents(queryParams)
        
        // Parameters
        switch parameters {
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        case .url(let params):
            let newParams = params.map({ URLQueryItem(name: $0.key, value: "\($0.value)") })
            queryParams.append(contentsOf: newParams)
            setURLComponents(queryParams)
        case .none:
            break
        }
        
        return urlRequest
    }
}
