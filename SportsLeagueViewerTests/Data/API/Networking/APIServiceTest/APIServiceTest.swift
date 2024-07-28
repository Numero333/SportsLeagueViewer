//
//  APIServiceTest.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import XCTest
@testable import SportsLeagueViewer

class APIServiceTest: XCTestCase {
    
    private var session: URLSession! = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [FakeURLSessionProtocol.self]
        return URLSession(configuration: configuration)
    }()
    
    private var data: Data! = {
        let bundle = Bundle(for: APIServiceTest.self)
        let url = bundle.url(forResource: "AllLeagues", withExtension: "json")
        return try! Data(contentsOf: url!)
    }()
    
    
    private var url: URL! =  URL(string: "test.com")
    
    func testAPIRequestWithCorrectResponse() async throws {
    
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
            let leagues: LeagueResponse = try await apiService.performRequest(
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
            let leagues: LeagueResponse = try await apiService.performRequest(
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
    
    func testAPIError() {
        // Given
        let invalidUrl = APIError.invalidUrl.description
        let invalidResponse = APIError.invalidResponse(500).description
        let parsingError = APIError.parsingError.description
        let unknownError = APIError.unknownError.description
        
        // Then
        XCTAssertEqual("The URL is invalid.", invalidUrl)
        XCTAssertEqual("Response invalid, status code: 500", invalidResponse)
        XCTAssertEqual("Failed to parse the received data.", parsingError)
        XCTAssertEqual("An unknown error occurred.", unknownError)
    }
    
}
