//
//  HomePresenter.swift
//  TheMovie
//
//  Created by Maury on 5/07/22.
//

import Foundation

//MARK: - protocol
protocol HomePresenterProtocol {
    
    var dataSource: HomeDataSource { get }
    var delegate: HomePresenterDelegate? { get set }
    
    func show() -> HomeViewController
    func fetchMovies()
}

//MARK: - Delegate
protocol HomePresenterDelegate: AnyObject {
    
    func showLoading()
    func hideLoading()
    func reloadData()
    func reloadDataColletionView(indexPath: IndexPath)
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
        
        setupDataSource()
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    
    func show() -> HomeViewController {
        
        router.show(presenter: self)
    }
    
    func fetchMovies() {
        
        //delegate?.showLoading()
        
//        if offset == 0 {
//
//
//
        interactor.fetchMovies { [weak self] movies in
            
            let moviesModel = movies.map({ MovieModel($0)})
            self?.dataSource.appendMovies(moviesModel)
            print("")
        }
//
//                self?.delegate?.hideLoading()
//                let pokemonesModel = pokemones.map({ PokemonModel($0)})
//                self?.dataSource.reloadPokemones(pokemonesModel)
//                self?.delegate?.reloadData()
        
    }
//        } else {
//
//            interactor.fetchPokemon(offset: offset) { [weak self] pokemones in
//                self?.delegate?.hideLoading()
//                let pokemonesModel = pokemones.map({ PokemonModel($0)})
//                self?.dataSource.appendPokemones(pokemonesModel)
//                self?.delegate?.reloadData()
//            }
//        }
}

//MARK: - Private
private extension HomePresenter {
    
    func setupDataSource() {
        
//        dataSource.pokemonTappedCompletion = { [unowned self] pokemon in
//            
//            self.router.showDetails(pokemonId: pokemon.id)
//       }
//        
//        dataSource.reloadColletionView = { [unowned self] offset in
//            
//            self.fetchPokemon(offset: offset)
//        }
            
    }
}
