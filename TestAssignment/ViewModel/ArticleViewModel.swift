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
    @Published var lastFetchedName: String = "NEWS"
    @Published var q = "Україна"
    
    @Published var excludedTopics: String = ""
    @Published var includedTopics: String = ""
    
    @Published var to: Date = Date()
    @Published var from: Date = {
        let calendar = Calendar.current
        guard let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: Date()) else {
            return Date()
        }
        let components = calendar.dateComponents([.year, .month, .day], from: oneMonthAgo)
        return calendar.date(from: components) ?? Date()
    }()
    
    func fetchNews(query: String, sortBy: String = "publishedAt"){
        let dateFormatter = ISO8601DateFormatter()

            let formattedTo = dateFormatter.string(from: to)
            let formattedFrom = dateFormatter.string(from: from)
            
        
        var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "newsapi.org"
            urlComponents.path = "/v2/everything"
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: query + convertInclude(includes: includedTopics) + convertExclude(excludes: excludedTopics)),
                URLQueryItem(name: "apiKey", value: "29150e61228f48e290e7dbadabc051f7"),
                URLQueryItem(name: "sortBy", value: "\(sortBy)"),
                URLQueryItem(name: "to", value: "\(formattedTo)"),
                URLQueryItem(name: "from", value: "\(formattedFrom)")
            ]
        
        guard let url = urlComponents.url else {
            print("invalid url")
            return
        }
        
        
        
        var request = URLRequest(url: url)
        print(request)
        request.addValue("f1ec47c0a4a84ebe99aaf50d447f5c64", forHTTPHeaderField: "X-Auth-Token")
        request.httpMethod = "GET"
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { [self] (data: Data?, response: URLResponse?, error: Error?) in
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
//                                decoder.keyDecodingStrategy =
                                
                                
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
