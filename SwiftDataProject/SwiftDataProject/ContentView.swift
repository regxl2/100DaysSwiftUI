//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Abhishek Rathore on 13/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State var showfilter = false
    @State var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    
    func addSample(){
        let user = User(name: "Ashish", city: "Jaipur", joinDate: .now)
        modelContext.insert(user)
        let job1 = Job(name: "SWE", priority: 2, owner: user)
        let job2 = Job(name: "SDE", priority: 1, owner: user)
        user.jobs = [job1, job2]
    }
    
    var body: some View {
        NavigationStack{
            Userview(minimumJoinDate: showfilter ? .now : .distantPast, sortOrder: sortOrder)
                .onAppear(perform: addSample)
            .navigationTitle("Users")
            .navigationDestination(for: User.self){
                selection in
                EditUserView(user: selection)
            }
            .toolbar{
                ToolbarItemGroup{
                    Button("Add Samples", systemImage: "plus"){
                        try? modelContext.delete(model: User.self)
                        let first = User(name: "Abhishek", city: "Kanpur", joinDate: .now.addingTimeInterval(86400 * 10))
                        let second = User(name: "Gaurav", city: "Bhopal", joinDate: .now.addingTimeInterval(86400 * 5))
                        let third = User(name: "Prasanjeet", city: "Ranchi", joinDate: .now.addingTimeInterval(86400 * -5))
                        let fourth = User(name: "Rishab", city: "Varansi", joinDate: .now.addingTimeInterval(86400 * -10))
                        modelContext.insert(first)
                        modelContext.insert(second)
                        modelContext.insert(third)
                        modelContext.insert(fourth)
                    }
                    Button(showfilter ? "Show Everyone" : "Show Upcoming" ){
                        showfilter.toggle()
                    }
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
                        Picker("Sort", selection: $sortOrder){
                            Text("Sort by name").tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate)
                            ])
                            Text("Sort by join date").tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
