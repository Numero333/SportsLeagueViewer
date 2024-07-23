//
//  APIService.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

final class APIService: APIServiceProtocol {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func performRequest<T: Codable>(apiRequest: APIRequest, retries: Int = 3) async throws -> T {
                
        guard let url = apiRequest.buildURL() else { throw APIError.invalidUrl }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.method.rawValue
                
        do {
            let (data, response) = try await urlSession.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknownError
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse(httpResponse.statusCode)
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                print("error parsing data")
                throw APIError.parsingError
            }
        } catch {
            if retries > 0 {
                try await Task.sleep(nanoseconds: 1_000_000_000)
                return try await performRequest(apiRequest: apiRequest, retries: retries - 1)
            } else {
                throw APIError.unknownError
            }
        }
    }
}
