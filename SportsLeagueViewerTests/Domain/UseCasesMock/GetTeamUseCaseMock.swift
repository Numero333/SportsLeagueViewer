//
//  GetTeamUseCaseMock.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation
@testable import SportsLeagueViewer

class GetTeamUseCaseMock: GetTeamUseCaseProtocol {
    
    let teamRepository: TeamRepositoryProtocol
    
    init(teamRepository: TeamRepositoryProtocol = TeamRepositoryMock()) {
        self.teamRepository = teamRepository
    }
    
    func execute(query: String) async throws -> [SportsLeagueViewer.Team] {
        return try await teamRepository.fetch(query: query)
    }
}
