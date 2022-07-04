//
//  PokemonManager.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import Foundation

typealias PokemonFetchedCompletion = ([Pokemon]) -> Void
typealias PokemonDetailFetchedCompletion = (PokemonDetailFetched) -> Void

//MARK: - Protocol
protocol PokemonManagerProtocol {
    
    func fetchPokemon(offset: Int?, completion: @escaping PokemonFetchedCompletion)
    func fetchPokemon(pokemonId: String, completion: @escaping PokemonDetailFetchedCompletion)
}

//MARK: - Manager
final class PokemonManager {
    
}

//MARK: - PokemonManagerProtocol
extension PokemonManager: PokemonManagerProtocol {
    
    func fetchPokemon(offset: Int?, completion: @escaping PokemonFetchedCompletion) {
        
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        
        let offsets = offset ?? 0
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=30&offset=\(offsets)") else { return }
        urlSession.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                
                let pokemonFetched = try JSONDecoder().decode(PokemonFetched.self, from: data)
                completion(pokemonFetched.results)
                
            } catch {
                print("Failed to decodable JSON")
            }
        } .resume()
    }
    
    func fetchPokemon(pokemonId: String, completion: @escaping PokemonDetailFetchedCompletion) {
        fetchPokemonDetail(pokemonId: pokemonId) { [weak self] details in
            
            self?.fetchPokemonSpecie(urlString: details.species.url) { chain in
                self?.fetchPokemonChain(urlString: chain.evolution_chain.url) { chains in
                    
                    let nextEvolution = self?.fetchNextEvolution(details: details, chains: chains)
                    
                    let fetched = PokemonDetailFetched(detail: details, nextEvolution: nextEvolution ?? NextEvolution(numEvolution: 0, minLevel: nil, nextEvolutionId: nil, nextEvolutionId2: nil))
                    completion(fetched)
                }
            }
        }
        
    }
}

private extension PokemonManager {
    
    func fetchPokemonDetail(pokemonId: String, completion: @escaping (PokemonDetail) -> Void) {
        
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonId)/") else { return }
        
        urlSession.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                
                let pokemonFetched = try JSONDecoder().decode(PokemonDetail.self, from: data)
                completion(pokemonFetched)
            } catch {
                print("Failed to decodable JSON")
            }
        } .resume()
    }
    
    func fetchPokemonSpecie(urlString: String, completion: @escaping (EvolutionChain) -> Void) {
        // https://pokeapi.co/api/v2/pokemon-species/1/
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        
        guard let url = URL(string: urlString) else { return }
        
        urlSession.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                
                let pokemonFetched = try JSONDecoder().decode(EvolutionChain.self, from: data)
                completion(pokemonFetched)
            } catch {
                print("Failed to decodable JSON")
            }
        } .resume()
    }
    
    func fetchPokemonChain (urlString: String, completion: @escaping (PokemonEvolutionFetched) -> Void) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        
        guard let url = URL(string: urlString) else { return }
        
        urlSession.dataTask(with: url) { data, response, error in 
            
            guard let data = data else { return }
            
            do {
                
                let pokemonFetched = try JSONDecoder().decode(PokemonEvolutionFetched.self, from: data)
                completion(pokemonFetched)
                
            } catch {
                print("Failed to decodable JSON")
            }
        } .resume()
    }
    
    func fetchNextEvolution (details:  PokemonDetail, chains: PokemonEvolutionFetched) -> NextEvolution {
        
        var numEvolution = 0
        var minLevel: Int?
        var nextEvolutionId: Int?
        var nextEvolutionId2: Int?
        var chain = chains.chain
        
        for i in 0...2 {
            
            if chain.species.name == details.name {
                numEvolution = i + 1
                break
            }
            if let nextChain = chain.evolves_to.first {
                chain = nextChain
            }
        }
        switch numEvolution {
            
        case 1:
            
            minLevel = chains.chain.evolves_to.first?.evolution_details.first?.min_level
            
            if let str = chain.evolves_to.first?.species.url { //IdEvolucion
                
                var idNextEvolution = ""
                
                for i in str {
                    
                    if (UInt(String(i)) != nil){
                        idNextEvolution.append(i)
                    }
                }
                
                idNextEvolution.removeFirst(1)
                nextEvolutionId = Int(idNextEvolution)
                
                if let str = chain.evolves_to.first?.evolves_to.first?.species.url { //IdEvolucion2
                    
                    var idNextEvolution2 = ""
                    
                    for i in str {
                        
                        if (UInt(String(i)) != nil){
                            idNextEvolution2.append(i)
                        }
                    }
                    
                    idNextEvolution2.removeFirst(1)
                    nextEvolutionId2 = Int(idNextEvolution2)
                } else {
                    nextEvolutionId2 = nil
                }
            } else {
                nextEvolutionId = nil
                nextEvolutionId2 = nil
            }
        case 2:
            
            minLevel = chains.chain.evolves_to.first?.evolves_to.first?.evolution_details.first?.min_level
            
            nextEvolutionId2 = nil
            if let str = chain.evolves_to.first?.species.url { //IdEvolucion
                
                var idNextEvolution = ""
                
                for i in str {
                    
                    if (UInt(String(i)) != nil){
                        idNextEvolution.append(i)
                    }
                }
                
                idNextEvolution.removeFirst(1)
                nextEvolutionId = Int(idNextEvolution)
            } else {
                nextEvolutionId = nil
            }
        case 3:
            minLevel = nil
            nextEvolutionId = nil
            nextEvolutionId2 = nil
        default:
            print("Nombre no encontrado")
        }
        
        return NextEvolution(numEvolution: numEvolution, minLevel: minLevel, nextEvolutionId: nextEvolutionId, nextEvolutionId2: nextEvolutionId2)
    }
}
