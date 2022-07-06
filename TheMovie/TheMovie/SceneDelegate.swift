//
//  SceneDelegate.swift
//  TheMovie
//
//  Created by Maury on 5/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let module = HomeModule()
        let viewController = module.show()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.backgroundColor = .black
        
        self.window = window
    }

}
