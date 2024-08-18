//
//  APIServiceMock.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation

public enum MockRessources {
    case allLeagues, allTeams
    
    public var description: String {
        switch self {
        case .allLeagues:
            "AllLeagues"
        case .allTeams:
            "AllTeams"
        }
    }
}

public class APIServiceMock: APIServiceProtocol {

    // MARK: - Properties
    var ressources: MockRessources
    
    // MARK: - Initializers
    public init(ressources: MockRessources) {
        self.ressources = ressources
    }
    
    // MARK: - Accessible
    public func performRequest<T>(apiRequest: APIRequest, retries: Int) async throws -> T where T : Decodable {

        let bundle = Bundle.module
        let url = bundle.url(forResource: ressources.description, withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
