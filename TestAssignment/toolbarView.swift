import SwiftUI
import Foundation

struct ToolbarView: View{
    @Binding var sortMode : String
    @Binding var query: String
    @ObservedObject var viewModel: ArticleViewModel
    
    
        
    
    var body: some View {
            Picker("Sort news by", selection: $sortMode) {
                ForEach(sortedOptions, id: \.0) { option in
                    Text(option.1).tag(option.0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .cornerRadius(10)
            .foregroundColor(.white)
            .onChange(of: sortMode){newValue in
                print("value changed \(newValue)")
                viewModel.fetchNews(query: query, sortBy: newValue)
            }
        }
    }
