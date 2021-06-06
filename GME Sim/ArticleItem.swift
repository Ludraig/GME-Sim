import SwiftUI

struct ArticleItem: View {
    var article: Article
    var body: some View {
        VStack(alignment: .leading, spacing: 16)
        {
            Image(article.imageName)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 170)
                            .cornerRadius(10)
                            .shadow(radius: 10)
            VStack(alignment: .leading, spacing: 5) {
                            Text(article.name)
                                .foregroundColor(.primary)
                                .font(.headline)
                            Text(article.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .frame(height:40)
                        }
        }
    }
}

struct ArticleItem_Previews: PreviewProvider {
    static var previews: some View {
        ArticleItem(article: articleData[0])
    }
}
