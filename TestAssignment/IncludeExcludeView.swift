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
        .padding()
        .sheet(isPresented: $sheetVisibility){
            print("Sheet is closed")
        } content : {
            HStack{
                Spacer()
                Button(){
                    viewModel.fetchNews(query: q, sortBy: sortMode)
                    sheetVisibility.toggle()
                
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 30))
                        .frame(width: 30, height: 60)
                        .padding(.trailing, 20)
                }
            }
            VStack{
                VStack{
                    Text("Tags to exclude:")
                        .padding(.trailing)
                        .font(.title3)
                        .fontWeight(.medium)
                    TextField("Enter topics to exclude", text: $viewModel.excludedTopics )
                        .padding()
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
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.green, lineWidth: 1)
                        )
                }
                .padding()
                VStack{
                    Text("Posts are limited to one month old")
                        .font(.callout)
                        .foregroundColor(.gray)
                    DatePicker("Posts released after:",selection: $viewModel.from, in: viewModel.bottomRange...viewModel.upperRange, displayedComponents: [.date])
                        .padding(.horizontal)
                    
                    DatePicker("Posts released before:", selection: $viewModel.to, in: viewModel.bottomRange...viewModel.upperRange, displayedComponents: [.date])
                        .padding(.horizontal)
                }
            }
            .padding()
            .presentationDragIndicator(.visible)
            Spacer()
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        
    }
}


struct IncludeExcludeView_Preview: PreviewProvider {
    static var previews: some View {
        let viewModel = ArticleViewModel()
        return IncludeExcludeView(q: .constant("Bazinga"), sortMode: .constant("publishedAt"), viewModel: viewModel)
            .padding()
    }
}
