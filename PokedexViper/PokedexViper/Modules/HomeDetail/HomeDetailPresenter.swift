//
//  HomeDetailPresenter.swift
//  PokedexViper
//
//  Created by Maury on 27/06/22.
//

import UIKit

// MARK: - Protocol
protocol HomeDetailPresenterProtocol {
    
    func setupDelegate(delegate: HomeDetailDelegate)
    
    func show(in navigationController: UINavigationController)
    func fetchPokemon()
}

//MARK: - Delegates
protocol HomeDetailDelegate: AnyObject {
    
    func showDetails(pokemon: PokemonDetailFetched)
}

// MARK: - Presenter
final class HomeDetailPresenter {
    
    // MARK: - Properties
    private let router: HomeDetailRouterProtocol
    private let interactor: HomeDetailInteractorProtocol
    private weak var delegate: HomeDetailDelegate?
    
    //MARK: - Inits
    init(router: HomeDetailRouterProtocol, interactor: HomeDetailInteractorProtocol) {
        
        self.router = router
        self.interactor = interactor
    }
}

//MARK: - HomeDetailPresenterProtocol

extension HomeDetailPresenter: HomeDetailPresenterProtocol {
    
    func setupDelegate(delegate: HomeDetailDelegate) {
        self.delegate = delegate
    }
    
    func show(in navigationController: UINavigationController) {
        router.show(presenter: self, in: navigationController)
        
    }
    
    func fetchPokemon() {
        interactor.fetchPokemon() { fetched in
            self.delegate?.showDetails(pokemon: fetched)
        }
    }
}
