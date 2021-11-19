//
//  NetworkRequestTests.swift
//  choco-testTests
//
//  Created by Val Atamanchuk on 16.11.21.
//

import Foundation
import XCTest
import choco_test

class NetworkRequestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_constructedURL_constructsExpectedURLWithoutURLParameters() {
        let sut = makeSUT(withURLParameters: false)
        
        XCTAssertEqual(sut.constructedURL.scheme, sut.urlScheme)
        XCTAssertEqual(sut.constructedURL.host, sut.urlHost)
        XCTAssertEqual(sut.constructedURL.path, sut.urlPath)
        XCTAssertEqual(sut.urlParameters.count, 0)
    }
    
    func test_constructedURL_constructsExpectedURLWithURLParameters() {
        let sut = makeSUT(withURLParameters: true)
        
        XCTAssertEqual(sut.constructedURL.scheme, sut.urlScheme)
        XCTAssertEqual(sut.constructedURL.host, sut.urlHost)
        XCTAssertEqual(sut.constructedURL.path, sut.urlPath)
        XCTAssertEqual(sut.urlParameters.count, sut.urlParameters.count)
    }
    
    func test_urlRequest_usesConstructedURLasURL() {
        let sut = makeSUT(withURLParameters: true)
        
        XCTAssertEqual(sut.urlRequest.url, sut.constructedURL)
    }
    
    func test_urlRequest_usesExpectedHTTPMethod() {
        let sut = makeSUT(withMethod: .post)
        
        XCTAssertEqual(sut.urlRequest.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func test_urlRequest_usesHeaders() {
        let sut = makeSUT()
        XCTAssertEqual(sut.urlRequest.allHTTPHeaderFields, sut.headers)
    }
    
    func test_urlRequest_usesBodyParameters() {
        let sut = makeSUT(withBodyParameters: true)
        
        if let extectedJSONSerializedData = try? JSONSerialization.data(withJSONObject: sut.bodyParameters, options: []) {
            XCTAssertEqual(sut.urlRequest.httpBody, extectedJSONSerializedData)
        } else {
            XCTFail("bodyParameters could not be serialized")
        }
    }
    
    func test_requestAndConstructOnBackgroundThread_completesWithSuccessNetworkResponseOnSuccessHTTPClientResponse() {
        addTeardownBlock {
            MockURLProtocol.stopInterceptingRequests()
        }
        
        MockURLProtocol.startInterceptingRequests()
        
        let sut = makeSUT()
        let expectedData = anyData()
        let expectedHTTPURLResponse = anyHTTPURLResponse()
        
        MockURLProtocol.stub(withData: expectedData, response: expectedHTTPURLResponse, error: nil)
        
        let expectation = expectation(description: "Waiting for request to finish")
        sut.requestAndConstructOnBackgroundThread { response in
            switch response.result {
            case let .success(responseData):
                XCTAssertEqual(responseData, expectedData)
            case let .failure(error):
                XCTFail("Expected success, got \(error) instead")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_requestAndConstructOnBackgroundThread_completesWithFailureNetworkResponseOnFailureHTTPClientResponse() {
        addTeardownBlock {
            MockURLProtocol.stopInterceptingRequests()
        }
        
        MockURLProtocol.startInterceptingRequests()
        
        let sut = makeSUT()
        
        MockURLProtocol.stub(withData: nil, response: nil, error: anyError())
        
        let expectation = expectation(description: "Waiting for request to finish")
        sut.requestAndConstructOnBackgroundThread { response in
            guard case .failure = response.result else {
                XCTFail("Expected error got success instead")
                expectation.fulfill()
                return
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(withMethod method: HTTPMethod = .get, withURLParameters: Bool = false, withBodyParameters: Bool = false) -> TestNetworkRequest {
        return anyTestNetworkRequest(withHTTPMethod: method, withURLParameters: withURLParameters, withBodyParameters: withBodyParameters)
    }
}
