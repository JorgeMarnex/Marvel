//
//  BaseCoordinator.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import Foundation
import UIKit

class BaseCoordinator: CoordinatorType {
    
    var parentCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType] = [CoordinatorType]()
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start(parentCoordinator: CoordinatorType? = nil) {
        parentCoordinator?.add(child: self)
    }
    
    func didFinish() {
        parentCoordinator?.remove(child: self)
        childDidFinish()
    }
    
    func childDidFinish() {
        childCoordinators.forEach({ $0.didFinish() })
    }
    
    func add(child: CoordinatorType) {
        if childCoordinators.filter({ $0 === child }).first == nil {
            childCoordinators.append(child)
            (child as? BaseCoordinator)?.parentCoordinator = self
        }
    }
    
    func remove(child: CoordinatorType) {
        childCoordinators.removeAll(where: { $0 === child })
        debugPrint("\(child) coordinator removed")
    }
}
