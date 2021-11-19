//
//  NetworkingTests+Additions.swift
//  choco-testTests
//
//  Created by Val Atamanchuk on 16.11.21.
//

import Foundation
import choco_test

private enum Constants {
    static let urlScheme: String = "https"
    static let urlHost: String = "test-host.com"
    static let urlPath: String = "/path"
    static let httpMethod: HTTPMethod = HTTPMethod.get
    static let urlParameters: [String: CustomStringConvertible] = [
        "firstKey": 1,
        "secondKey": "value",
        "thirdKey": true
    ]
    
    static let bodyParameters: [String: Any] = [
        "email": "email@email.com",
        "password": "pass123",
        "savePassword": true
    ]
    
    static let headers: [String: String] = [
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
}

// MARK: - Shared Helpers

func anyURL() -> URL {
    // swiftlint:disable:next force_unwrapping
    return URL(string: "https://any-given-url.com")!
}

func anyData() -> Data {
    return Data("any-given-data".utf8)
}

func anyHTTPURLResponse() -> HTTPURLResponse {
    return HTTPURLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
}

func anyError() -> NSError {
    return NSError(domain: "", code: -11)
}

func anyTestNetworkRequest(withHTTPMethod httpMethod: HTTPMethod = Constants.httpMethod, withURLParameters: Bool = false, withBodyParameters: Bool = false) -> TestNetworkRequest {
    let urlParameters = withURLParameters ? Constants.urlParameters : [:]
    let bodyParameters = withBodyParameters ? Constants.bodyParameters : [:]
    return TestNetworkRequest(urlScheme: Constants.urlScheme, urlHost: Constants.urlHost, urlPath: Constants.urlPath, httpMethod: httpMethod, urlParameters: urlParameters, headers: Constants.headers, bodyParameters: bodyParameters)
}
