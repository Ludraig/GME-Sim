import SwiftUI

extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}


struct ArticleDetail: View {
    @State private var showingAlert = false
    @State private var showingLogin = false
    
    var article: Article
    var body: some View {
        
        ScrollView(.vertical,showsIndicators: false)
        {
            ZStack(alignment: .bottom)
            {
                Image(article.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
                HStack
                {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(article.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }//Fin Vstack
                    .padding(.leading)
                    .padding(.bottom)
                    Spacer()
                    
                }//Fin Hstack
                
            } // fin Zstack
            .listRowInsets(EdgeInsets())
            let Paul = article.price.description
            Text(article.description + " $" + Paul)
                .foregroundColor(.primary)
                .font(.body)
                .lineLimit(5)
                .padding()
            
            HStack {
                Spacer()
                //Button
                OrderButton(showAlert: $showingAlert, showLogin: $showingLogin, article: article)
                Spacer()
            }.padding(.top,50)
            
        }// fin scrollview
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Added to Basket"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(article: articleData.first!)
    }
}

struct OrderButton:  View {
    @ObservedObject var basketListener = BasketListener()
    @Binding var showAlert: Bool
    @Binding var showLogin: Bool
    var article: Article
    var body : some View {
        
        Button(action: {
            if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding
            {
            self.showAlert.toggle()
            self.addItemToBasket()
            }
            else
            {
                self.showLogin.toggle()
            }
        })
        {
            Text("Add to basket")
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(15)
        .sheet(isPresented: self.$showLogin)
        {
            if FUser.currentUser() != nil
            {
                FinishRegistrationView()
            }
            else{
                LoginView()
            }
        }
        
    }
    
    // ajouter au panier
    private func addItemToBasket()
    {
        var orderBasket: OrderBasket
        //vérifier si le basket n'est pas vide
        if self.basketListener.orderBasket != nil
        {
            orderBasket = self.basketListener.orderBasket
        }
        else{
            
            orderBasket = OrderBasket()
            orderBasket.ownerId = FUser.currentId()
            orderBasket.id = UUID().uuidString
        }
        
        orderBasket.add(self.article)
        orderBasket.saveBasketToFirestore()
    }
    
    
}

