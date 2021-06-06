import SwiftUI

struct CheckoutView: View {
    @ObservedObject var basketListener = BasketListener()
    static let paymentTypes = ["Paypal","Credit Card", "Ryan Photos", "Politician Stocks", "Ethereum"]
    static let tipAmounts = [0,10,15,20,50,100,200,1000]
    @State private var paymentType = 0
    @State private var tipAmount = 0
    @State private var showingPaymentAlert = false
    
    var totalPrice: Double
    {
        let total = basketListener.orderBasket.total
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $paymentType, label: Text("Payment mode ?")) {
                    
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
            }//Fin de la Section 1
            
            
            Section (header: Text("Tip amount?")) {
                
                Picker(selection: $tipAmount, label: Text("Percentage: ")) {
                    
                    ForEach(0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0]) %")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }//Fin de la Section 2
            
            Section(header: Text("Total: $\(totalPrice, specifier: "%.2f")").font(.largeTitle)) {
                
                Button(action: {
                    self.showingPaymentAlert.toggle()
                    //print("check out")
                    self.createOrder()
                    self.emptyBasket()
                    
                }) {
                    Text("Confirm Order")
                }
            }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
            //Fin de la Section 3
        }//Fin du form
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert)
        {
            Alert(title: Text("Order Confirmed "), message: Text("Thank you !"), dismissButton: .default(Text("OK")))
        }
        }
    
   private func emptyBasket()
   {
    self.basketListener.orderBasket.emptyBasket()
   }
    private func createOrder()
    {
        let order=Order()
        order.amount = totalPrice
        order.id = UUID().uuidString
        order.customerId = FUser.currentId()
        order.orderItems = self.basketListener.orderBasket.items
        order.saveOrderToFirestore()
        
    }
    
    
    }
struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
