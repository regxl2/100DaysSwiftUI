//
//  AddView.swift
//  iExpense
//
//  Created by Abhishek Rathore on 10/10/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let expenses: Expenses
    
    let types = ["Personal","Business"]
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    TextField("Name",text: $name)
                    Picker("Type", selection: $type){
                        ForEach(types, id: \.self){
                            type in Text(type)
                        }
                    }
                    TextField("Amount", value: $amount, format: .currency(code: "INR"))
                }
            }
            .navigationTitle("Add new expense").navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button("Save"){
                    let expenseItem = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(expenseItem)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
