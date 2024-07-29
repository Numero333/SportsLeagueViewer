//
//  GetTeamUseCaseTest.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import XCTest
@testable import SportsLeagueViewer

class GetTeamUseCaseTest: XCTestCase {
    
    // MARK: - Properties
    var teamRepository: TeamRepositoryProtocol!

    // MARK: - Override
    override func setUp() {
        super.setUp()
        teamRepository = TeamRepositoryMock()
    }
    
    // MARK: - Tests
    func testFetchReturnsTeams() async throws {
        // When
        let teams = try await teamRepository.fetch(query: "French Ligue 1")
        
        // Then
        XCTAssertEqual(teams.count, 18)  // Assuming .allLeagues JSON has 1 league
        XCTAssertEqual(teams.first?.name, "Angers")  // Assuming .allLeagues JSON has "Premier League"
    }
}
