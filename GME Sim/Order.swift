import Foundation
class Order: Identifiable {
    
    var id: String!
    var customerId: String!
    var orderItems: [Article] = []
    var amount: Double!
    var customerName: String!
    var isCompleted: Bool!
    
    func saveOrderToFirestore() {
        
        FirebaseReference(.Order).document(self.id).setData(orderDictionaryFrom(self))
        {
            error in
            
            if error != nil {
                print("error saving order to firestore: ", error!.localizedDescription)
            }
        }
    }
    
}
// création de la commande
func orderDictionaryFrom(_ order: Order) -> [String : Any] {
    
    var allArticleIds: [String] = []
    
    for article in order.orderItems {
        allArticleIds.append(article.id)
    }
    
    return NSDictionary(objects: [order.id,
                                  order.customerId,
                                  allArticleIds,
                                  order.amount,
                                  order.customerName,
                                  order.isCompleted
                                ],
                        forKeys: [kID as NSCopying,
                                  kCUSTOMERID as NSCopying,
                                  kARTICLEIDS as NSCopying,
                                  kAMOUNT as NSCopying,
                                  kCUSTOMERNAME as NSCopying,
                                  kISCOMPLETED as NSCopying
    ]) as! [String : Any]
}

