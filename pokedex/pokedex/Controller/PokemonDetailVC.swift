//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Maury on 16/05/22.
//

import UIKit

class PokemonDetailVC: BaseViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var pokemonImg: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var defenseLabel: UILabel!
    
    @IBOutlet weak var abilityLabel: UILabel!
    
    @IBOutlet weak var hpLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var pokedexIdLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var attackLabel: UILabel!
    
    @IBOutlet weak var currentEvolutionImg: UIImageView!
    
    @IBOutlet weak var nextEvolutionImg: UIImageView!
    
    @IBOutlet weak var evolutionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBar()
        pokemonImg.image = UIImage(named: "\(pokemon.pokedexId ?? 1)")
        currentEvolutionImg.image = UIImage(named: "\(pokemon.pokedexId ?? 1)")
        pokemon.downloadPokmeonDetail {
            // after complete
            self.updateUI()
        }
    }
    
    private func configureBar() {
        
        let titleLabel = UILabel()
        titleLabel.text = pokemon.name?.capitalized
        titleLabel.font = UIFont(name: "Pokemon Solid", size: 25)
        titleLabel.textColor = .white
        navigationItem.titleView = titleLabel
        
        let backButton = UIBarButtonItem()
        navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
    }
    
    func updateUI() {
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        abilityLabel.text = pokemon.ability
        hpLabel.text = pokemon.hp
        typeLabel.text = pokemon.type
        pokedexIdLabel.text = "\(pokemon.pokedexId!)"
        
    }
}
