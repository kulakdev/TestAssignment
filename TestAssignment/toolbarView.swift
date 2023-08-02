import SwiftUI
import Foundation

struct ToolbarView: View{
    @Binding var sortMode : String
    @Binding var query: String
//    @ObservedObject var viewModel: ArticleViewModel
    
    let sortedOptions: [(String, String)] = [
            ("relevancy", "Most Relevant"),
            ("popularity", "Most Popular"),
            ("publishedAt", "Newest")
        ]
        
    
    var body: some View {
            Picker("Sort news by", selection: $sortMode) {
                ForEach(sortedOptions, id: \.0) { option in
                    Text(option.1).tag(option.0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(width: 180)
            .background(Color(hue: 0.598, saturation: 0.076, brightness: 0.969, opacity: 10.0))
            .cornerRadius(10)
            .foregroundColor(.white)
            .onChange(of: sortMode){newValue in
//                print("value changed \(newValue)")
//                viewModel.fetchNews(query: query, sortBy: newValue)
            }
        }
    }
