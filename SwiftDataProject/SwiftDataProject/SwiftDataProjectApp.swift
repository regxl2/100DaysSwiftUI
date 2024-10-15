//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Abhishek Rathore on 13/10/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
