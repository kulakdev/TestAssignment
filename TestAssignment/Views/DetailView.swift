import SwiftUI

struct DetailView: View {
    let item: Article
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View{
        ScrollView {
            VStack(alignment: .center){
                Text(dateFormatter.string(from: item.publishedAt)).foregroundColor(.red)
                Text(item.title ?? "title unavailable")
                    .font(.largeTitle)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                VStack(alignment: .center){
                    HStack{
                        Text(item.source.name).bold()
                        Text(item.author ?? "").lineLimit(nil).multilineTextAlignment(.center)
                    }
                    .foregroundColor(.blue)  
                }
                .padding(5)
                .font(.subheadline)
                .fixedSize()
                
                Text(item.description ?? "")
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                
                AsyncImage(url: item.urlToImage){image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                        .padding(10)
                } placeholder: {
                    Text("Attempting to load the image")
                    ProgressView().progressViewStyle(.circular)
                        .padding()
                }
            }
            .padding()
            Spacer()
        }
    }
}
