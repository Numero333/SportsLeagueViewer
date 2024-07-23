//
//  APIServiceProtocol.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

protocol APIServiceProtocol {
    var urlSession: URLSession { get }
    
    func performRequest<T: Codable>(apiRequest: APIRequest, retries: Int) async throws -> T
}
