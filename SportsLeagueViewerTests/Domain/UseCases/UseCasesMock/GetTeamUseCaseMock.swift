//
//  GetTeamUseCaseMock.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation
@testable import SportsLeagueViewer

class GetTeamUseCaseMock: GetTeamUseCaseProtocol {
    
    // MARK: - Properties
    let teamRepository: TeamRepositoryProtocol
    
    // MARK: - Initializers
    init(teamRepository: TeamRepositoryProtocol = TeamRepositoryMock()) {
        self.teamRepository = teamRepository
    }
    
    // MARK: - Accessible
    func execute(query: String) async throws -> [SportsLeagueViewer.Team] {
        return try await teamRepository.fetch(query: query)
    }
}
