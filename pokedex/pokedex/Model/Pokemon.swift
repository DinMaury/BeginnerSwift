//
//  Pokemon.swift
//  pokedex
//
//  Created by Maury on 14/05/22.
//

import Foundation
import Alamofire

class Pokemon {
    
    private(set) var name: String?
    private(set) var pokedexId: Int?
    private(set) var description: String?
    private(set) var type: String?
    private(set) var defense: String?
    private(set) var height: String?
    private(set) var weight: String?
    private(set) var attack: String?
    private(set) var hp: String?
    private(set) var ability: String?
    private(set) var nextEvolution: String?
    private(set) var pokemonURL: String?
    private(set) var URLDescription: String?
    
    init(name: String, pokedexId: Int) {
        
        self.name = name
        self.pokedexId = pokedexId
        self.pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(pokedexId)"
        self.URLDescription = "\(URL_BASE)\(URL_Description)\(pokedexId)"
    }
    
    func downloadPokmeonDetail(complete: @escaping DownloadComplete) {
        guard let pokemonURL = self.pokemonURL else {
            return
        }

        AF.request(pokemonURL).responseJSON { response in
            if let dict = response.value as? Dictionary<String, AnyObject> {
                if let height = dict["height"] as? Int {
                    self.height = "\(height)"
                }
                if let weight = dict["weight"] as? Int {
                    self.weight = "\(weight)"
                }
                if let types = dict["types"] as? [Dictionary<String, AnyObject>] {
                    self.type = ""
                    for n in 0 ..< types.count {
                        if let type = types[n]["type"] as? Dictionary<String, AnyObject> {
                            if let name = type["name"] as? String {
                                self.type = self.type! + name.capitalized
                            }
                            if n + 1 < types.count {
                                self.type = self.type! + "/"
                            }
                        }
                    }
                }
                if let abilities = dict["abilities"] as? [Dictionary<String, AnyObject>] {
                    if let ability = abilities[0]["ability"] as? Dictionary<String, AnyObject> {
                        if let name = ability["name"] as? String {
                            self.ability = name.capitalized
                        }
                    }
                }
                if let stats = dict["stats"] as? [Dictionary<String, AnyObject>] {
                    if let hp = stats[0]["base_stat"] as? Int {
                        self.hp = "\(hp)"
                    }
                    if let attack = stats[1]["base_stat"] as? Int {
                        self.attack = "\(attack)"
                    }
                    if let defense = stats[2]["base_stat"] as? Int {
                        self.defense = "\(defense)"
                    }
                }
                complete()
            }
        }
        guard let pokemonURLDescription = self.URLDescription else {
            return
        }
        AF.request(pokemonURLDescription).responseJSON { response in
            
        }
    }
}
