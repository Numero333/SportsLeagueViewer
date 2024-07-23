//
//  GetLeagueUseCaseProtocol.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

protocol GetLeagueUseCaseProtocol {
    func execute() async throws -> [League]
}
