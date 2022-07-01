//
//  HomeDetailInteractor.swift
//  PokedexViper
//
//  Created by Maury on 27/06/22.
//

import Foundation

protocol HomeDetailInteractorProtocol {
    
    func fetchPokemon(completion: @escaping PokemonDetailFetchedCompletion)
}


final class HomeDetailInteractor {
    
    private let pokemonId: String
    private let pokemonManager: PokemonManagerProtocol
    
    init(pokemonId: String,pokemonManager: PokemonManagerProtocol = PokemonManager()) {
        
        self.pokemonId = pokemonId
        self.pokemonManager = pokemonManager
    }
}

// MARK: - HomeDetailInteractorProtocol
extension HomeDetailInteractor: HomeDetailInteractorProtocol {
    
    func fetchPokemon(completion: @escaping PokemonDetailFetchedCompletion){
        pokemonManager.fetchPokemon(pokemonId: pokemonId, completion: completion)
    }
}
