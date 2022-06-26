//
//  HomePresenter.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import Foundation
//MARK: - protocol

protocol HomePresenterProtocol {
    
    var dataSource: HomeDataSource { get }
    var delegate: HomePresenterDelegate? { get set }
    
    func show() -> HomeViewController
    func fetchPokemon()
    
}

//MARK: - Delegate
protocol HomePresenterDelegate: AnyObject {
    
    func showLoading()
    func hideLoading()
    func reloadData()
    func showError(title: String, message: String)
}

//MARK: Presenter
final class HomePresenter {
    
    //MARK: - Properties
    private let router: HomeRouterProtocol
    private let interactor: HomeInteractorProtocol
    
    var dataSource = HomeDataSource()
    
    weak var delegate: HomePresenterDelegate?
    
    //MARK: - Inits
    init(router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    
    func show() -> HomeViewController {
        
        router.show(presenter: self)
    }
    
    func setupDataSource() -> HomeDataSource {
        
        let dataSource = HomeDataSource()
        
        return dataSource
    }
    
    func fetchPokemon() {
        
        delegate?.showLoading()
        interactor.fetchPokemon { [weak self] pokemones in
            self?.delegate?.hideLoading()
            let pokemonesModel = pokemones.map({ PokemonModel($0)})
            self?.dataSource.appendPOkemones(pokemonesModel)
            self?.delegate?.reloadData()
        }
    }
}

//MARK: - Private
private extension HomePresenter {
    
}
