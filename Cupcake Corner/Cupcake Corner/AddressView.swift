//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Abhishek Rathore on 12/10/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name", text: $order.name)
                    TextField("Street Adress", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("Zip Code", text: $order.zipCode)
                }
                Section{
                    NavigationLink("Checkout"){
                        Checkout(order: order)
                    }
                }.disabled(!order.hasValidAddress)
            }.navigationTitle("Address")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddressView(order: Order())
}
