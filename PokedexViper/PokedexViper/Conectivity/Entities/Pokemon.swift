//
//  Pokemon.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import Foundation

struct PokemonFetched: Decodable {
    
    let count: Int
    let next: String
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}
