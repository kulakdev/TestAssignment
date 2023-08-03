import SwiftUI

struct SearchbarView: View{
    @State var currentMessage: String = "Enter the search parameter"
    @ObservedObject var viewModel : ArticleViewModel
    
    var body: some View{
        HStack {
            TextField(currentMessage, text: $viewModel.q)
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.blue, lineWidth: 1)
                )
                .font(.title2)
            Button("Search"){
                if !viewModel.q.isEmpty {
                    viewModel.fetchNews(query: viewModel.q)
                } else {
                    currentMessage = "ENTER THE SEARCH PARAMETER"
                }
            }
            .padding(10)
            .background(.blue)
            .cornerRadius(15)
            .foregroundColor(.white)
        }
        .padding(.horizontal)
        .accessibilityLabel("Search for news")
    }
}
