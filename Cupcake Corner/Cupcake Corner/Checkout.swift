//
//  Checkout.swift
//  Cupcake Corner
//
//  Created by Abhishek Rathore on 12/10/24.
//
import SwiftUI

struct Checkout: View{
    var order: Order
    @State var showingConfirmation = false
    @State var confirmationMessage = ""
    
    func placeOrder() async {
        guard let encodedData = try? JSONEncoder().encode(order) else {
            print("Error while encoding data")
            return
        }
        guard let url = URL(string: "https://reqres.in/api/users") else {
            print("Error in parsing the Url")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedData)
            
            let response = try JSONDecoder().decode(Order.self, from: data)
            showingConfirmation = true
            confirmationMessage = "Your order for \(response.quantity)x\(Order.types[response.type].lowercased()) cupcakes has been placed successfully."
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    var body: some View{
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){
                    phase in
                    if let image = phase.image{
                        image.resizable()
                            .scaledToFit()
                    }
                    else if phase.error != nil{
                        Text("Error in loading image")
                    }
                    else{
                        ProgressView()
                    }
                }.frame(height: 233)
                Text("Your total cost is: \(order.cost, format: .currency(code: "INR"))")
                    .font(.title)
                Button("Place the order"){
                    Task{
                        await placeOrder()
                    }
                }.padding()
            }
        }
        .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            .alert("Thank You!", isPresented: $showingConfirmation){
                Button("OK"){}
            } message:{
                Text(confirmationMessage)
            }
    }
}

#Preview {
    Checkout(order: Order())
}
