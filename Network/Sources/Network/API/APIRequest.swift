//
//  APIRequest.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

public struct APIRequest {
    
    // MARK: - Properties
    let baseUrl: BaseUrl
    let path: APIPath
    let method: HTTPMethod
    let query: String?

    public init(baseUrl: BaseUrl, path: APIPath, method: HTTPMethod, query: String?) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.query = query
    }

    // MARK: - Accessible
    public func buildURL() -> URL? {
        var components = URLComponents(string: baseUrl.rawValue + APIKey.theSportDB + path.value)
        if let query = query {
            components?.queryItems = [
                URLQueryItem(name: "l", value: query)
            ]
        }
        return components?.url
    }
    
}

public enum BaseUrl:String {
    case theSportsDB  = "https://www.thesportsdb.com/api/v1/json/"
}

public enum APIPath {
    case allLeague, searchAllTeam
    
    var value: String {
        switch self {
        case .allLeague: "/all_leagues.php/"
        case .searchAllTeam: "/search_all_teams.php/"
        }
    }
}

public enum HTTPMethod: String {
    case get = "GET"
}
