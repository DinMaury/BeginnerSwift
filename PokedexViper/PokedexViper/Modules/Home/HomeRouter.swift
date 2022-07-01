//
//  HomeRouter.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import UIKit

protocol HomeRouterProtocol {
    
    func show(presenter: HomePresenterProtocol) -> HomeViewController
    func showDetails(pokemonId: String)
}


final class HomeRouter {
    
    //MARK: - Properties
    private weak var viewControllr: UIViewController?
    
}

// MARK: - HomeRouterProtocol
extension HomeRouter: HomeRouterProtocol {

    func show(presenter: HomePresenterProtocol) -> HomeViewController {
        
        let viewController = HomeViewController(presenter)
        
        self.viewControllr = viewController
        
        return viewController
    }
    
    func showDetails(pokemonId: String) {
        guard let navigationController = viewControllr?.navigationController else { return }
        
        let module = HomeDetailModule(pokemonId: pokemonId)
        module.show(in: navigationController)
    }
    
}
