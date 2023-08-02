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
                SearchbarView(currentMessage: $currentMessage, q: $q, viewModel: viewModel)
                List(viewModel.articles, id: \.title) { item in
                    NavigationLink(destination: DetailView(item: item)) {
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
