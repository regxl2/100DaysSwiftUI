//
//  ContentView.swift
//  Navigation
//
//  Created by Abhishek Rathore on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var title = "Navigation"
    var body: some View {
        NavigationStack{
            TextField("Enter the navigation title", text: $title)
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
