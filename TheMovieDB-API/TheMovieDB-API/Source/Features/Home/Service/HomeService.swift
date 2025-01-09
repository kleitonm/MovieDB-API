//
//  HomeService.swift
//  TheMovieDB-API
//
//  Created by Kleiton Mendes on 09/01/25.
//

import UIKit

protocol HomeServiceProtocol {
    func fetchData(completion: @escaping(Result<Movie, Error>) -> Void)
}

final class HomeService {
    let baseURL: String = "https://api.themoviedb.org/3/discover/movie"
}

extension HomeService: HomeServiceProtocol {
    func fetchData(completion: @escaping(Result<Movie, Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
             "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YjdmYTIwY2UwMmYzZTI0ZDBmZTEwZDQyMGQ3ODFiYyIsIm5iZiI6MTcyODk0MjQ1NS40MDY0ODIsInN1YiI6IjYyOWQ0MGU4N2FkMDhjNmVlMjUxODUwNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ApegANtRI3R5UrF_RLnR_dhftUipTWIuZoIviHVDBwo"
        ]
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            }
            if let data,
               let response = response as? HTTPURLResponse {
                if (200..<300).contains(response.statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let json = try decoder.decode(Movie.self, from: data)
                        completion(.success(json))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        session.resume()
    }
}
