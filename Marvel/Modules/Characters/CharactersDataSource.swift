//
//  CharactersDataSource.swift
//  Marvel
//
//  Created by Jorge Martínez on 29/6/22.
//

import Alamofire

protocol CharactersDataSourceDelegate: AnyObject {
    func getCharacters(delegate: NetworkRequestProtocol?,
                       offset: Int,
                       success: @escaping (CharactersResponse) -> Void,
                       failure: @escaping (AFError) -> Void)
}

final class CharactersDataSource: BaseNetwork, CharactersDataSourceDelegate {
    
    func getCharacters(delegate: NetworkRequestProtocol?,
                       offset: Int,
                       success: @escaping (CharactersResponse) -> Void,
                       failure: @escaping (AFError) -> Void) {
        
        getData(request: .getCharacters(offset: offset), delegate: delegate, success: success, failure: failure)
    }
}
