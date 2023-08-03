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
//                sorry, it does not work as a View
                HStack {
                    IncludeExcludeView(viewModel: viewModel)
                    Picker("Sort news by", selection: $sortMode) {
                        ForEach(sortedOptions, id: \.0) { option in
                            Text(option.1).tag(option.0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 180)
                    .background(Color(hue: 0.598, saturation: 0.076, brightness: 0.969, opacity: 10.0))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .onChange(of: sortMode){newValue in
                        print("value changed \(newValue)")
                        viewModel.fetchNews(query: q, sortBy: newValue)
                    }
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
                .navigationTitle(q)
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
