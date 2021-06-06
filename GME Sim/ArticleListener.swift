import Foundation
import Firebase
class ArticleListener: ObservableObject{
    @Published var articles: [Article] = []
    
    init()
    {
        downloadArticles()
    }
    
// recupérer les articles
    func downloadArticles()
    {
        FirebaseReference(.Menu).getDocuments{(snapshot,Error) in
            guard let snapshot=snapshot else {return}
            if !snapshot.isEmpty{
                self.articles=ArticleListener.articleFromDictionary(snapshot)
        }
    }
}
// Prendreles données de type clé-valeur et les transferer au formatdes articles
    static func articleFromDictionary(_ snapshot:QuerySnapshot)->[Article]{
        var allArticles:[Article]=[]
        for snapshot in snapshot.documents{
            let articleData=snapshot.data()
            allArticles.append(Article(id:articleData[kID] as? String ?? UUID().uuidString, name: articleData[kNAME] as?String ?? "unknown", imageName: articleData[kIMAGENAME] as? String ?? "unknown", category: Category(rawValue: articleData[kCATEGORY] as? String ?? "Demir") ?? .Demir, description: articleData[kDESCRIPTION] as? String ?? "Description is missing",price: articleData[kPRICE] as? Double ?? 0.0))
    }
    return allArticles
}
    
}
