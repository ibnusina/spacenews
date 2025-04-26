import Foundation
import Combine
import NetworkAPI

class NewsViewModel: ObservableObject {
    @Published var articles: [NewsItem] = []
    @Published var blogs: [NewsItem] = []
    @Published var reports: [NewsItem] = []
    let provider = NetworkProvider<SpaceService>()
    private var cancellables = Set<AnyCancellable>()
    
    func loadData() {
        
        self.fetchArticles()
        self.fetchReports()
        self.fetchBlogs()
    }
    
    private func fetchArticles() {
        provider.request(.articles).decode(type: [NewsItem].self, keypath: "results")
            .sink(receiveCompletion: {  completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            }, receiveValue: {[weak self] response in
                self?.articles = response
            })
            .store(in: &cancellables)
    }
    
    private func fetchBlogs() {
        provider.request(.blogs).decode(type: [NewsItem].self, keypath: "results")
            .sink(receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            }, receiveValue: {[weak self] response in
                self?.blogs = response
            })
            .store(in: &cancellables)
    }
    
    private func fetchReports() {
        provider.request(.reports).decode(type: [NewsItem].self, keypath: "results")
            .sink(receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            }, receiveValue: { [weak self] response in
                self?.reports = response
            })
            .store(in: &cancellables)
    }
    
   
}
