//
//  LeagueRepositoryMock.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation
@testable import SportsLeagueViewer

class LeagueRepositoryMock: LeagueRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIServiceMock(ressources: .allLeagues)) {
        self.apiService = apiService
    }
    
    func fetch() async throws -> [SportsLeagueViewer.League] {
        let apiRequest = APIRequest(baseUrl: .theSportsDB, path: .allLeague, method: .get, query: nil)
        let leagues: LeagueResponse = try await apiService.performRequest(apiRequest: apiRequest, retries: 3)
        return leagues.leagues.map {
            LeagueMapper.map(dto: $0)
        }
    }
}
