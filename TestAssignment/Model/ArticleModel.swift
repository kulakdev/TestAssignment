//
//  ArticleModel.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 01.08.2023.
//

import Foundation

let sortedOptions: [(String, String)] = [
        ("relevancy", "Most Relevant"),
        ("popularity", "Most Popular"),
        ("publishedAt", "Newest")
    ]


struct ArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: URL
    let urlToImage: URL?
    let publishedAt: Date
    let content: String
    
}

struct Source: Codable {
    let id: String?
    let name: String
}
