//
//  ArticleViewModel.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 01.08.2023.
//

import Foundation

class ArticleViewModel: ObservableObject {
    @Published private(set) var articles = [Article]()
    @Published var sortMode: String = "publishedAt"
    
    func fetchNews(query: String, sortBy: String = "publishedAt"){
        var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "newsapi.org"
            urlComponents.path = "/v2/everything"
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "apiKey", value: "f1ec47c0a4a84ebe99aaf50d447f5c64"),
                URLQueryItem(name: "sortBy", value: "\(sortBy)")
            ]
//        это просто проверки, очень много проверок
        guard let url = urlComponents.url else {
            print("invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        print(request)
        request.addValue("f1ec47c0a4a84ebe99aaf50d447f5c64", forHTTPHeaderField: "X-Auth-Token")
        request.httpMethod = "GET"
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                // handle error
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // check if status code == 200?
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        if let data = data {
                            do {
                                let decoder = JSONDecoder()
                                decoder.dateDecodingStrategy = .iso8601
                                
                                let articleResponse = try decoder.decode(ArticleResponse.self, from: data)
                                
                                let articles = articleResponse.articles
                                
                                print("Articles count: \(articles.count)")
                                DispatchQueue.main.async {
                                    self.articles = articleResponse.articles
                                }
                            } catch {
                                print("Error decoding JSON: \(error)")
                            }
                        }
                    } else {
                        // status not 200
                        print("HTTP status code: \(httpResponse.statusCode)")
                    }
                }
            }
        dataTask.resume()
        
    }
}
