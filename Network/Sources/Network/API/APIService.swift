//
//  APIService.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

public protocol APIServiceProtocol {
    func performRequest<T: Decodable>(apiRequest: APIRequest, retries: Int) async throws -> T
}

public final class APIService: APIServiceProtocol {

    // MARK: - Properties
    public let urlSession: URLSession

    // MARK: - Properties
    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - Accessible
    public func performRequest<T: Decodable>(apiRequest: APIRequest, retries: Int = 3) async throws -> T {

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
                throw APIError.parsingError
            }
        } catch {
            if retries > 0 {
                await delay(seconds: 1)
                return try await performRequest(apiRequest: apiRequest, retries: retries - 1)
                
            } else {
                throw error
            }
        }
    }
    
    private func delay(seconds: TimeInterval) async {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + seconds) {
                continuation.resume()
            }
        }
    }
    
}
