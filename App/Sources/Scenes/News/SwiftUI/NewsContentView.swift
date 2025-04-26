import SwiftUI

struct NewsContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                        // Articles Section
                        SectionHeaderView(title: "Articles", count: viewModel.articles.count)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(viewModel.articles) { article in
                                    NavigationLink(destination: DetailView(item: article)) {
                                        NewsItemView(
                                            title: article.title,
                                            imageURL: article.imageURL,
                                            source: article.newsSite,
                                            date: article.publishedAt
                                        )
                                        .frame(width: 280)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Blogs Section
                        SectionHeaderView(title: "Blogs", count: viewModel.blogs.count)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(viewModel.blogs) { blog in
                                    NavigationLink(destination: DetailView(item: blog)) {
                                        NewsItemView(
                                            title: blog.title,
                                            imageURL: blog.imageURL,
                                            source: blog.newsSite,
                                            date: blog.publishedAt
                                        )
                                        .frame(width: 280)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Reports Section
                        SectionHeaderView(title: "Reports", count: viewModel.reports.count)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(viewModel.reports) { report in
                                    NavigationLink(destination: DetailView(item: report)) {
                                        NewsItemView(
                                            title: report.title,
                                            imageURL: report.imageURL,
                                            source: report.newsSite,
                                            date: report.publishedAt
                                        )
                                        .frame(width: 280)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                .padding(.vertical)
            }
            .navigationTitle("Good \(getCurrentGreeting()), User")
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}

struct SectionHeaderView: View {
    let title: String
    let count: Int
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: {
                // View all action
            }) {
                HStack {
                    Text("View all")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsContentView()
    }
}
