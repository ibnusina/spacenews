import Foundation

// Base model for all news items
struct NewsItem: Identifiable, Codable {
    let id: Int
    let title: String
    let authors: [Author]
    let url: URL
    let imageURL: URL?
    let publishedAt: Date
    let summary: String
    let newsSite: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case authors
        case url
        case newsSite = "news_site"
        case imageURL = "image_url"
        case publishedAt = "published_at"
        case summary
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.newsSite = try container.decode(String.self, forKey: .newsSite)
        self.authors = try container.decode([Author].self, forKey: .authors)
        self.url = try container.decode(URL.self, forKey: .url)
        self.imageURL = try container.decodeIfPresent(URL.self, forKey: .imageURL)
        let dateString = try container.decode(String.self, forKey: .publishedAt)
        self.publishedAt = stringToDate(dateString: dateString) ?? Date()
    }
}

struct Author: Codable {
    let name: String
    let socials: [String: String]?
}

// Response models
struct NewsResponse {
    let count: Int
    let next: String?
    let previous: String?
    let results: [NewsItem]
}
