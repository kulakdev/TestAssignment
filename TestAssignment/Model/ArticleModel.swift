//
//  ArticleModel.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 01.08.2023.
//

import Foundation

@propertyWrapper
struct FailableURL: Codable {
    private let url: URL?
    
    var wrappedValue: URL? {
        return url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let urlString = try? container.decode(String.self), let validURL = URL(string: urlString) {
            self.url = validURL
        } else {
            self.url = nil
        }
    }
}

@propertyWrapper
struct NonExistantString: Codable {
    var wrappedValue: String?
    
    
    init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let title = try? container.decode(String.self) {
                self.wrappedValue = title
            } else {
                self.wrappedValue = nil
            }
        }
}

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
    
    @NonExistantString
    var title: String?
    
    let description: String?
    
    @FailableURL
    var urlToImage: URL?
    
    let publishedAt: Date
    let content: String
    
}

struct Source: Codable {
    let id: String?
    let name: String
}
