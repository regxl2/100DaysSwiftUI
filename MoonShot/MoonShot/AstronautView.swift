//
//  AstronautView.swift
//  MoonShot
//
//  Created by Abhishek Rathore on 11/10/24.
//

import Foundation
import SwiftUI

struct AstronautView: View{
    let astronaut: Astronaut
    var body: some View{
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astronaut.description)
            }.navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(.darkBackground)
            .preferredColorScheme(.dark)
    }
}

#Preview{
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    AstronautView(astronaut: astronauts["armstrong"]!)
}
