//
//  IncludeExcludeView.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 02.08.2023.
//

import SwiftUI

struct IncludeExcludeView: View {
    @State var sheetVisibility = true
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
                        .font(.system(size: 30))
                        .padding(.trailing)
                }
            }
            VStack{
                VStack{
                    Text("Tags to exclude:")
                        .padding(.trailing)
                        .font(.title3)
                        .fontWeight(.medium)
                    TextField("Enter topics to exclude", text: $viewModel.excludedTopics )
                        .padding(.horizontal)
                        .frame(width: 400, height: 30).cornerRadius(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.red, lineWidth: 1)
                        )
                }
                .padding()
                VStack{
                    Text("Tags to include:")
                        .padding(.trailing)
                        .font(.title3)
                        .fontWeight(.medium)
                    TextField("Enter topics to exclude", text: $viewModel.includedTopics )
                        .padding(.horizontal)
                        .frame(width: 400, height: 30).cornerRadius(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.green, lineWidth: 1)
                        )
                }
                .padding()
                DatePicker("Posts released after:", selection: $viewModel.from, displayedComponents: [.date])
                    .padding()
                Text("Posts are limited to one month old")
                    .font(.caption2)
                    .foregroundColor(Color(red: 00, green: 00, blue: 00, opacity: 60))
                DatePicker("Posts released before:", selection: $viewModel.to, displayedComponents: [.date])
                    .padding()
            }
            .padding()
            Spacer()
        }
    }
}


struct IncludeExcludeView_Preview: PreviewProvider {
    static var previews: some View {
        let viewModel = ArticleViewModel() // Create an instance of your ArticleViewModel
        return IncludeExcludeView(q: .constant("Bazinga"), sortMode: .constant("publishedAt"), viewModel: viewModel)
            .padding()
    }
}
