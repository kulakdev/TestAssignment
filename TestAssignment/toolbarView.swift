import SwiftUI
import Foundation

struct ToolbarView: View{
    @ObservedObject var viewModel: ArticleViewModel = ArticleViewModel()
    
    
        
    
    var body: some View {
        Picker("Sort news by", selection: $viewModel.sortMode) {
                ForEach(sortedOptions, id: \.0) { option in
                    Text(option.1).tag(option.0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .cornerRadius(10)
            .foregroundColor(.white)
            .onChange(of: viewModel.sortMode){newValue in
                print("value changed \(newValue)")
                viewModel.fetchNews(query: viewModel.q, sortBy: newValue)
            }
        }
    }
