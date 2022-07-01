//
//  SceneDelegate.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: CharactersCoordinator?
    
    static var keyWindow: UIWindow? {
        guard let delegate = UIApplication.shared.connectedScenes.first(where: { $0.delegate is SceneDelegate })?.delegate as? SceneDelegate, let window = delegate.window else { return nil }
        return window
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        coordinator = CharactersCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

