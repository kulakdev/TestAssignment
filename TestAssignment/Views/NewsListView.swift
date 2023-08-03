//
//  NewsListView.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 03.08.2023.
//

import SwiftUI


struct NewsListView: View {
    
    @StateObject var viewModel : ArticleViewModel
    
    var body: some View{
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
