//
//  TeamRepository.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation
import Network

protocol TeamRepositoryProtocol {
    func fetch(query: String) async throws -> [Team]
}

final class TeamRepository: TeamRepositoryProtocol {

    // MARK: - Properties
    private let apiService: APIServiceProtocol
    
    // MARK: - Initializers
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    // MARK: - Accessible
    func fetch(query: String) async throws -> [Team] {
        let apiRequest = APIRequest(baseUrl: .theSportsDB, path: .searchAllTeam, method: .get, query: query)
        let teamsResponse: TeamResponse = try await apiService.performRequest(apiRequest: apiRequest, retries: 3)
        return teamsResponse.teams.map {
            TeamMapper.map(dto: $0)
        }
    }
    
}
