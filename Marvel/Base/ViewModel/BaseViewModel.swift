//
//  BaseViewModel.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import Foundation

protocol NetworkRequestProtocol: AnyObject {
    func networkRequestWillStart()
    func networkRequestDidFinish()
    func networkRequestDidFinish(with error: String)
}

class BaseViewModel: NetworkRequestProtocol {

    weak var visualResponseDelegate: VisualResponseProtocol?
    
    init(visualResponseDelegate: VisualResponseProtocol?) {
        self.visualResponseDelegate = visualResponseDelegate
    }
    
    func networkRequestWillStart() {
        visualResponseDelegate?.showLoader()
    }
    
    func networkRequestDidFinish() {
        visualResponseDelegate?.hideLoader()
    }
    
    func networkRequestDidFinish(with error: String) {
        visualResponseDelegate?.hideLoader()
        visualResponseDelegate?.showError(error: error)
    }
}
