//
//  ContentView.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 01.08.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ArticleViewModel()
    
    
    var body: some View {
        NavigationStack{
            VStack {
                SearchbarView()
                HStack {
                    IncludeExcludeView()
                    SortingView()
                }
                List(viewModel.articles, id: \.title) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        VStack {
                            Text(item.title ?? "title unavailable")
                                .padding(.horizontal)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                            Text(item.author ?? "author unknown")
                                .lineLimit(1)
                                .padding(.trailing)
                                
                        }
                        
                    }
                }
                .navigationTitle("NEWS")
            }
        }
        .padding(.horizontal)
//       default value
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
