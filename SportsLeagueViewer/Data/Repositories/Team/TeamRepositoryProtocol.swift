//
//  TeamRepositoryProtocol.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

protocol TeamRepositoryProtocol {
    func fetch(query: String) async throws -> [Team]
}
