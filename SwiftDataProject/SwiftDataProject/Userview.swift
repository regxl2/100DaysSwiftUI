//
//  Userview.swift
//  SwiftDataProject
//
//  Created by Abhishek Rathore on 14/10/24.
//

import SwiftUI
import SwiftData

struct Userview: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    func deleteUsers(at offsets: IndexSet){
        for index in offsets{
            let user = users[index]
            modelContext.delete(user)
        }
    }
    
    var body: some View {
        List{
            ForEach(users, id: \.self){
                user in
                HStack{
                    Text(user.name)
                    Spacer()
                    Text(String(user.jobs.count))
                }
            }
            .onDelete(perform: deleteUsers)
        }
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]){
        _users = Query(filter: #Predicate <User>{
            user in user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    Userview(minimumJoinDate: Date.now, sortOrder: [SortDescriptor(\User.name), SortDescriptor(\User.joinDate)])
        .modelContainer(for: User.self)
}
