//
//  LeagueRepositoryProtocol.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier MEITE on 21/10/2025.
//

protocol LeagueRepositoryProtocol {
    func fetch() async throws -> [League]
}
