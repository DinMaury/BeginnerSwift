//
//  HomeDataSource.swift
//  TheMovie
//
//  Created by Maury on 5/07/22.
//

import Foundation
import UIKit

final class HomeDataSource: NSObject {
    
//    var pokemonTappedCompletion: ((PokemonModel) -> Void)?
//    var reloadColletionView: ((Int) -> Void)?
//
    private var movies: [MovieModel] = []
//
    func appendMovies(_ newMovies: [MovieModel]) {
        movies.append(contentsOf: newMovies)
    }
//    func reloadPokemones(_ newPokemosnes: [PokemonModel]) {
//        pokemones = newPokemosnes
//    }
}
// MARK: - UICollectionViewDataSource
//extension HomeDataSource: UICollectionViewDataSource {
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        pokemones.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath)
//        let pokemon = pokemones[indexPath.row]
//
//        if let cell = cell as? PokemonCell {
//            cell.configure(pokemon)
//        }
//        return cell
//    }
//}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeDataSource: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        .init(width: collectionView.bounds.width/3, height: collectionView.bounds.width/3)
//    }
//
}
// MARK: - UICollectionViewDelegate
extension HomeDataSource: UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let pokemon = pokemones[indexPath.row]
//        pokemonTappedCompletion?(pokemon)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//        if indexPath.item + 1 == pokemones.count{ // Recargar pokemones nuevos
//            let offset = pokemones.count
//
//            reloadColletionView?(offset)
//        }
//
//        if indexPath.item == 0, pokemones.count > 30 { // Volver a cargar pokemones iniciales
//
//            let offset = 0
//            reloadColletionView?(offset)
//        }
//    }
}
