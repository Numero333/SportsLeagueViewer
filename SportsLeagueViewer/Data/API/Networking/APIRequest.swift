//
//  APIRequest.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 23/07/2024.
//

import Foundation

struct APIRequest {
    
    let baseUrl: BaseUrl
    let path: APIPath
    let method: HTTPMethod
    let query: String?
    
    func buildURL() -> URL? {
        var components = URLComponents(string: baseUrl.rawValue + APIKey.theSportDB + path.value)
        if let query = query {
            components?.queryItems = [
                URLQueryItem(name: "l", value: query)
            ]
        }
        return components?.url
    }
    
}


enum BaseUrl:String {
    case theSportsDB  = "https://www.thesportsdb.com/api/v1/json/"
}

enum APIPath {
    case allLeague, searchAllTeam
    
    var value: String {
        switch self {
        case .allLeague: "/all_leagues.php/"
        case .searchAllTeam: "/search_all_teams.php/"
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
