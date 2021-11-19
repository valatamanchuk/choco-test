//
//  ObjectConstructibleNetworkResponseTests.swift
//  choco-testTests
//
//  Created by Val Atamanchuk on 16.11.21.
//

import Foundation
import XCTest
import choco_test

class ObjectConstructibleNetworkResponseTests: XCTestCase {
    
    func test_requestAndConstruct_completesWithSuccessAndExpectedObject() {
        addTeardownBlock {
            MockURLProtocol.stopInterceptingRequests()
        }
        
        MockURLProtocol.startInterceptingRequests()
        
        let sut = TestObjectRequest(withNetworkRequest: anyTestNetworkRequest())
        let expectedObject = TestObject(id: "1", title: "firstTitle", price: 333)
        let expectedObjectData = try? JSONEncoder().encode(expectedObject)
        
        MockURLProtocol.stub(withData: expectedObjectData, response: anyHTTPURLResponse(), error: nil)
        
        let expectation = expectation(description: "Waiting for request to finish")
        sut.requestAndConstruct { response in
            if let responseObject = try? response.result.get() {
                XCTAssertEqual(responseObject, expectedObject)
            } else {
                XCTFail("Expected object in response, got failure instead")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_requestAndConstruct_completesWithSuccessAndExpectedObjectArray() {
        addTeardownBlock {
            MockURLProtocol.stopInterceptingRequests()
        }
        
        MockURLProtocol.startInterceptingRequests()
        
        let sut = TestObjectArrayRequest(withNetworkRequest: anyTestNetworkRequest())
        let expectedObject1 = TestObject(id: "1", title: "firstTitle", price: 333)
        let expectedObject2 = TestObject(id: "2", title: "secondTitle", price: 444)
        let expectedObject3 = TestObject(id: "3", title: "thirdTitle", price: 222)
        let expectedObjectArray = [expectedObject1, expectedObject2, expectedObject3]
        let expectedObjectArrayData = try? JSONEncoder().encode(expectedObjectArray)
        
        MockURLProtocol.stub(withData: expectedObjectArrayData, response: anyHTTPURLResponse(), error: nil)
        
        let expectation = expectation(description: "Waiting for request to finish")
        sut.requestAndConstruct { response in
            if let responseObject = try? response.result.get() {
                XCTAssertEqual(responseObject, expectedObjectArray)
            } else {
                XCTFail("Expected object in response, got failure instead")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}

private struct TestObject: Codable, Equatable {
    let id: String
    let title: String
    let price: Int
}

private struct TestObjectRequest: NetworkRequest, ObjectConstructibleNetworkResponse {
    typealias Object = TestObject
    
    var urlScheme: String = ""
    var urlHost: String = ""
    var urlPath: String = ""
    var httpMethod: HTTPMethod = .get
    var headers: [String: String] = [:]
    var urlParameters: [String: CustomStringConvertible] = [:]
    var bodyParameters: [String: Any] = [:]
    init(withNetworkRequest request: NetworkRequest) {
        urlScheme = request.urlScheme
        urlHost = request.urlHost
        urlPath = request.urlPath
        httpMethod = request.httpMethod
        headers = request.headers
        urlParameters = request.urlParameters
        bodyParameters = request.bodyParameters
    }
}

private struct TestObjectArrayRequest: NetworkRequest, ObjectConstructibleNetworkResponse {
    typealias Object = [TestObject]
    
    var urlScheme: String = ""
    var urlHost: String = ""
    var urlPath: String = ""
    var httpMethod: HTTPMethod = .get
    var headers: [String: String] = [:]
    var urlParameters: [String: CustomStringConvertible] = [:]
    var bodyParameters: [String: Any] = [:]
    init(withNetworkRequest request: NetworkRequest) {
        urlScheme = request.urlScheme
        urlHost = request.urlHost
        urlPath = request.urlPath
        httpMethod = request.httpMethod
        headers = request.headers
        urlParameters = request.urlParameters
        bodyParameters = request.bodyParameters
    }
}
