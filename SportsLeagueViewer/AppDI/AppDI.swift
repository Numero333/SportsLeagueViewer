//
//  AppDI.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation

protocol AppDIProtocol {
    func createSearchLeagueViewModel() -> SearchLeagueViewModel
}

class AppDI: AppDIProtocol {
    
    static let shared = AppDI()
    
    func createSearchLeagueViewModel() -> SearchLeagueViewModel {
        let viewModel = SearchLeagueViewModel(
            getLeagueUseCase: GetLeagueUseCase(),
            getTeamUseCase: GetTeamUseCase()
        )
        return viewModel
    }
}
