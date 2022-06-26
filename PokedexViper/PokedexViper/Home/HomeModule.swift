//
//  HomeModule.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import Foundation

final class HomeModule {
    
    private let presenter: HomePresenterProtocol
    
    init() {
    
        presenter = HomePresenter(router: HomeRouter(), interactor: HomeInteractor())
    }
    
}

extension HomeModule {
    
    func show() -> HomeViewController {
        
        presenter.show()
    }
    
}
