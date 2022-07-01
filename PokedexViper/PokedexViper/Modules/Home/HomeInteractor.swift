//
//  HomeInteractor.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import Foundation

protocol HomeInteractorProtocol {
    
    func fetchPokemon(offset: Int?,completion: @escaping PokemonFetchedCompletion)
}


final class HomeInteractor {
    
    private let pokemonManager: PokemonManagerProtocol
    
    init() {
        pokemonManager = PokemonManager()
    }
}

// MARK: - HomeInteractorProtocol
extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchPokemon(offset: Int?, completion: @escaping PokemonFetchedCompletion) {
        
        pokemonManager.fetchPokemon(offset: offset, completion: completion)
    }
}
