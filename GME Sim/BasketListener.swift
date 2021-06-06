import Foundation
import Firebase

class BasketListener: ObservableObject {
    
    @Published var orderBasket: OrderBasket!
    
    init()
    {
        downloadBasket()
    }
    
    func downloadBasket()
    {
        if FUser.currentUser() != nil
        {
            FirebaseReference(.Basket).whereField(kOWNERID, isEqualTo: FUser.currentId()).addSnapshotListener { (snapshot, error) in
                
                guard let snapshot = snapshot else { return }
                
                if !snapshot.isEmpty {
                    
                    let basketData = snapshot.documents.first!.data()
                 //appel à la fonction
                    getArticlesFromFirestore(withIds: basketData[kARTICLEIDS] as? [String] ?? []) { (allArticles) in
                        
                        let basket = OrderBasket()
                        basket.ownerId = basketData[kOWNERID] as? String
                        basket.id = basketData[kID] as? String
                        basket.items = allArticles
                        self.orderBasket = basket
                    }
                   
                }
               
            }
        }
    }
}

func getArticlesFromFirestore(withIds: [String], completion: @escaping (_ articleArray: [Article]) -> Void) {
    var count = 0
    var articleArray: [Article] = []
    
    if withIds.count == 0 {
        completion(articleArray)
        return
    }
    //parcourir les articles
    for articleId in withIds {
        FirebaseReference(.Menu).whereField(kID, isEqualTo: articleId).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                
                let articleData = snapshot.documents.first!
                
                articleArray.append(Article(id: articleData[kID] as? String ?? UUID().uuidString,
                                        name: articleData[kNAME] as? String ?? "Unknown",
                                        imageName: articleData[kIMAGENAME] as? String ?? "Unknown",
                                        category: Category(rawValue: articleData[kCATEGORY] as? String ?? "bague") ?? .Demir,
                                        description: articleData[kDESCRIPTION] as? String ?? "Description is missing",
                                        price: articleData[kPRICE] as? Double ?? 0.00))
                count += 1
                
            } else {
                print("no article")
                completion(articleArray)
            }
            // vérifier le nombre d'articles
            if count == withIds.count {
                completion(articleArray)
            }
            
        }

    }
    
}
