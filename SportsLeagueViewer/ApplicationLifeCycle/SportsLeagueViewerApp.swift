//
//  SportsLeagueViewerApp.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import SwiftUI

@main
struct SportsLeagueViewerApp: App {

    init() {
        DIContainer.shared.register(
            service: GetLeagueUseCase(),
            for: GetLeagueUseCaseProtocol.self
        )
        DIContainer.shared.register(
            service: GetTeamUseCase(),
            for: GetTeamUseCaseProtocol.self
        )
    }

    var body: some Scene {
        WindowGroup {
            SearchLeagueView()
        }
    }
}
