//
//  MovieModel.swift
//  TheMovie
//
//  Created by Maury on 5/07/22.
//

import Foundation
import UIKit

final class MovieModel {
    
    let id: Int?
    let description: String?
    let popularity: Double?
    let posterPath: String?
    let title: String?
    let posterImage: UIImage?
    
    init(_ movie: Movie) {
        
        self.id = movie.id
        self.description = movie.overview
        self.popularity = movie.popularity
        self.posterPath = movie.poster_path
        self.title = movie.title
        self.posterImage = UIImage(named: "")
    }
}
