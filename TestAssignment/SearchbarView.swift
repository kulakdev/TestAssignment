import SwiftUI

struct SearchbarView: View{
    @Binding var currentMessage: String
    @Binding var q: String
    @ObservedObject var viewModel : ArticleViewModel
    
    var body: some View{
        HStack {
            TextField(currentMessage, text: $q)
                .border(.blue)
                .padding(7)
                .font(.title2)
            Button("Search"){
                if !q.isEmpty {
                    viewModel.fetchNews(query: String(q))
                } else {
                    currentMessage = "ENTER THE SEARCH PARAMETER"
                }
            }
            .padding(9)
            .background(.blue)
            .cornerRadius(15)
            .foregroundColor(.white)
        }
        .padding()
        .accessibilityLabel("Search for news")
    }
}
