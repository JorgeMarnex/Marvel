//
//  APIProxy.swift
//  Marvel
//
//  Created by Jorge Martínez on 30/6/22.
//

import Alamofire

final class SessionManager {
    
    static let shared = SessionManager()
    var session: Session
    
    init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        
        let networkLogger = NetworkLogger()
        
        self.session = Session(configuration: configuration, eventMonitors: [networkLogger])
    }
}

final class NetworkLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "session")
    
    func requestDidFinish(_ request: Request) {
        print("Request: \(request.description)")
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else { return }
        print("Response: \(String(data: data, encoding: .utf8) ?? "")")
    }
}
