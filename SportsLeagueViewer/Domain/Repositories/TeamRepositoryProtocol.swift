//
//  TeamRepositoryProtocol.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier MEITE on 21/10/2025.
//

protocol TeamRepositoryProtocol {
    func fetch(query: String) async throws -> [Team]
}
