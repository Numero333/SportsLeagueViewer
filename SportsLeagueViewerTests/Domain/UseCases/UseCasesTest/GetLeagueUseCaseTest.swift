//
//  GetLeagueUseCaseTest.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import XCTest
@testable import SportsLeagueViewer

class LeagueRepositoryTests: XCTestCase {
    
    // MARK: - Properties
    var leagueRepository: LeagueRepositoryProtocol!

    // MARK: - Override
    override func setUp() {
        super.setUp()
        leagueRepository = LeagueRepositoryMock()
    }
    
    // MARK: - Tests
    func testFetchReturnsLeagues() async throws {
        // When
        let leagues = try await leagueRepository.fetch()
        
        // Then
        XCTAssertEqual(leagues.count, 1089)  // Assuming .allLeagues JSON has 1 league
        XCTAssertEqual(leagues.first?.name, "English Premier League")  // Assuming .allLeagues JSON has "Premier League"
    }
}
