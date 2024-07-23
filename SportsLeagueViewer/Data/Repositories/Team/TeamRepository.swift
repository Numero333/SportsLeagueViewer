//
//  TeamRepository.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

class TeamRepository: TeamRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetch(query: String) async throws -> [Team] {
        let apiRequest = APIRequest(baseUrl: .theSportsDB, path: .searchAllTeam, method: .get, query: query)
        let teamsResponse: TeamResponse = try await apiService.performRequest(apiRequest: apiRequest, retries: 3)
        return teamsResponse.teams.map { $0.toTeamEntity()}
    }
    
}
