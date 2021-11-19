//
//  URLSessionHTTPClientTests.swift
//  choco-testTests
//
//  Created by Val Atamanchuk on 14.11.21.
//

import Foundation
import XCTest
import choco_test

class URLSessionHTTPClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        MockURLProtocol.startInterceptingRequests()
    }
    
    override func tearDown() {
        super.tearDown()
        
        MockURLProtocol.stopInterceptingRequests()
    }
    
    func test_request_executesRequestWithGivenRequest() {
        let sut = makeSUT()
        let request = anyRequest()
        
        let expectation = expectation(description: "Wait for request to be returned")
        MockURLProtocol.observeRequests { interceptedRequest in
            XCTAssertEqual(request.url, interceptedRequest.url)
            XCTAssertEqual(request.httpMethod, interceptedRequest.httpMethod)
            expectation.fulfill()
        }
        
        sut.request(request) { _ in }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_request_returnsAnErrorOnUnexpectedResponse() {
        XCTAssertNotNil(getError(withData: nil, response: nil, error: nil))
        XCTAssertNotNil(getError(withData: nil, response: anyURLResponse(), error: nil))
        XCTAssertNotNil(getError(withData: anyData(), response: nil, error: nil))
        XCTAssertNotNil(getError(withData: anyData(), response: nil, error: anyError()))
        XCTAssertNotNil(getError(withData: nil, response: anyURLResponse(), error: anyError()))
        XCTAssertNotNil(getError(withData: nil, response: anyHTTPURLResponse(), error: anyError()))
        XCTAssertNotNil(getError(withData: anyData(), response: anyURLResponse(), error: anyError()))
        XCTAssertNotNil(getError(withData: anyData(), response: anyHTTPURLResponse(), error: anyError()))
        XCTAssertNotNil(getError(withData: anyData(), response: anyURLResponse(), error: nil))
    }
    
    func test_request_returnsSuccessOnEmptyDataWithHTTPURLResponse() {
        let data = Data()
        let httpURLResponse = anyHTTPURLResponse()
        
        let receivedValues = getSuccessValues(withData: nil, response: httpURLResponse, error: nil)
        XCTAssertEqual(receivedValues?.data, data)
        XCTAssertEqual(receivedValues?.response.statusCode, httpURLResponse.statusCode)
    }
    
    func test_request_returnsSuccessOnAnyDataWithHTTPURLResponse() {
        let data = anyData()
        let httpURLResponse = anyHTTPURLResponse()
        
        let receivedValues = getSuccessValues(withData: data, response: httpURLResponse, error: nil)
        XCTAssertEqual(receivedValues?.data, data)
        XCTAssertEqual(receivedValues?.response.statusCode, httpURLResponse.statusCode)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> URLSessionHTTPClient {
        return URLSessionHTTPClient()
    }
    
    private func anyRequest() -> URLRequest {
        let url = anyURL()
        return URLRequest(url: url)
    }
    
    private func getRequestForURL(_ url: URL) -> URLRequest {
        let request = URLRequest(url: url)
        return request
    }
    
    private func anyURLResponse() -> URLResponse {
        return URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }
    
    private func getResult(withData data: Data?, response: URLResponse?, error: Error?) -> HTTPClient.Result {
        let sut = makeSUT()
        let request = anyRequest()
        
        MockURLProtocol.stub(withData: data, response: response, error: error)
        
        let expectation = expectation(description: "Waiting for request to be finished")
        
        // swiftlint:disable:next implicitly_unwrapped_optional
        var requestResult: HTTPClient.Result!
        sut.request(request) { result in
            requestResult = result
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        return requestResult
    }
    
    private func getError(withData data: Data?, response: URLResponse?, error: Error?, file: StaticString = #file, line: UInt = #line) -> Error? {
        let result = getResult(withData: data, response: response, error: error)
        switch result {
        case let .failure(error):
            return error
        default:
            XCTFail("expected error got success response instead", file: file, line: line)
            return nil
        }
    }
    
    private func getSuccessValues(withData data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> (data: Data, response: HTTPURLResponse)? {
        let recievedResult = getResult(withData: data, response: response, error: nil)
        
        switch recievedResult {
        case let .success(values):
            return values
        case let .failure(error):
            XCTFail("Expected success values, got error insted \(error)", file: file, line: line)
            return nil
        }
    }
}
