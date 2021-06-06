import SwiftUI

struct OrderBasketView: View {
    @ObservedObject var basketListener = BasketListener()
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(self.basketListener.orderBasket?.items ?? []) { article in
                        HStack {
                            Text(article.name)
                            Spacer()
                            Text("$\(article.price.clean)")
                        }//Fin de HStack
                    }//Fin de ForEach
                        .onDelete { (indexSet) in
                            self.deleteItems(at: indexSet)
                    }
                }
                Section {
                    //Mettre le lien vers le checkout
                    NavigationLink(destination: CheckoutView())
                    {
                        Text("Place Order")
                    }
                }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
            } //Fin List
            .navigationBarTitle("Order")
            .listStyle(GroupedListStyle())
        } //Fin Navigation view
    }
    func deleteItems(at offsets: IndexSet) {
        self.basketListener.orderBasket.items.remove(at: offsets.first!)
        self.basketListener.orderBasket.saveBasketToFirestore()
    }
}
struct OrderBasketView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBasketView()
    }
}
