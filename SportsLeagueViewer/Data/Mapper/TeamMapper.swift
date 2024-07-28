//
//  TeamMapper.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation

struct TeamMapper {
    static func map(dto: TeamDTO) -> Team {
        return Team(
            id: dto.idTeam,
            name: dto.strTeam,
            badge: dto.strBadge
        )
    }
}
