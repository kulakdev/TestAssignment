import SwiftUI

struct SearchbarView: View{
    @Binding var currentMessage: String = "Enter the search parameter"
    @Binding var q: String
    @ObservedObject var viewModel : ArticleViewModel
    
    var body: some View{
        HStack {
            TextField(currentMessage, text: $q)
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.blue, lineWidth: 1)
                )
                .font(.title2)
            Button("Search"){
                if !q.isEmpty {
                    viewModel.fetchNews(query: q)
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
