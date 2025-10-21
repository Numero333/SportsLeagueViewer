//
//  LeagueRepository.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation
import Network

final class LeagueRepository: LeagueRepositoryProtocol {
    
    // MARK: - Properties
    private let apiService: APIServiceProtocol
    
    // MARK: - Initializers
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    // MARK: - Accessible
    func fetch() async throws -> [League] {
        let apiRequest = APIRequest(baseUrl: .theSportsDB, path: .allLeague, method: .get, query: nil)
        let leagues: LeagueResponse = try await apiService.performRequest(apiRequest: apiRequest, retries: 3)
        return leagues.leagues.map {
            LeagueMapper.map(dto: $0)
        }
    }
    
}
