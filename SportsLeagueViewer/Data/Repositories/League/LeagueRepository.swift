//
//  LeagueRepository.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

class LeagueRepository: LeagueRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetch() async throws -> [League] {
        let apiRequest = APIRequest(baseUrl: .theSportsDB, path: .allLeague, method: .get, query: nil)
        let leagues: LeagueResponse = try await apiService.performRequest(apiRequest: apiRequest, retries: 3)
        return leagues.leagues.map { $0.toLeagueEntity()}
    }
    
}
