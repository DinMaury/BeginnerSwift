//
//  PokeCell.swift
//  pokedex
//
//  Created by Maury on 14/05/22.
//

import UIKit

class PokeCell1: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon?
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLabel.text = pokemon.name?.capitalized
        thumbImg.image = UIImage(named: "\(pokemon.pokedexId ?? 1)")
    }
    
}
