//
//  HomeDetailPresenter.swift
//  PokedexViper
//
//  Created by Maury on 27/06/22.
//

import UIKit

// MARK: - Protocol
protocol HomeDetailPresenterProtocol { // Variable
    
    // dataSource, delegate Type
    var dataSourceType: HomeDetailDataSourceType { get }
    var delegateType: HomeDetailDelegate? { get set }
    
    // dataSource, delegate Ability
    var dataSourceAbility: HomeDetailDataSourceAbility { get }
    var delegateAbility: HomeDetailDelegate? { get set }
    
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
    
    // Type
    var dataSourceType = HomeDetailDataSourceType()
    
    weak var delegateType: HomeDetailDelegate?
    
    // Ability
    
    var dataSourceAbility = HomeDetailDataSourceAbility()
    
    weak var delegateAbility: HomeDetailDelegate?
    
    //MARK: - Inits
    init(router: HomeDetailRouterProtocol, interactor: HomeDetailInteractorProtocol) {
        
        self.router = router
        self.interactor = interactor
        self.fetchPokemon()
    }
}

//MARK: - HomeDetailPresenterProtocol

extension HomeDetailPresenter: HomeDetailPresenterProtocol {
    
    func setupDelegate(delegate: HomeDetailDelegate) {
        self.delegateType = delegate
        self.delegateAbility = delegate
    }
    
    func show(in navigationController: UINavigationController) {
        router.show(presenter: self, in: navigationController)
        
    }
    
    func fetchPokemon() {
        interactor.fetchPokemon() { fetched in
            self.dataSourceType.appendPokemones(fetched)
            self.dataSourceAbility.appendPokemones(fetched)
            self.delegateType?.showDetails(pokemon: fetched)
            self.delegateAbility?.showDetails(pokemon: fetched)
            
        }
    }
}
