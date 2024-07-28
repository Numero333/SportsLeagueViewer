//
//  GetLeagueUseCaseMock.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation
@testable import SportsLeagueViewer

class GetLeagueUseCaseMock: GetLeagueUseCaseProtocol {
    
    let leagueRepository: LeagueRepositoryProtocol
    
    init(leagueRepository: LeagueRepositoryProtocol = LeagueRepositoryMock()) {
        self.leagueRepository = leagueRepository
    }
    
    func execute() async throws -> [SportsLeagueViewer.League] {
        return try await leagueRepository.fetch()
    }
    
}
