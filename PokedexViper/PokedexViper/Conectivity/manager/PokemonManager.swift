//
//  PokemonManager.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import Foundation

typealias PokemonFetchedCompletion = ([Pokemon]) -> Void

//MARK: - Protocol
protocol PokemonManagerProtocol {
    
    func fetchPokemon(completion: @escaping PokemonFetchedCompletion)
}

//MARK: - Manager
final class PokemonManager {
    
}

//MARK: - PokemonManagerProtocol
extension PokemonManager: PokemonManagerProtocol {
    
    func fetchPokemon(completion: @escaping PokemonFetchedCompletion) {
        
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return }
        
        urlSession.dataTask(with: url) { data, respomnse, error in
            
            guard let data = data else { return }
            
            do {
                
                let pokemonFetched = try JSONDecoder().decode(PokemonFetched.self, from: data)
                completion(pokemonFetched.results)
                
            } catch {
                print("Failed to decodable JSON")
            }
        } .resume()
    }
}
