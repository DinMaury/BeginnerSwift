//
//  HomeInteractor.swift
//  TheMovie
//
//  Created by Maury on 5/07/22.
//

import Foundation

protocol HomeInteractorProtocol {
    
    func fetchMovies(completion: @escaping MoviesFetchedCompletion)
}


final class HomeInteractor {
    
    private let movieManager: MovieManagerProtocol
    
    init() {
        movieManager = MovieManager()
    }
}

// MARK: - HomeInteractorProtocol
extension HomeInteractor: HomeInteractorProtocol {
    func fetchMovies(completion: @escaping MoviesFetchedCompletion) {
        
        movieManager.fetchMovies(completion: completion)
    }
    
}
