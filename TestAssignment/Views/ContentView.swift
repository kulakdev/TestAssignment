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
                SearchbarView(viewModel: viewModel)
                HStack {
                    IncludeExcludeView(viewModel: viewModel)
                    SortingView(viewModel: viewModel)
                }
                NewsListView(viewModel: viewModel)
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
