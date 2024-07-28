//
//  SearchLeagueViewModelTest.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import XCTest
@testable import SportsLeagueViewer

final class SearchLeagueViewModelTest: XCTestCase {
    
    private var getLeagueUseCase: GetLeagueUseCaseMock!
    private var getTeamsUseCase: GetTeamUseCaseMock!
    private var viewModel: SearchLeagueViewModel!
    
    override func setUp() {
        super.setUp()
        self.getLeagueUseCase = GetLeagueUseCaseMock()
        self.getTeamsUseCase = GetTeamUseCaseMock()
        self.viewModel = SearchLeagueViewModel(getLeagueUseCase: getLeagueUseCase, getTeamUseCase: getTeamsUseCase)
    }
    
    
    func testFetchingBaseLeagues() async {
        let expectation = expectation(description: "Fetch League should complete")
        
        // When
        Task {
            await viewModel.initializeLeagues()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5)
        
        // Then
        XCTAssertEqual("English Premier League", viewModel.baseLeagues.first!.name)
        XCTAssertNotNil(viewModel.baseLeagues)
        
    }
    
    func testFetchTeams() async {
        let expectation = expectation(description: "Fetch Team should complete")
        
        // When
        Task {
            await viewModel.fetchTeam(for: "French Ligue 1")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5)
        
        // Then
        XCTAssertEqual("Angers", viewModel.teams.last!.name)
        
    }
    
}
