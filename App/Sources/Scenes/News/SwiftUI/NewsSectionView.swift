import SwiftUI

struct NewsSectionView<Content: View>: View {
    let title: String
    let count: Int
    let content: Content
    
    init(title: String, count: Int, @ViewBuilder content: () -> Content) {
        self.title = title
        self.count = count
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(title: title, count: count)
            
            ScrollView(.horizontal, showsIndicators: false) {
                content
                    .padding(.horizontal)
            }
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        NewsSectionView(title: "Articles", count: 10) {
            Text("Content goes here")
        }
        .previewLayout(.sizeThatFits)
    }
}
