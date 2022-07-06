//
//  MovieManager.swift
//  TheMovie
//
//  Created by Maury on 5/07/22.
//

import Foundation
import Alamofire

typealias MoviesFetchedCompletion = ([Movie]) -> Void

//MARK: - Protocol
protocol MovieManagerProtocol {
    
    func fetchMovies(completion: @escaping MoviesFetchedCompletion)
//    func fetchMovie(movieId: String, completion: @escaping MovieDetailFetchedCompletion)
}

//MARK: - Manager
final class MovieManager {
    
    private var page: Int = 1
    private var key: String {
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYmViZWQzYzEwYTRiMWZmZmNkYzc0MGY0MmUwNTkyZSIsInN1YiI6IjYyYzQ0NWMzYmE0ODAyMDA3Y2E5NGE3ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NrI3KKU3yBpFrpjlHwr37zvNyuWTFdOEBtVYTSdhL8A"
    }
}

//MARK: - PokemonManagerProtocol
extension MovieManager: MovieManagerProtocol {
    
    func fetchMovies(completion: @escaping MoviesFetchedCompletion) {
        
        var movieUrl: String {
            
            "https://api.themoviedb.org/3/movie/popular?page=\(page)"
        }
        
        let token = HTTPHeaders(["Authorization":key])
        
        AF.request(movieUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token).responseJSON { response in
            
            guard let data = response.data else { return }
            
            do {
                
                let moviesFetched = try JSONDecoder().decode(MoviesFetched.self, from: data)
                completion(moviesFetched.results)
                
            } catch {
                print("Failed to decodable JSON")
            }
            
            print("")
        }
        
        
//        let movieUrl = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=0bebed3c10a4b1fffcdc740f42e0592e"
////        let urlSessionConfiguration = AF.sessionConfiguration
////        let urlSession = URLSession(configuration: urlSessionConfiguration)
//        AF.request(movieUrl).responseData { response in
//
//            guard let data = response.data else { return }
//
//            do {
//
//                let movieFetched = try JSONDecoder().decode(Movie.self, from: data)
//                completion(movieFetched)
//
//            } catch {
//                print("Failed to decodable JSON")
//            }
//        }
//        AF.request(movieUrl).responseJSON { response in
//
//            if let dict = response.value as? Dictionary<String, AnyObject> {
//
//                if let id = dict["id"] as? Int,
//                    let description = dict["overview"] as? String,
//                    let popularity = dict["popularity"] as? Double,
//                    let posterPath = dict["poster_path"] as? String,
//                    let title = dict["title"] as? String {
//
//                    let fetched = Movie(id: id, description: description, popularity: popularity, posterPath: posterPath, title: title)
//                    completion(fetched)
//                }
//            }
//        } .resume()
        
    }
//    func fetchMovie(completion: @escaping MovieFetchedCompletion) {
//
//        let urlSessionConfiguration = URLSessionConfiguration.default
//        let urlSession = URLSession(configuration: urlSessionConfiguration)
//
//        guard let url = URL(string: "https://") else { return }
//        urlSession.dataTask(with: url) { data, response, error in
//
//            guard let data = data else { return }
//
//            do {
//
//                let MovieFetched = try JSONDecoder().decode(MovieFetched.self, from: data)
//                completion(MovieFetched.results)
//
//            } catch {
//                print("Failed to decodable JSON")
//            }
//        } .resume()
//    }
    
//    func fetchMovie(movieId: String, completion: @escaping MovieDetailFetchedCompletion) {
//        fetchMovieDetail(movieId: movieId) { [weak self] details in
//
//        }
//
//    }
}

private extension MovieManager {
    
//    func fetchMovieDetail(movieId: String, completion: @escaping (MovieDetail) -> Void) {
//
//        let urlSessionConfiguration = URLSessionConfiguration.default
//        let urlSession = URLSession(configuration: urlSessionConfiguration)
//
//        guard let url = URL(string: "https://") else { return }
//
//        urlSession.dataTask(with: url) { data, response, error in
//
//            guard let data = data else { return }
//
//            do {
//
//                let movieFetched = try JSONDecoder().decode(MovieDetail.self, from: data)
//                completion(movieFetched)
//            } catch {
//                print("Failed to decodable JSON")
//            }
//        } .resume()
//    }
}
