//
//  ContentView.swift
//  MoonShot
//
//  Created by Abhishek Rathore on 11/10/24.
//

import SwiftUI



struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    
    let layout = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false){
                LazyVGrid(columns: layout){
                    ForEach(missions){ mission in
                        NavigationLink{
                            MissionView(mission: mission, astronauts: astronauts)
                        }
                        label:{
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack{
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }.navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
