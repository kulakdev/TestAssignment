//
//  IncludeExcludeView.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 02.08.2023.
//

import SwiftUI

struct IncludeExcludeView: View {
    @State var sheetVisibility = false
    @Binding var q: String
    @Binding var sortMode: String
    @ObservedObject var viewModel: ArticleViewModel
    
    var body: some View{
        Button("Sorting options"){
            sheetVisibility.toggle()
            
        }
        .sheet(isPresented: $sheetVisibility){
            print("Sheet is closed")
//            viewModel.fetchNews(query: q, sortBy: sortMode)
        } content : {
            HStack{
                Spacer()
                Button(){
                    viewModel.fetchNews(query: q, sortBy: sortMode)
                    sheetVisibility.toggle()
                
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 40))
                        .padding(.trailing)
                }
            }
            VStack{
                VStack{
                    Text("Tags to exclude:")
                        .padding(.trailing)
                    TextField("Enter topics to exclude", text: $viewModel.excludedTopics )
                        .border(.red)
                }
                VStack{
                    Text("Tags to include:")
                        .padding(.trailing)
                    TextField("Enter topics to exclude", text: $viewModel.includedTopics )
                        .border(.green)
                }
                DatePicker("Posts released after:", selection: $viewModel.from, displayedComponents: [.date])
                DatePicker("Posts released before:", selection: $viewModel.to, displayedComponents: [.date])
            }
            .padding()
            Spacer()
        }
    }
}
