//
//  ContentView.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 01.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State var q: String = "Україна"
    @State var currentMessage: String = "Enter search parameter"
    @State var sortMode: String = "publishedAt"
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
                    
//                sorry, it does not work as a View
                HStack {
                    IncludeExcludeView(q: $q, sortMode: $sortMode, viewModel: viewModel)
                    ToolbarView(sortMode: $sortMode, query: $q, viewModel: viewModel)
                }
                List(viewModel.articles, id: \.title) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        VStack {
                            Text(item.title ?? "title unavailable")
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                            Text(item.author ?? "author unknown")
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                
                        }
                        
                    }
                }
                .navigationTitle("NEWS")
            }
        }
        .padding(.horizontal)
//        default value so that it's not as boring
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
