//
//  GetLeagueUseCaseMock.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation
@testable import SportsLeagueViewer

class GetLeagueUseCaseMock: GetLeagueUseCaseProtocol {
    
    // MARK: - Properties
    let leagueRepository: LeagueRepositoryProtocol
    
    // MARK: - Initializers
    init(leagueRepository: LeagueRepositoryProtocol = LeagueRepositoryMock()) {
        self.leagueRepository = leagueRepository
    }
    
    // MARK: - Accessible
    func execute() async throws -> [SportsLeagueViewer.League] {
        return try await leagueRepository.fetch()
    }
}
