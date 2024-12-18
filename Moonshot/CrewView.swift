//
//  CrewView.swift
//  Moonshot
//
//  Created by Lin Ochoa on 12/16/24.
//

import SwiftUI

struct CrewView: View {    
    let crew: [CrewMember]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(Array(crew.enumerated()), id: \.1.role) { index, crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        VStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 208, height: 144)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )

                            VStack() {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.title)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            if index != crew.count - 1 {
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundStyle(.lightBackground)
                                    .padding(.vertical)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(.darkBackground)
    }
    init(crew: [CrewMember]) {
        self.crew = crew
    }
}

#Preview {
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let crewMembers: [CrewMember] = mission[0].crew.compactMap { crewRole in
        if let astronaut = astronauts[crewRole.name] {
            return CrewMember(role: crewRole.role, astronaut: astronaut)
        } else {
            return nil
        }
    }
    CrewView(crew: crewMembers)
}
