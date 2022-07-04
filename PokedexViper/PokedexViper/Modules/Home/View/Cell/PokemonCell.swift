//
//  PokemonCell.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import UIKit

class PokemonCell: UICollectionViewCell {

    @IBOutlet private weak var pokemonImageView: UIImageView!
    @IBOutlet private weak var pokemonNameLabel: UILabel!
    
    func configure(_ pokemon: PokemonModel) {
        
        pokemonNameLabel.text = pokemon.name
        pokemonImageView.image = UIImage(named: pokemon.id)
    }

}
