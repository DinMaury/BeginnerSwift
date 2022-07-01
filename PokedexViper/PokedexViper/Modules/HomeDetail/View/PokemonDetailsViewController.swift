//
//  PokemonDetailsViewController.swift
//  PokedexViper
//
//  Created by Maury on 26/06/22.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet private weak var bioButton: UIButton!
    @IBOutlet private weak var moviesButton: UIButton!
    @IBOutlet private weak var pokemonImageView: UIImageView!
    @IBOutlet private weak var pokemonDescriptionLabel: UILabel!
    @IBOutlet private weak var heightPokemonLabel: UILabel!
    @IBOutlet private weak var weightPokemonLabel: UILabel!
    @IBOutlet private weak var defensePokemonLabel: UILabel!
    @IBOutlet private weak var hpPokemonLabel: UILabel!
    @IBOutlet private weak var pokedexIDLabel: UILabel!
    @IBOutlet private weak var attackPokemonLabel: UILabel!
    @IBOutlet private weak var pokemonNextEvolutionLvLabel: UILabel!
    @IBOutlet private weak var pokemonNextEvolutionFirstImageView: UIImageView!
    @IBOutlet private weak var pokemonNextEvolutionSecondImageView: UIImageView!
    
    // ScrollView
    @IBOutlet weak var stackTypePokemon: UIStackView!
    @IBOutlet weak var typePokemonLabel: UILabel!
    @IBOutlet weak var stackAbilityPokemon: UIStackView!
    @IBOutlet weak var abilityPokemonLabel: UILabel!
    
    
    @IBOutlet weak var scrollViewTypePokemon: UIScrollView!
    
    
    private var loadingView: LoadingView?
    
    //MARK: - Properties
    private var presenter: HomeDetailPresenterProtocol
    
    //MARK: - Inits
    init(_ presenter: HomeDetailPresenterProtocol) {
        
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setupDelegate(delegate: self)
        presenter.fetchPokemon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

}

private extension PokemonDetailsViewController {
    
    @IBAction func bioButtonTapped() {
    }
    
    @IBAction func moviesButtonTapped() {
    }
    
}

//MARK: - HomeDetailDelegate
extension PokemonDetailsViewController: HomeDetailDelegate {
    
    func showDetails(pokemon: PokemonDetailFetched) {
        DispatchQueue.main.async {
            self.pokemonImageView.image = UIImage(named: "\(pokemon.id)")
            self.heightPokemonLabel.text = "\(pokemon.height)"
            self.weightPokemonLabel.text = "\(pokemon.weight)"
            var minLevelText = ""
            if let firstEvolution = pokemon.nextEvolution.nextEvolutionId {
                self.pokemonNextEvolutionFirstImageView.image = UIImage(named: "\(firstEvolution)")
            } else {
                self.pokemonNextEvolutionFirstImageView.isHidden = true
                minLevelText = "Final Evolution"
            }
            if let minLevel = pokemon.nextEvolution.minLevel {
                
                minLevelText = "Next Evolution: Pokemon LvL: \(minLevel)"
            }
            self.pokemonNextEvolutionLvLabel.text = minLevelText
            if let secondEvolution = pokemon.nextEvolution.nextEvolutionId2 {
                self.pokemonNextEvolutionSecondImageView.image = UIImage(named: "\(secondEvolution)")
            } else {
                self.pokemonNextEvolutionSecondImageView.isHidden = true
            }
            self.defensePokemonLabel.text = "\(pokemon.defense)"
            self.hpPokemonLabel.text = "\(pokemon.hp)"
            self.pokedexIDLabel.text = "\(pokemon.id)"
            self.attackPokemonLabel.text = "\(pokemon.baseAttack)"
            
            // ScrollView Type
            
            self.typePokemonLabel.isHidden = true

            for i in 0 ..< pokemon.types.count {

                let type = UILabel()
                
                type.text = pokemon.types[i].description.capitalized + (i + 1 < pokemon.types.count ? " /": "")
                
                self.stackTypePokemon.addArrangedSubview(type)
            }

            // ScrollView Ability
            
            self.abilityPokemonLabel.isHidden = true
            
            for i in 0 ..< pokemon.abilities.count {

                let ability = UILabel()
                
                ability.text = pokemon.abilities[i].description.capitalized + (i + 1 < pokemon.abilities.count ? " /": "")

                self.stackAbilityPokemon.addArrangedSubview(ability)
            }
        }
    }
}
