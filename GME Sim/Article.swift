import Foundation
import SwiftUI

enum Category: String, CaseIterable, Codable,Hashable{
    case Demir
    case DemirWithSanta
    case DemirSnapchat
    case GME
}

struct Article: Identifiable,Hashable{
    var id: String
    var name: String
    var imageName: String
    var category: Category
    var description: String
    public var price: Double
}

func articleDictionnaryFrom(article: Article) -> [String : Any] {
    return NSDictionary(objects: [article.id,
                               article.name,
                               article.imageName,
                               article.category.rawValue,
                               article.description,
                               article.price
                                ], forKeys: [kID as NSCopying,
                                             kNAME as NSCopying,
                                             kIMAGENAME as NSCopying,
                                             kCATEGORY as NSCopying,
                                             kDESCRIPTION as NSCopying,
                                             kPRICE as NSCopying
    ]) as! [String : Any]
}
//Fonction pour parcourir le tableau et transférer les données dans Firebase
func createMenu(){
    for article in articleData{
        FirebaseReference( .Menu).addDocument(data: articleDictionnaryFrom(article: article))
    }
}

let articleData = [
    //BAGUES
    Article(id: UUID().uuidString, name: "Demir Picture 1", imageName: "resized-image-Promo copy 2", category: Category.Demir, description: "Picture of Demir as a child.", price: 76.85),
    
    Article(id: UUID().uuidString, name: "Demir Picture 2", imageName: "resized-image-Promo copy 3", category: Category.Demir, description: "Picture of Demir pointing at the camera.", price: 56.68),
    
    Article(id: UUID().uuidString, name: "Demir Picture 3", imageName: "resized-image-Promo copy 4", category: Category.Demir, description: "Picture of Demir with Basketball Coach's arm around him.", price: 58.64),
    
    Article(id: UUID().uuidString, name: "Demir Picture 4", imageName: "resized-image-Promo copy 5", category: Category.Demir, description: "Picture of Demir looking angry.", price: 58.63),
    
    Article(id: UUID().uuidString, name: "Demir Picture 5", imageName: "resized-image-Promo copy 6", category: Category.Demir, description: "Picture of Demir looking sad.", price: 73.39),
    Article(id: UUID().uuidString, name: "Demir Picture 6", imageName: "resized-image-Promo copy 7", category: Category.Demir, description: "Picture of Demir doing the 'Whip' dance move from a father's day tribute to Hikmet.", price: 50.00),
    Article(id: UUID().uuidString, name: "Demir Picture 7", imageName: "resized-image-Promo copy 8", category: Category.Demir, description: "Picture of Demir doing the 'Nae-Nae' dance move from a father's day tribute to Hikmet.", price: 56.64),
    Article(id: UUID().uuidString, name: "Demir Picture 8", imageName: "Screenshot_2021-04-01_at_9.12.43_AM", category: Category.Demir, description: "Picture of Demir throwing an orange into the garbage can at school.", price: 84.34),
        
    //CAMERAS
    Article(id: UUID().uuidString, name: "Demir Picture 9", imageName: "Webp.net-resizeimage_copy_2", category: Category.Demir, description: "Picture of Demir making the YouTuber reaction video face.", price: 63.53),
    
    Article(id: UUID().uuidString, name: "Demir Picture 10", imageName: "Webp.net-resizeimage_copy_3", category: Category.Demir, description: "Picture of Demir taking a mirror selfie with Hikmet's cellphone.", price: 67.43),

    Article(id: UUID().uuidString, name: "Demir Picture 11", imageName: "Webp.net-resizeimage_copy_4", category: Category.Demir, description: "Picture of Demir looking disapointed.", price: 56.74),

    Article(id: UUID().uuidString, name: "Demir Picture 12", imageName: "Webp.net-resizeimage_copy", category: Category.Demir, description: "Picture of Demir with a large grin.", price: 46.85),
    Article(id: UUID().uuidString, name: "Demir Picture 13", imageName: "Webp.net-resizeimage", category: Category.Demir, description: "Picture of Demir with his friend Griffin.", price: 299.99),
    Article(id: UUID().uuidString, name: "Demir Picture From Snapchat", imageName: "resized-image-Promo", category: Category.DemirSnapchat, description: "Picture of Demir from his Snapchat, with a caption that reads 'Lol you accidentally left me on read'.", price: 99.99),
    Article(id: UUID().uuidString, name: "Demir Picture With Santa Plush", imageName: "resized-image-Promo copy", category: Category.DemirWithSanta, description: "Picture of Demir with a plush doll of Santa Claus.", price: 399.99),
    Article(id: UUID().uuidString, name: "GME Stock", imageName: "resized-image-Promo copy-1", category: Category.GME, description: "Gamestop stock.", price: 483.00),
   
]

