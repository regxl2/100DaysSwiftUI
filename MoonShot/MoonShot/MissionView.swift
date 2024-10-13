//
//  MissionView.swift
//  MoonShot
//
//  Created by Abhishek Rathore on 11/10/24.
//

import SwiftUI


struct MissionDivider: View{
    var body: some View{
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.gray)
            .padding(.vertical)
    }
}

struct MissionView: View{
    
    struct CrewMember{
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]){
        self.mission = mission
        self.crew = mission.crew.map{
            member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Could not find astronaut \(member.name)")
            }
        }
    }
    
    var body: some View{
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal){ size,  axis in
                        return size*0.6
                    }
                VStack(alignment:.leading){
                    MissionDivider()
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(mission.description)
                    MissionDivider()
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                }.padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(crew, id: \.role) { member in
                            NavigationLink{
                                AstronautView(astronaut: member.astronaut)
                            }
                            label:{
                                HStack{
                                    Image(member.astronaut.id)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 104, height: 72)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth:1))
                                    VStack{
                                        Text(member.astronaut.name)
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                        Text(member.role)
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                        }
                    }
                }
            }.padding(.bottom)
            
        }.navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
