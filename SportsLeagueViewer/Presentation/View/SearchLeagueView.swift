//
//  SearchLeagueView.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import SwiftUI

struct SearchLeagueView: View {

    // MARK: - Properties
    @ObservedObject var viewModel = SearchLeagueViewModel()

    // MARK: - Main View
    var body: some View {
        NavigationStack {
            ZStack {

                if !viewModel.teams.isEmpty {
                    TeamGridView(teams: viewModel.teams)
                }

                LeagueSelectionView(leagues: viewModel.leaguesResearched, action: viewModel.fetchTeam(for:))
                    .searchable(text: $viewModel.searchLeague, prompt: "Search by league")
            }
            .onAppear {
                viewModel.initializeLeagues()
            }
            .navigationTitle("Search League")
            .onChange(of: viewModel.errorMessage) {
                if viewModel.errorMessage?.description != nil {
                    viewModel.showAlert.toggle()
                }
            }
            .alert("Error",
                   isPresented: $viewModel.showAlert) {
                Button("OK") {
                    viewModel.showAlert.toggle()
                }
            } message: {
                Text(viewModel.errorMessage?.description ?? "Unknown error please try again")
            }
        }
    }
}

#Preview {
    SearchLeagueView()
}

// MARK: - Subviews - LeagueSelectionView
struct LeagueSelectionView: View {

    // Environment property to detect if the user is currently performing a search
    @Environment(\.isSearching) private var isSearching
    // Environment property to dismiss the keyboard after the user selects a league
    @Environment(\.dismissSearch) private var dismissSearch

    let leagues: [League]

    var action: (String) -> Void

    var body: some View {
        if isSearching {
            List(leagues, id: \.id) { league in
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

// MARK: - Subviews - TeamGridView
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
