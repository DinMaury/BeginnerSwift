//
//  HomeRouter.swift
//  TheMovie
//
//  Created by Maury on 5/07/22.
//

import UIKit

protocol HomeRouterProtocol {
    
    func show(presenter: HomePresenterProtocol) -> HomeViewController
    func showDetails()
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
    
    func showDetails() {
        guard let navigationController = viewControllr?.navigationController else { return }
        
//        let module = HomeDetailModule()
//        module.show(in: navigationController)
    }
    
}
