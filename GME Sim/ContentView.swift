import SwiftUI

struct ContentView: View {
    @ObservedObject var articleListener = ArticleListener()
    @State private var showingBasket = false
    var categories: [String : [Article]]
    {
        .init(grouping: articleListener.articles,
              by: {$0.category.rawValue})
    }
    
    var body: some View {
        NavigationView {
            List(categories.keys.sorted(),id: \String.self){
                key in
                ArticleRow(categoryName: "\(key)", articles: self.categories[key]!)
                    .frame(height:320)
                    
                
            }
            .navigationBarTitle(Text(verbatim: "Boutique"))
                .navigationBarItems(leading:
                Button(action: {
                    FUser.logOutCurrentUser{(error) in
                        print("error logging out user,",error?.localizedDescription)
                    }
                }, label: {
                    Text("Log out")
                }), trailing: Button(action: {
                    //code
                    self.showingBasket.toggle()
                   // print("basket")
                }, label: {
                    Image("basket_1_100x100")
                })
                .sheet(isPresented: $showingBasket)
                {
                    if FUser.currentUser() != nil &&
                        FUser.currentUser()!.onBoarding
                    {
                    OrderBasketView()
                    }else if FUser.currentUser() != nil
                    {
                        FinishRegistrationView()
                    }else
                    {
                        LoginView()
                    }
                    
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
