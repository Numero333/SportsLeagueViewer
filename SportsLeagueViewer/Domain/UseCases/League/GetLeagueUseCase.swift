//
//  GetLeagueUseCase.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

class GetLeagueUseCase: GetLeagueUseCaseProtocol {
    
    // MARK: - Properties
    let leagueRepository: LeagueRepositoryProtocol
    
    // MARK: - Initializers
    init(leagueRepository: LeagueRepositoryProtocol = LeagueRepository()) {
        self.leagueRepository = leagueRepository
    }
    
    // MARK: - Accessible
    func execute() async throws -> [League] {
        return try await leagueRepository.fetch()
    }
}
