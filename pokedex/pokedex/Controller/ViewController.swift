//
//  ViewController.swift
//  pokedex
//
//  Created by Maury on 13/05/22.
//

import UIKit
import AVFoundation

class BaseViewController: UIViewController {
    
    static var musicPlayer: AVAudioPlayer?
    @objc var musicPlayer: AVAudioPlayer? {
        BaseViewController.musicPlayer
    }
    
    func addMusicButton() {
        //let musicButton = UIButton(type: .system)
        //musicButton.frame = .init(x: 0, y: 0, width: 15, height: 15)
        //musicButton.setImage(.init(named: "music"), for: .normal)
        //musicButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: -5, right: -5)
        //musicButton.addTarget(self, action: #selector(musicPlay), for: .touchUpInside)
        let musicButton = UIBarButtonItem(image: UIImage(named: "music"),
                                          style: .done,
                                          target: self,
                                          action: #selector(musicPlay))
        navigationItem.rightBarButtonItem = musicButton
    }
    
    func initAudio() {
        
        do {
            guard let path = Bundle.main.path(forResource: "music", ofType: "mp3"),
                  let url = URL(string: path) else { return }
            let musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            BaseViewController.musicPlayer = musicPlayer
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @objc func musicPlay() {
        if musicPlayer?.isPlaying ?? true {
            
            musicPlayer?.pause()
            
        } else {
            musicPlayer?.play()
            
        }
        
    }
    
    override func viewDidLoad() {
        addMusicButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //initAudio()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //musicPlayer?.pause()
    }
    
}

class ViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    //var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAudio()
        
        // Collection Config
        let layout = UICollectionViewFlowLayout()
        collection.collectionViewLayout = layout
        collection.register(PokeCell.nib(), forCellWithReuseIdentifier: PokeCell.identifier)
        navigationController?.navigationBar.backgroundColor = .red
        navigationController?.navigationBar.tintColor = .white
        
        // Delegades
        collection.dataSource = self
        collection.delegate = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        // Informacion de pokemons
        parsePokemonCSV()
        //Navegation bar
        configureBar()
        }
    
    // MARK: - CollectionView Config
    // Count to CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCell.identifier, for: indexPath) as? PokeCell {
            
            let pokemon = filteredPokemon[indexPath.row]
            cell.configureCell(pokemon: pokemon)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    // Go detail when clic to cell Pokemon
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            
            poke = pokemons[indexPath.row]
        }
        let pokemonDetailVC = PokemonDetailVC()
        pokemonDetailVC.pokemon = poke
        pokemonDetailVC.title = poke.name
        
        // Pokemon Detail
        navigationController?.pushViewController(pokemonDetailVC, animated: true)
        
        // without navigation Controller
//        pokemonDetailVC.modalTransitionStyle = .flipHorizontal
//        pokemonDetailVC.modalPresentationStyle = .fullScreen
//        self.present(pokemonDetailVC, animated: true) // Prensentar el XIB
    }
    // Size to cell in colletionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    // MARK: --------
    
    //Function read CSV
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!) ?? 0
                let name = row["identifier"] ?? ""
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemons.append(poke)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        filteredPokemon = pokemons
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            filteredPokemon = pokemons
            collection.reloadData()
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemons.filter({$0.name!.range(of: lower) != nil })
            collection.reloadData()
        }
    }
    //Function Vavigation Bar
    private func configureBar() {
        
        let titleLabel = UILabel()
        titleLabel.text = "Pokedex"
        titleLabel.font = UIFont(name: "Pokemon Solid", size: 35)
        titleLabel.textColor = .white
        navigationItem.titleView = titleLabel
        
    }
    
}
