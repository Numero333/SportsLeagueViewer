//
//  APIError.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

enum APIError: Error, Equatable {
    case invalidUrl
    case invalidResponse(Int)
    case parsingError
    case unknownError
    
    var description: String {
        switch self {
        case .invalidUrl: return "The URL is invalid."
        case .invalidResponse(let statusCode): return "Response invalid, status code: \(statusCode)"
        case .parsingError: return "Failed to parse the received data."
        case .unknownError: return "An unknown error occurred."
        }
    }
}
