//
//  ContentView.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 01.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State var q = ""
    @StateObject private var viewModel = ArticleViewModel()
    
    var body: some View {
        NavigationStack{
            VStack {
                TextField("Enter search parameter", text: $q)
                Button("Search"){
                    viewModel.fetchNews(query: q)
                }
                List(viewModel.articles, id: \.title) { item in
                    VStack {
                        Text(item.title)
                            .font(.headline)
                        Text(item.author ?? "author unknown")
                    }
                }
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
