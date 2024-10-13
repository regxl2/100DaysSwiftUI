//
//  ContentView.swift
//  iExpense
//
//  Created by Abhishek Rathore on 08/10/24.
//

import SwiftUI

struct ExpenseItem: Identifiable , Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses{
    
    var items = [ExpenseItem](){
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(items){
                UserDefaults.standard.set(data, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showSheet = false
    
    func removeItem(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View{
        NavigationStack{
            List{
                ForEach(expenses.items){
                    item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code:"INR"))
                    }
                }.onDelete(perform: removeItem)
            }.navigationTitle("iExpenses").navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    Button("Add Expense", systemImage: "plus"){
                        showSheet = true
                    }
                }
                .sheet(isPresented: $showSheet){
                    AddView(expenses: expenses)
                }
        }
    }
}

#Preview {
    ContentView()
}
