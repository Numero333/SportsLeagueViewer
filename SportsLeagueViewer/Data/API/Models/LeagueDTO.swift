//
//  LeagueDTO.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

struct LeagueResponse: Codable {
    let leagues: [LeagueDTO]
}

struct LeagueDTO: Codable {
    let idLeague: String
    let strLeague: String
}
