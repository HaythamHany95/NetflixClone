//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Haytham on 29/08/2023.
//

import Foundation

struct constants {
    static let API_Key = "f2618aee9ee07aee7c40a1c66a5cfc04"
    static let baseURL = "https://api.themoviedb.org"
    static let YouTube_APIKey = "AIzaSyA1uvbMemDURIifbKF9fIR86T94huX0szQ"
    static let YouTubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIErrors: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    //Section-GetTrendingMovies
    func getTrendingMovies(completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let url = URL(string: "\(constants.baseURL)/3/trending/movie/day?api_key=\(constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            do {
                let results = try JSONDecoder().decode(ShowResponse.self, from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIErrors.failedToGetData))
                
            }
        }
        task.resume()
    }
    
    
    //Section-GetTrendingTvs
    func getTrendingTvs(completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let url = URL(string: "\(constants.baseURL)/3/trending/tv/day?api_key=\(constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            do {
                let results = try JSONDecoder().decode(ShowResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIErrors.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    //Section-GetPopular
    func getPopular(completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let url = URL(string: "\(constants.baseURL)/3/movie/popular?api_key=\(constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            do{
                let results = try JSONDecoder().decode(ShowResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIErrors.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    
    //Section-GetUpComingMovies
    func getUpComingMovies(completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let url = URL(string: "\(constants.baseURL)/3/movie/upcoming?api_key=\(constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            do{
                let results = try JSONDecoder().decode(ShowResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIErrors.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    
    //Section-GetTopRatedMovies
    func getTopRatedMovies(completion: @escaping (Result<[Show], Error>) -> Void ) {
        guard let url = URL(string: "\(constants.baseURL)/3/movie/top_rated?api_key=\(constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            do {
                let results = try JSONDecoder().decode(ShowResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIErrors.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    //TopSearchingVC-GetDiscoverMovies
    func getDiscoverMovies(completion: @escaping (Result<[Show], Error>) -> Void ) {
        guard let url = URL(string: "\(constants.baseURL)/3/discover/movie?api_key=\(constants.API_Key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            do {
                let results = try JSONDecoder().decode(ShowResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIErrors.failedToGetData))
            }
        }
        task.resume()
    }
    
    //TopSearchingVC-SearchingResultsVC
    func search(with query: String, completion: @escaping (Result<[Show], Error>) -> Void ) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(constants.baseURL)/3/search/movie?api_key=\(constants.API_Key)&query=\(query)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            do {
                let results = try JSONDecoder().decode(ShowResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIErrors.failedToGetData))
            }
        }
        task.resume()
    }
    
    //TopSearchingVC-SearchingResultsVC-YouTubeMoviesTrailers
    func getMovies(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void ) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(constants.YouTubeBaseURL)q=\(query)&key=\(constants.YouTube_APIKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
                print(results)
            }catch{
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
}
