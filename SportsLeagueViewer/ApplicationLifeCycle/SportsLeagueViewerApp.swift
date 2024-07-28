//
//  SportsLeagueViewerApp.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import SwiftUI

@main
struct SportsLeagueViewerApp: App {
    
    @StateObject var searchLeagueViewModel = AppDI.shared.createSearchLeagueViewModel()
    
    var body: some Scene {
        WindowGroup {
            SearchLeagueView(viewModel: searchLeagueViewModel)
        }
    }
}
