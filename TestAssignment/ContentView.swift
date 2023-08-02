//
//  ContentView.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 01.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State var q = "Україна"
    @State var currentMessage = "Enter search parameter"
    @State private var sortMode: String = "publishedAt"
    @StateObject private var viewModel = ArticleViewModel()
    
    
    let sortedOptions: [(String, String)] = [
            ("relevancy", "Most Relevant"),
            ("popularity", "Most Popular"),
            ("publishedAt", "Newest")
        ]
    
    var body: some View {
        NavigationStack{
            VStack {
                SearchbarView(currentMessage: $currentMessage, q: $q, viewModel: viewModel)
                ToolbarView(sortMode: $sortMode, query: $q)
                List(viewModel.articles, id: \.url) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        VStack {
                            Text(item.title)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                            Text(item.author ?? "author unknown")
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                
                        }
                        
                    }
                }
                .navigationTitle($q)
            }
        }
        .padding()
        .task{
            viewModel.fetchNews(query: "Україна")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
