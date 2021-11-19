//
//  TestNetworkRequest.swift
//  choco-testTests
//
//  Created by Val Atamanchuk on 16.11.21.
//

import Foundation
import choco_test

struct TestNetworkRequest: NetworkRequest {
    let urlScheme: String
    let urlHost: String
    let urlPath: String
    let httpMethod: HTTPMethod
    let urlParameters: [String: CustomStringConvertible]
    let headers: [String: String]
    var bodyParameters: [String: Any]
    init(urlScheme: String, urlHost: String, urlPath: String, httpMethod: HTTPMethod, urlParameters: [String: CustomStringConvertible] = [:], headers: [String: String] = [:], bodyParameters: [String: Any] = [:]) {
        self.urlScheme = urlScheme
        self.urlHost = urlHost
        self.urlPath = urlPath
        self.httpMethod = httpMethod
        self.urlParameters = urlParameters
        self.headers = headers
        self.bodyParameters = bodyParameters
    }
}
