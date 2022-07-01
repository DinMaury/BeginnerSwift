//
//  HomeDetailRouter.swift
//  PokedexViper
//
//  Created by Maury on 27/06/22.
//

import UIKit

protocol HomeDetailRouterProtocol {
    
    func show(presenter: HomeDetailPresenterProtocol, in navigationController: UINavigationController)
}


final class HomeDetailRouter {
    
    //MARK: - Properties
    private weak var viewControllr: UIViewController?
    
}

// MARK: - HomeDetailRouterProtocol
extension HomeDetailRouter: HomeDetailRouterProtocol {
    
    func show(presenter: HomeDetailPresenterProtocol, in navigationController: UINavigationController) {
        
        let viewController = PokemonDetailsViewController(presenter)
        navigationController.pushViewController(viewController, animated: true)
        self.viewControllr = viewController
        
    }
}
