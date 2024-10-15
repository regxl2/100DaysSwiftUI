//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Abhishek Rathore on 13/10/24.
//

import SwiftUI
import SwiftData

struct EditUserView: View {
    @Bindable var user: User
    var body: some View {
        Form{
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Date", selection: $user.joinDate, displayedComponents: [.date])
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do{
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: configuration)
        let user = User(name: "Abhishek", city: "Trichy", joinDate: .now)
        return EditUserView(user: user)
            .modelContainer(container)
    }
    catch{
        return Text("Failed to create preview:  \(error.localizedDescription)")
    }
}
