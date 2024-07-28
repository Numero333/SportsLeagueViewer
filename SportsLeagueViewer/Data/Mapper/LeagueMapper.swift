//
//  LeagueMapper.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation

struct LeagueMapper {
    static func map(dto: LeagueDTO) -> League {
        return League(
            id: dto.idLeague,
            name: dto.strLeague
        )
    }
}
