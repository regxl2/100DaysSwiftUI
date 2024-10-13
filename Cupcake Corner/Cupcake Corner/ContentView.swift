//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Abhishek Rathore on 12/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Select you cake type", selection: $order.type){
                        ForEach(Order.types.indices, id: \.self){
                            index in Text(Order.types[index])
                        }
                    }
                    Stepper("Number of Cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section{
                    Toggle("Any special request?", isOn: $order.specialRequest.animation())
                    if(order.specialRequest){
                        Toggle("Add ExtraFrosting", isOn: $order.extraFrosting.animation())
                        Toggle("Add Sprinkles", isOn: $order.addSprinkles.animation())
                    }
                }
                Section{
                    NavigationLink("Delivery Details"){
                        AddressView(order: order)
                    }
                }
            }.navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
