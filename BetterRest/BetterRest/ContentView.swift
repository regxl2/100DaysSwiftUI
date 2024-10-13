//
//  ContentView.swift
//  BetterRest
//
//  Created by Abhishek Rathore on 05/10/24.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUpTime: Date = defaultWakeUpTime
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeInTake = 1
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""
    
    private static var defaultWakeUpTime:  Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    func calculateBedTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let component = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hours = (component.hour ?? 0)*60*60
            let minutes = (component.minute ?? 0)*60
            let prediction = try model.prediction(wake: Double(hours + minutes),  estimatedSleep: sleepAmount, coffee: Double(coffeeInTake))
            let sleepTime = wakeUpTime - prediction.actualSleep
            alertMessage = "You should go to bed at \(sleepTime.formatted(date: .omitted, time: .shortened))"
            alertTitle = "Sleep Time"
        }
        catch{
            alertTitle = "Error"
            alertMessage = "Something went wrong. Please try again later."
        }
        showAlert = true
    }
    
    var body: some View{
        NavigationStack{
            Form{
                VStack{
                    Text("When do you wake up?")
                    DatePicker("Please enter your time", selection: $wakeUpTime, displayedComponents: .hourAndMinute).labelsHidden()
                }
                VStack{
                    Text("Desired amount of sleep:")
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 0...24)
                }
                VStack{
                    Text("Daily coffee in take:")
                    Stepper("\(coffeeInTake) cup\(coffeeInTake == 1 ? "" : "s")", value: $coffeeInTake, in: 0...20)
                }
            }
                .navigationTitle("Better Rest").navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    Button("Calculate", action: calculateBedTime)
                }
        }.alert(alertTitle, isPresented: $showAlert){
            Button("OK"){}
        }
        message: {
            Text(alertMessage)
        }
    }
}

#Preview { 
    ContentView()
}
