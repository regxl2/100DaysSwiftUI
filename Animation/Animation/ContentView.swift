//
//  ContentView.swift
//  Animation
//
//  Created by Abhishek Rathore on 08/10/24.
//


import SwiftUI

struct ContentView: View {
    @State private var showRectangle = false
    
    var body: some View{
        Button("Tap me"){
            withAnimation{
                showRectangle.toggle()
            }
        }
        if showRectangle{
            Rectangle().fill(.red).frame(width: 100, height: 100)
                .transition(.asymmetric(insertion: .slide, removal: .opacity))
        }
    }
}

#Preview {
    ContentView()
}
