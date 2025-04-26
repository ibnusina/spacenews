import SwiftUI

struct DetailView: View {
    let item: NewsItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image
                AsyncImageView(url: item.imageURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 16) {
                    // Title
                    Text(item.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Source and Date
                    HStack {
                        Text(item.newsSite)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(item.publishedAt, formatter: dateFormatter)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Authors
                    if !item.authors.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Authors:")
                                .font(.headline)
                            
                            ForEach(item.authors, id: \.name) { author in
                                Text(author.name)
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    Divider()
                    
                    // Summary
                    Text(item.summary)
                        .font(.body)
                    
                    Spacer()
                    
                    // Link to original article
                    Link(destination: item.url) {
                        HStack {
                            Text("Read full article")
                            Image(systemName: "arrow.up.right.square")
                        }
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Article Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }
}
