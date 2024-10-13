//
//  ContentView.swift
//  CustomModifiers
//
//  Created by Abhishek Rathore on 04/10/24.
//

import SwiftUI

// custom view
struct CustomCapsule: View{
    let text: String
    var body: some View{
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .cornerRadius(50)
    }
}

// custom modifier
struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.red)
            .cornerRadius(50)
    }
}

// extension function for custom modifier
extension View {
    func titleStyle() -> some View{
        modifier(TitleStyle())
    }
}

// custom view container

struct GridLayout<Content: View>: View{
    let rows: Int, columns: Int, content: (Int, Int) -> Content
    
    var body: some View{
        VStack{
            ForEach(0..<rows, id: \.self){ row in
                HStack{
                    ForEach(0..<columns, id: \.self){ column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @State var isRed = false
    var body: some View {
        VStack{
            CustomCapsule(text: "Hello World!")
                .foregroundStyle(.white)
            CustomCapsule(text: "My name is Abhishek")
                .foregroundStyle(.white)
            Text("Hello world again")
                .titleStyle()
            GridLayout(rows: 10, columns: 10 ){ row, column in
                Text("\(row*10+column+1)")
            }
        }
    }
}

#Preview {
    ContentView()
}
