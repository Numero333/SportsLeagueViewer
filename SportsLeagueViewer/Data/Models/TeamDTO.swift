//
//  TeamDTO.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

struct TeamResponse: Decodable {
    let teams: [TeamDTO]
}

struct TeamDTO: Decodable {
    let idTeam: String
    let strTeam: String
    let strBadge: String
}
