//
//  Movie.swift
//  Netflix Clone
//
//  Created by Haytham on 30/08/2023.
//

import Foundation

struct ShowResponse: Codable {
    let results: [Show]
}

struct Show: Codable {
    let id: Int
    let media_type: String?
    let original_title: String?
    let original_name: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

