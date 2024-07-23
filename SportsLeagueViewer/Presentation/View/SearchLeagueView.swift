//
//  SearchLeagueView.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import SwiftUI

struct SearchLeagueView: View {
    
    @ObservedObject var viewModel: SearchLeagueViewModel
    
    @Environment(\.dismissSearch) private var dismissSearch
    @Environment(\.isSearching) private var isSearching
    
    init() {
        let apiService = APIService()
        let leagueRepository = LeagueRepository(apiService: apiService)
        let teamRepository = TeamRepository(apiService: APIService())
        let getLeagueUseCase = GetLeagueUseCase(leagueRepository: leagueRepository)
        let getTeamUseCase = GetTeamUseCase(teamRepository: teamRepository)
        
        self.viewModel = SearchLeagueViewModel(getLeagueUseCase: getLeagueUseCase, getTeamUseCase: getTeamUseCase)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                if !viewModel.teams.isEmpty {
                    TeamGridView(teams: viewModel.teams)
                }
                
                LeagueSearchView(leagues: viewModel.leaguesResearch, action: viewModel.fetchTeam(for:))
                    .searchable(text: $viewModel.searchLeague, prompt: "Search by league")
            }
            .onAppear {
                viewModel.initializeLeagues()
            }
            .navigationTitle("Search League")
        }
    }
}

#Preview {
    SearchLeagueView()
}

struct LeagueSearchView: View {
    
    // Environment property to detect if the user is currently performing a search
    @Environment(\.isSearching) private var isSearching
    // Environment property to dismiss the keyboard after the user selects a league
    @Environment(\.dismissSearch) private var dismissSearch
    
    let leagues: [League]
    
    var action: (String) -> Void
    
    var body: some View {
        if isSearching {
            List(leagues, id: \.name) { league in
                Button {
                    action(league.name)
                    dismissSearch()
                } label: {
                    Text(league.name)
                }
            }
        }
    }
}

struct TeamGridView: View {
    
    let teams: [Team]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(teams, id: \.id) { team in
                    
                    AsyncImage(url: URL(string: team.badge)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                        Text(team.name)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
