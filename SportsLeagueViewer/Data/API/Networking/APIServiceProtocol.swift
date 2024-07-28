//
//  APIServiceProtocol.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

protocol APIServiceProtocol {    
    func performRequest<T: Codable>(apiRequest: APIRequest, retries: Int) async throws -> T
}
