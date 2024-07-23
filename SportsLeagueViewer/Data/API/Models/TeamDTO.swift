//
//  TeamDTO.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

struct TeamResponse: Codable {
    let teams: [TeamDTO]
}

struct TeamDTO: Codable {
    let idTeam: String
    let strTeam: String
    let strBadge: String
    
    func toTeamEntity() -> Team {
        return Team(
            id: idTeam,
            name: strTeam,
            badge: strBadge
        )
    }
}
