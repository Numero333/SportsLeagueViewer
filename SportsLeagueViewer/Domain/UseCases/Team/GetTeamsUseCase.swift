//
//  GetTeamsUseCase.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

class GetTeamUseCase: GetTeamUseCaseProtocol {
    
    let teamRepository: TeamRepositoryProtocol
    
    init(teamRepository: TeamRepositoryProtocol = TeamRepository()) {
        self.teamRepository = teamRepository
    }
    
    func execute(query: String) async throws -> [Team] {
        return try await teamRepository.fetch(query: query)
    }
}
