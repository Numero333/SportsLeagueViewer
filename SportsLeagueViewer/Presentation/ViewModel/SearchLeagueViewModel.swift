//
//  SearchLeagueViewModel.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

class SearchLeagueViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var searchLeague = ""
    @Published var baseLeagues = [League]()
    @Published var teams = [Team]()
    @Published var errorMessage: APIError?
    @Published var showAlert = false
    
    let getLeagueUseCase: GetLeagueUseCaseProtocol
    let getTeamUseCase: GetTeamUseCaseProtocol
    
    var leaguesResearched: [League] {
        return baseLeagues.filter { league in
            league.name.lowercased().contains(searchLeague.lowercased())
        }
    }
    
    init(getLeagueUseCase: GetLeagueUseCaseProtocol, getTeamUseCase: GetTeamUseCaseProtocol) {
        self.getLeagueUseCase = getLeagueUseCase
        self.getTeamUseCase = getTeamUseCase
    }
    
    @MainActor
    func initializeLeagues() {
        Task {
            do {
                self.baseLeagues = try await getLeagueUseCase.execute()
            } catch let error {
                self.errorMessage = error as? APIError
            }
        }
    }
    
    @MainActor
    func fetchTeam(for league: String) {
        Task {
            do {
                let fetchedTeams = try await getTeamUseCase.execute(query: league)
                self.teams = sorting(for: fetchedTeams)
            } catch {
                self.errorMessage = error as? APIError
            }
        }
    }
    
    private func sorting(for teams: [Team]) -> [Team] {
        let filteredTeams = filterOneInTwoTeam(for: teams)
        return reverseAlphabeticalOrder(for: filteredTeams)
    }
    
    private func reverseAlphabeticalOrder(for teams: [Team]) -> [Team] {
        return teams.sorted(by: { $0.name > $1.name })
    }
    
    private func filterOneInTwoTeam(for teams: [Team]) -> [Team] {
        return stride(from: 0, to: teams.count, by: 2).map { teams[$0] }
    }
}
