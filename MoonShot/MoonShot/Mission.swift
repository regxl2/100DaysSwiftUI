//
//  Mission.swift
//  MoonShot
//
//  Created by Abhishek Rathore on 11/10/24.
//

import Foundation

struct Mission: Identifiable, Codable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "NA"
    }
}

