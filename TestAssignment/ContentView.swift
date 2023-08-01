//
//  ContentView.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 01.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State var q = ""
    @State var currentMessage = "Enter search parameter"
    @StateObject private var viewModel = ArticleViewModel()
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    TextField(currentMessage, text: $q)
                    Button("Search"){
                        if !q.isEmpty {
                            viewModel.fetchNews(query: q)
                        } else {
                            currentMessage = "ENTER THE SEARCH PARAMETER"
                        }
                    }
                    .padding()
                    .clipShape(Capsule())
                    .background(.blue)
                    .foregroundColor(.white)
                }
                .accessibilityLabel("Search for news")
                List(viewModel.articles, id: \.title) { item in
                    NavigationLink(destination: Text(item.title)) {
                        VStack {
                            Text(item.title)
                                .font(.headline)
                            Text(item.author ?? "author unknown")
                        }
                    }
                }
                .navigationTitle("NEWS")
            }
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
