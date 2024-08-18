//
//  LeagueRepositoryMock.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation
import Network
@testable import SportsLeagueViewer

class LeagueRepositoryMock: LeagueRepositoryProtocol {
    
    // MARK: - Properties
    private let apiService: APIServiceProtocol
    
    // MARK: - Initializers
    init(apiService: APIServiceProtocol = APIServiceMock(ressources: .allLeagues)) {
        self.apiService = apiService
    }
    
    // MARK: - Accessible
    func fetch() async throws -> [SportsLeagueViewer.League] {
        let apiRequest = APIRequest(baseUrl: .theSportsDB, path: .allLeague, method: .get, query: nil)
        let leagues: LeagueResponse = try await apiService.performRequest(apiRequest: apiRequest, retries: 3)
        return leagues.leagues.map {
            LeagueMapper.map(dto: $0)
        }
    }
}
