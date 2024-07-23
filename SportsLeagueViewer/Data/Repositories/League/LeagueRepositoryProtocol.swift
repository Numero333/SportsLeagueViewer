//
//  LeagueRepositoryProtocol.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

protocol LeagueRepositoryProtocol {
    func fetch() async throws -> [League]
}
