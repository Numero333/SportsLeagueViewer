//
//  FakeURLSessionProtocol.swift
//  SportsLeagueViewerTests
//
//  Created by François-Xavier on 28/07/2024.
//

import Foundation

public class FakeURLSessionProtocol: URLProtocol {

    static var loadingData: (() -> (HTTPURLResponse?, Data?))?
    
    override public class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override public class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override public func startLoading() {
        let handler = FakeURLSessionProtocol.loadingData!
        let (response, data) = handler()
        
        guard let response = response else {
            client?.urlProtocolDidFinishLoading(self)
            return
        }
        
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override public func stopLoading() {
        
    }
    
}
