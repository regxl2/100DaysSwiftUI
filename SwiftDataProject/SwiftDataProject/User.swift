//
//  User.swift
//  SwiftDataProject
//
//  Created by Abhishek Rathore on 13/10/24.
//

import Foundation
import SwiftData

@Model
class User{
    var id = UUID()
    var name: String
    var city: String
    var joinDate: Date
    @Relationship(deleteRule: .cascade) var jobs = [Job]()
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
