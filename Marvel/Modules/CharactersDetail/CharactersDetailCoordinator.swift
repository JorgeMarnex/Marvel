//
//  CharactersDetailCoordinator.swift
//  Marvel
//
//  Created by Jorge Martínez on 30/6/22.
//

import UIKit

protocol CharactersDetailCoordinatorDelegate: AnyObject {
    func didFinish()
}

final class CharactersDetailCoordinator: BaseCoordinator {
    
    private var viewModel: CharactersDetailViewModelDelegate?
    private var viewController: CharactersDetailViewController?
    var character: Character?
    
    override init(navigationController: UINavigationController?) {
        super.init(navigationController: navigationController)
    }
 
    override func start(parentCoordinator: CoordinatorType? = nil) {
        super.start(parentCoordinator: parentCoordinator)
        viewController = CharactersDetailViewController()
        viewModel = CharactersDetailViewModel(coordinatorDelegate: self, visualResponseDelegate: viewController, character: character)
        viewController?.viewModel = viewModel
        
        if let vc = viewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func didFinish() {
        super.didFinish()
        viewModel = nil
    }
}

extension CharactersDetailCoordinator: CharactersDetailCoordinatorDelegate {}
