import SwiftUI

struct ArticleRow: View {
    var categoryName: String
    var articles: [Article]
    var body: some View {
        VStack(alignment: .leading)
        {
            Text(self.categoryName.uppercased())
                .font(.title)
               
            ScrollView(.horizontal, showsIndicators: false)
            {
                HStack
                {
                    ForEach(self.articles) {article in
                        NavigationLink(destination: ArticleDetail(article: article))
                        {
                            ArticleItem(article: article)
                                .frame(width: 300)
                                .padding(.trailing,30)
                        } //Fin navigationLink
                        
                        
                    } // Fin ForEach
                    
                }//Fin Hstack
                
            }//Fin scrollView
            
        }//Fin Vstack
        
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(categoryName: "Demir", articles: articleData)
    }
}
