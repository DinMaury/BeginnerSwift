//
//  Pokemon.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import Foundation

struct PokemonType: Decodable {
    
    let type: Pokemon
}

struct PokemonAbility: Decodable {
    
    let ability: Pokemon
}

struct PokemonDetail: Decodable {
    
    let id: Int
    let name: String
    let abilities: [PokemonAbility]
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let species: Pokemon
    let stats: [PokemonStats]
}

struct PokemonStats: Decodable {
    let base_stat: Int
    let stat: Pokemon
}

struct EvolutionChainChain: Decodable {
    
    let url: String
}

struct EvolutionChain: Decodable {
    
    let evolution_chain: EvolutionChainChain
}

struct PokemonEvolutionFetched: Decodable {
    
    let chain: PokemonEvolutionChainFetched
}

struct PokemonEvolutionChainFetched: Decodable {
    let evolution_details: [EvolutionDetails]
    let evolves_to: [PokemonEvolutionChainFetched]
    let species: Pokemon
}

struct EvolutionDetails: Decodable {
    let min_level: Int?
}

struct PokemonDetailFetched {
    
    let id: Int
    let name: String
    let abilities: [String]
    let height: Int
    let weight: Int
    let types: [String]
    let nextEvolution: NextEvolution
    let defense: Int
    let hp: Int
    let baseAttack: Int
    
    init(detail: PokemonDetail, nextEvolution: NextEvolution) {
        
        self.id = detail.id
        self.name = detail.name
        var ability = [String]()
        for i in 0 ..< detail.abilities.count {
            
            ability.append(detail.abilities[i].ability.name)
        }
        self.abilities = ability
        self.height = detail.height
        self.weight = detail.weight
        var type = [String]()
        for i in 0 ..< detail.types.count {
            
            type.append(detail.types[i].type.name)
        }
        self.types = type
        self.nextEvolution = nextEvolution
        self.defense = detail.stats[3].base_stat
        self.hp = detail.stats[1].base_stat
        self.baseAttack = detail.stats[2].base_stat
        
    }
}

struct NextEvolution {
    let numEvolution: Int //1 - 2 - 3
    let minLevel: Int? // Experience for Evolution
    let nextEvolutionId: Int?
    let nextEvolutionId2: Int?
    init(numEvolution: Int, minLevel: Int?, nextEvolutionId: Int?, nextEvolutionId2: Int?) {
        self.numEvolution = numEvolution
        self.minLevel = minLevel
        self.nextEvolutionId = nextEvolutionId
        self.nextEvolutionId2 = nextEvolutionId2
    }
}

