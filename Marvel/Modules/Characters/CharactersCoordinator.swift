//
//  CharactersCoordinator.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import UIKit

protocol CharactersCoordinatorDelegate: AnyObject {
    func pushToCharactersDetail(character: Character?)
}

final class CharactersCoordinator: BaseCoordinator {
    
    private var viewModel: CharactersViewModelDelegate?
    private var viewController: CharactersViewController?
    private var dataSource: CharactersDataSourceDelegate?
    
    override init(navigationController: UINavigationController?) {
        super.init(navigationController: navigationController)
    }
 
    override func start(parentCoordinator: CoordinatorType? = nil) {
        super.start(parentCoordinator: parentCoordinator)
        viewController = CharactersViewController()
        dataSource = CharactersDataSource()
        viewModel = CharactersViewModel(coordinatorDelegate: self, dataSourceDelegate: dataSource, visualResponseDelegate: viewController)
        viewController?.viewModel = viewModel
        
        if let vc = viewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

extension CharactersCoordinator: CharactersCoordinatorDelegate {
    
    func pushToCharactersDetail(character: Character?) {
        let child = CharactersDetailCoordinator(navigationController: navigationController)
        child.character = character
        child.start(parentCoordinator: self)
    }
}
