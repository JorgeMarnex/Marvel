//
//  BaseViewController.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import Foundation
import UIKit

protocol VisualResponseProtocol: AnyObject {
    func showLoader()
    func hideLoader()
    func showError(error: String)
}

protocol BaseViewControllerNavigationOptions: AnyObject {
    var navTitle: String? { get set }
    var navBarTitleLarge: Bool? { get set }
}

class BaseViewController: UIViewController, BaseViewControllerNavigationOptions {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
        
    var navTitle: String? {
        didSet {
            self.title = navTitle
        }
    }
    
    var navBarTitleLarge: Bool? {
        didSet {
            guard let navBarTitleLarge = navBarTitleLarge else { return }
            self.navigationController?.navigationBar.prefersLargeTitles = navBarTitleLarge
        }
    }
}

extension BaseViewController: VisualResponseProtocol, Alertable, Loadable {
    
    func showLoader() {
        self.showLoading()
    }
    
    func hideLoader() {
        self.hideLoading()
    }
    
    func showError(error: String) {
        self.showAlert(message: error)
    }
}
