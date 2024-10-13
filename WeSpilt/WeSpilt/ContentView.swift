//
//  ContentView.swift
//  WeSpilt
//
//  Created by Abhishek Rathore on 02/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var totalPeople = 1
    @State private var tipPercentage = 10
    @FocusState private var isFocussed: Bool
    
    let tipPercentages: [Int] = [0, 5, 10, 15, 20]
    
    func calculateAmountWithTip(amount: Double, tipPercentage: Int) -> Double{
        return amount + (amount * Double(tipPercentage)/100.0)
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Text("Enter total amount:")
                    TextField("enter the amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD ")).keyboardType(.decimalPad)
                        .focused($isFocussed)
                }
                Section{
                    Picker("Enter the number of people", selection: $totalPeople){
                        ForEach(1..<100, id:\.self){ numberOfPeople in
                            Text("\(numberOfPeople)")
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section("Select tip percentage"){
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){ percentage in
                            Text(percentage, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section{
                    Text("Amount per person: \(calculateAmountWithTip(amount: amount, tipPercentage: tipPercentage) / Double(totalPeople), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                }
            }.navigationTitle("WeSplit").navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    if isFocussed{
                        Button("Done"){
                            isFocussed = false
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
