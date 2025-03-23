//
//  DTO.swift
//  TheMovieDB-API
//
//  Created by Kleiton Mendes on 09/01/25.
//

import Foundation

struct Movie: Codable, Equatable {
    let page: Int
    let results: [MovieResult]
    let totalPages: Int?
    let totalResults: Int?
}

struct MovieResult: Codable, Equatable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int
    let originalLanguage: String?
    let originalTitle: String
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let voteAverage: Double?
    let voteCount: Int?
}
