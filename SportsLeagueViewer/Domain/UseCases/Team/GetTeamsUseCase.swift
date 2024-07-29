//
//  GetTeamsUseCase.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

class GetTeamUseCase: GetTeamUseCaseProtocol {
    
    // MARK: - Properties
    let teamRepository: TeamRepositoryProtocol
    
    // MARK: - Initializers
    init(teamRepository: TeamRepositoryProtocol = TeamRepository()) {
        self.teamRepository = teamRepository
    }
    
    // MARK: - Accessible
    func execute(query: String) async throws -> [Team] {
        return try await teamRepository.fetch(query: query)
    }
}
