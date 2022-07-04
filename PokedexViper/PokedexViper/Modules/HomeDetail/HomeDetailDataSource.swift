//
//  HomeDetailDataSource.swift
//  PokedexViper
//
//  Created by Maury on 1/07/22.
//

import Foundation
import UIKit

//MARK: - Class Type

final class HomeDetailDataSourceType: NSObject {
    
    var reloadColletionView: ((Int) -> Void)?
    
    private var types: [String] = []
    
    func appendPokemones(_ newDetails: PokemonDetailFetched) {
        var types: [String] = []
        for i in 0 ..< newDetails.types.count {
            
            types.append(newDetails.types[i].description.capitalized)
        }
        self.types = types
    }
}
// MARK: - UICollectionViewDataSource
extension HomeDetailDataSourceType: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonDetailsCell.identifier, for: indexPath)
        let detail = types[indexPath.row]
        
        if let cell = cell as? PokemonDetailsCell {
            cell.configure(detail)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeDetailDataSourceType: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width*1.2, height: collectionView.bounds.width)
    }
}

extension HomeDetailDataSourceType: UICollectionViewDelegate {
    
}

//MARK: - Class Ability
final class HomeDetailDataSourceAbility: NSObject {
    
    var reloadColletionView: ((Int) -> Void)?
    
    private var abilities: [String] = []
    
    func appendPokemones(_ newDetails: PokemonDetailFetched) {
    
        var abilities: [String] = []
        
        for i in 0 ..< newDetails.abilities.count {
            
            abilities.append(newDetails.abilities[i].description.capitalized)
        }
        self.abilities = abilities
    }
}
// MARK: - UICollectionViewDataSource
extension HomeDetailDataSourceAbility: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        abilities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonDetailsCell.identifier, for: indexPath)
        let detail = abilities[indexPath.row]
        
        if let cell = cell as? PokemonDetailsCell {
            cell.configure(detail)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeDetailDataSourceAbility: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width*1.2, height: collectionView.bounds.width)
    }
}

extension HomeDetailDataSourceAbility: UICollectionViewDelegate {
    
}

