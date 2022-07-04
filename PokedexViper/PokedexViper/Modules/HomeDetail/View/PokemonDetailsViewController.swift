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
    @IBOutlet weak var colletionTypePokemon: UICollectionView!
    
    @IBOutlet weak var colletionAbilityPokemon: UICollectionView!
    
    
    
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
    
    //MARK: - Cycle life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegateType = self
        presenter.delegateAbility = self
        
        //ColletionType
        let layoutType = UICollectionViewFlowLayout()
        layoutType.minimumInteritemSpacing = 0
        layoutType.scrollDirection = .horizontal
        colletionTypePokemon.collectionViewLayout = layoutType
        colletionTypePokemon.register(.init(nibName: PokemonDetailsCell.identifier, bundle: nil), forCellWithReuseIdentifier: PokemonDetailsCell.identifier)

        colletionTypePokemon.dataSource = presenter.dataSourceType
        colletionTypePokemon.delegate = presenter.dataSourceType
        
        //ColletionAbility
        let layoutAbility = UICollectionViewFlowLayout()
        layoutAbility.minimumInteritemSpacing = 0
        layoutAbility.scrollDirection = .horizontal
        colletionAbilityPokemon.collectionViewLayout = layoutAbility
        colletionAbilityPokemon.register(.init(nibName: PokemonDetailsCell.identifier, bundle: nil), forCellWithReuseIdentifier: PokemonDetailsCell.identifier)

        colletionAbilityPokemon.dataSource = presenter.dataSourceAbility
        colletionAbilityPokemon.delegate = presenter.dataSourceAbility
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
        
        // CollectionView Type
        
        self.colletionTypePokemon.reloadData()
        
        // ScrollView Ability
        
        self.colletionAbilityPokemon.reloadData()
        }
    }
}
