//
//  CrewView.swift
//  Moonshot
//
//  Created by Lin Ochoa on 12/16/24.
//

import SwiftUI
struct CrewMemberRow: View {
    let crewMember: CrewMember
    var body: some View {
        NavigationLink(value: crewMember.astronaut) {
            VStack {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .frame(width: 208, height: 144)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .strokeBorder(.white, lineWidth: 1)
                    )
                
                VStack {
                    Text(crewMember.astronaut.name)
                        .foregroundStyle(.white)
                        .font(.title)
                        .accessibilityLabel(crewMember.astronaut.name.replacingOccurrences(of: ".", with: " "))
                    Text(crewMember.role)
                        .foregroundStyle(.white.opacity(0.5))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
    }
}

struct CrewView: View {
    let crew: [CrewMember]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(crew, id: \.role) { crewMember in
                    CrewMemberRow(crewMember: crewMember)
                }
            }
        }
        .navigationDestination(for: Astronaut.self) { astronaut in
            AstronautView(astronaut: astronaut)
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
