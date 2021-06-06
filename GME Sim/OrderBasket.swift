import Foundation
import Firebase
class OrderBasket: Identifiable
{
    var id: String!
    var ownerId: String!
    var items: [Article] = []
    
    var total: Double
    {
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        } else {
            return 0.0
        }
    }
    // ajouter un article
    func add(_ item: Article)
    {
        items.append(item)
    }
    // enlever un article
    func remove(_ item: Article) {
        
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    // vider le panier
    func emptyBasket() {
        self.items = []
        saveBasketToFirestore()
    }
    // sauvegarder dans Firebase
    func saveBasketToFirestore() {
        
        FirebaseReference(.Basket).document(self.id).setData(basketDictionaryFrom(self))
    }

}
func basketDictionaryFrom(_ basket: OrderBasket) -> [String : Any] {
    
    var allArticlesIds: [String] = []
    
    for article in basket.items {
        allArticlesIds.append(article.id)
    }
    
    return NSDictionary(objects: [basket.id,
                                  basket.ownerId,
                                  allArticlesIds
                                ],
                    forKeys: [kID as NSCopying,
                     kOWNERID as NSCopying,
                     kARTICLEIDS as NSCopying
    ]) as! [String : Any]
    
}

