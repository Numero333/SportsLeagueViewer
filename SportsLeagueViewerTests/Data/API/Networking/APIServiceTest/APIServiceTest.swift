//
//  APIServiceTest.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import XCTest
@testable import SportsLeagueViewer

#warning("Switch les prrivate pour un setUp et tearDown")
#warning("Conteneur d'injection de dépendance")

class APIServiceTest: XCTestCase {

    // MARK: - Properties
    private var session: URLSession!

    private var data: Data!

    // MARK: - Override
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [FakeURLSessionProtocol.self]
        self.session = URLSession(configuration: configuration)

        let bundle = Bundle(for: APIServiceTest.self)
        let url = bundle.url(forResource: "AllLeagues", withExtension: "json")
        self.data = try! Data(contentsOf: url!)
    }

    override func tearDown() {
        session = nil
        data = nil
    }

    
    private var url: URL! =  URL(string: "test.com")
    
    // MARK: - Tests
    func testAPIRequestWithCorrectResponse() async throws {
    
        // Given
        FakeURLSessionProtocol.loadingData = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, self.data)
        }
        
        let apiService = APIService(urlSession: session)
        
        // When
        do {
            let _ : LeagueResponse = try await apiService.performRequest(
                apiRequest: APIRequest(
                    baseUrl: .theSportsDB,
                    path: .allLeague,
                    method: .get,
                    query: nil
                )
            )
        } catch {
            XCTFail()
        }
                
    }
    
    func testAPIRequestWithUncorrectResponse() async {
        
        // Given
        FakeURLSessionProtocol.loadingData = {
            let response = HTTPURLResponse(url: self.url, statusCode: 500, httpVersion: nil, headerFields: nil)
            return (response!, self.data)
        }
        
        let apiService = APIService(urlSession: session)
        
        // When
        do {
            let _ : LeagueResponse = try await apiService.performRequest(
                apiRequest: APIRequest(
                    baseUrl: .theSportsDB,
                    path: .allLeague,
                    method: .get,
                    query: nil
                ), retries: 1
            )
            XCTFail()
        } catch {
            XCTAssertEqual(APIError.invalidResponse(500), error as? APIError)
        }
    }
    
    func testAPIRequestWithCorrectData() async {
        
        // Given
        FakeURLSessionProtocol.loadingData = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, self.data)
        }
        
        let apiService = APIService(urlSession: session)
        
        // When
        do {
            let leagues: LeagueResponse = try await apiService.performRequest(
                apiRequest: APIRequest(
                    baseUrl: .theSportsDB,
                    path: .allLeague,
                    method: .get,
                    query: nil
                ), retries: 1
            )
            XCTAssertNotNil(leagues)
        } catch {
           XCTFail()
        }
    }
    
    func testAPIRequestWithUncorrectData() async {
        
        // Given
        data = "fake data".data(using: .utf8)
        
        FakeURLSessionProtocol.loadingData = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, self.data)
        }
        
        let apiService = APIService(urlSession: session)
        
        // When
        do {
            let _ : LeagueResponse = try await apiService.performRequest(
                apiRequest: APIRequest(
                    baseUrl: .theSportsDB,
                    path: .allLeague,
                    method: .get,
                    query: "Fake"
                ), retries: 1
            )
            XCTFail()
        } catch {
            XCTAssertEqual(APIError.parsingError, error as? APIError)
        }
    }
}
