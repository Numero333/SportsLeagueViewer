//
//  TeamRepositoryMock.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation
import Network
@testable import SportsLeagueViewer

class TeamRepositoryMock: TeamRepositoryProtocol {
    
    // MARK: - Properties
    private let apiService: APIServiceProtocol
    
    // MARK: - Initializers
    init(apiService: APIServiceProtocol = APIServiceMock(ressources: .allTeams)) {
        self.apiService = apiService
    }
    
    // MARK: - Accessible
    func fetch(query: String) async throws -> [SportsLeagueViewer.Team] {
        let apiRequest = APIRequest(baseUrl: .theSportsDB, path: .searchAllTeam, method: .get, query: query)
        let teamsResponse: TeamResponse = try await apiService.performRequest(apiRequest: apiRequest, retries: 3)
        return teamsResponse.teams.map {
            TeamMapper.map(dto: $0)
        }
    }
}
