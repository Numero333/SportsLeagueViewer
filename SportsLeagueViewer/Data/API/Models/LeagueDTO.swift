//
//  LeagueDTO.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

struct LeagueResponse: Decodable {
    let leagues: [LeagueDTO]
}

struct LeagueDTO: Decodable {
    let idLeague: String
    let strLeague: String
}
