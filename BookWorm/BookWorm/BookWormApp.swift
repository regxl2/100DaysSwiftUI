//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Abhishek Rathore on 12/10/24.
//

import SwiftUI
import SwiftData

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
