import SwiftUI

struct NewsItemView: View {
    let title: String
    let imageURL: URL?
    let source: String
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Image
            AsyncImageView(url: imageURL)
                .aspectRatio(contentMode: .fill)
                .frame(height: 160)
                .clipped()
                .cornerRadius(8)
            
            // Title
            Text(title)
                .font(.headline)
                .lineLimit(2)
                .foregroundColor(.primary)
            
            // Source and Date
            HStack {
                Text(source)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(date, formatter: dateFormatter)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
        .contentShape(Rectangle())
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }
}

struct AsyncImageView: View {
    let url: URL?
    
    var body: some View {
        if #available(iOS 15.0, *) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemGray5))
                case .success(let image):
                    image
                        .resizable()
                case .failure:
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemGray5))
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(8)
        } else {
            // Fallback for iOS 14
            Color(.systemGray5)
                .overlay(
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                )
                .cornerRadius(8)
        }
    }
}
