//
//  GetTeamsUseCaseProtocol.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

protocol GetTeamUseCaseProtocol {
    func execute(query: String) async throws -> [Team]
}
