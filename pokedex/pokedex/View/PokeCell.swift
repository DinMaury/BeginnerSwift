//
//  PokeCell.swift
//  pokedex
//
//  Created by Maury on 14/05/22.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier = "PokeCell"
    var pokemon: Pokemon?
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLabel.text = pokemon.name?.capitalized
        thumbImg.image = UIImage(named: "\(pokemon.pokedexId ?? 1)")
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PokeCell", bundle: nil)
    }
    
    // Redondear las esquinas
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        
        layer.cornerRadius = 10.0
    }
    
}

