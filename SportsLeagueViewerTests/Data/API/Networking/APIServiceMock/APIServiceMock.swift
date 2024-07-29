//
//  APIServiceMock.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation
@testable import SportsLeagueViewer

enum MockRessources {
    case allLeagues, allTeams
    
    var description: String {
        switch self {
        case .allLeagues:
            "AllLeagues"
        case .allTeams:
            "AllTeams"
        }
    }
}

class APIServiceMock: APIServiceProtocol {
    
    // MARK: - Properties
    var ressources: MockRessources
    
    // MARK: - Initializers
    init(ressources: MockRessources) {
        self.ressources = ressources
    }
    
    // MARK: - Accessible
    func performRequest<T>(apiRequest: SportsLeagueViewer.APIRequest, retries: Int) async throws -> T where T : Decodable, T : Encodable {
        
        let bundle = Bundle(for: APIServiceTest.self)
        let url = bundle.url(forResource: ressources.description, withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
    
    
}
