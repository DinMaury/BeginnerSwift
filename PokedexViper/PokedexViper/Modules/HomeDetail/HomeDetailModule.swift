//
//  HomeDetailModule.swift
//  PokedexViper
//
//  Created by Maury on 27/06/22.
//

import UIKit

final class HomeDetailModule {
    
    private let presenter: HomeDetailPresenterProtocol
    
    init(pokemonId: String) {
    
        presenter = HomeDetailPresenter(router: HomeDetailRouter(),
                                        interactor: HomeDetailInteractor(pokemonId: pokemonId))
    }
    
}

extension HomeDetailModule {
    
    func show(in navigationController: UINavigationController) {
        
        presenter.show(in: navigationController)
    }
}
