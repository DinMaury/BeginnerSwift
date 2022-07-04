//
//  PokemonDetailsCell.swift
//  PokedexViper
//
//  Created by Maury on 1/07/22.
//

import UIKit

class PokemonDetailsCell: UICollectionViewCell {

    @IBOutlet weak var detailsPokemonLabel: UILabel!
    
    func configure(_ details: String) {
        
        self.detailsPokemonLabel.text = details
    }

}
