//
//  GetLeagueUseCase.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

class GetLeagueUseCase: GetLeagueUseCaseProtocol {
    
    let leagueRepository: LeagueRepositoryProtocol
    
    init(leagueRepository: LeagueRepositoryProtocol = LeagueRepository()) {
        self.leagueRepository = leagueRepository
    }
    
    func execute() async throws -> [League] {
        return try await leagueRepository.fetch()
    }
}
