//
//  Pokemon.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import Foundation

struct PokemonDetail: Encodable {
    
    let name: String
    let pokedexId: Int
    let description: String
    let type: String
    let defense: String
    let height: String
    let weight: String
    let attack: String
    let hp: String
    let ability: String
    let nextEvolution: String
    let pokemonURL: String
    let URLDescription: String
    
}
