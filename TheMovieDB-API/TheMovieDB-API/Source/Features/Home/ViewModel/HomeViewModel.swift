//
//  HomeViewModel.swift
//  TheMovieDB-API
//
//  Created by Kleiton Mendes on 09/01/25.
//
import UIKit

protocol HomeViewModelProtocol {
    func handler(completion: @escaping(Result<Movie, Error>) -> Void)
    var allMovies: Observable<[MovieResult] { get }>
}

final class HomeViewModel {
    private let service: HomeServiceProtocol
    private var movie: [MovieResult] = []
    private var observable: Observable<MovieResult> = Observable([])
    private var loading: Observable<Bool> = Observable(false)
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func handler(completion: @escaping (Result<Movie, any Error>) -> Void) {
        loading.value = true
        service.fetchData { result in
            switch result {
            case .success(let movie):
                self?.loading.value = false
                completion(.success(movie))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    
}
