//
//  MockURLProtocol.swift
//  choco-testTests
//
//  Created by Val Atamanchuk on 16.11.21.
//

import Foundation

class MockURLProtocol: URLProtocol {
    typealias RequestObserver = ((URLRequest) -> Void)
    private struct StubData {
        let data: Data?
        let response: URLResponse?
        let error: Error?
    }
    
    private static var stubData: StubData?
    private static var requestObserver: RequestObserver?
        
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let requestObserver = MockURLProtocol.requestObserver {
            client?.urlProtocolDidFinishLoading(self)
            requestObserver(request)
            return
        }
        
        if let data = MockURLProtocol.stubData?.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = MockURLProtocol.stubData?.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = MockURLProtocol.stubData?.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
    
    static func startInterceptingRequests() {
        URLProtocol.registerClass(MockURLProtocol.self)
    }
    
    static func stopInterceptingRequests() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        stubData = nil
        requestObserver = nil
    }
    
    static func stub(withData data: Data?, response: URLResponse?, error: Error?) {
        stubData = StubData(data: data, response: response, error: error)
    }
    
    static func observeRequests(withObserver observer: @escaping RequestObserver) {
        requestObserver = observer
    }
}
