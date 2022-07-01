//
//  BaseNetwork.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import Alamofire

class BaseNetwork {
    
    private let session = SessionManager.shared.session
        
    func getData<T: Codable>(request: APIRequests,
                             delegate: NetworkRequestProtocol?,
                             success: @escaping (T) -> Void,
                             failure: @escaping (AFError) -> Void) {
        
        delegate?.networkRequestWillStart()
        session.request(request).responseDecodable { (response: DataResponse<T, AFError>) in
            
            switch response.result {
            case .success(let response):
                success(response)
                delegate?.networkRequestDidFinish()
            case .failure(let error):
                failure(error)
                delegate?.networkRequestDidFinish(with: error.localizedDescription)
            }
        }
    }
}
