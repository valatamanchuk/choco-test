//
//  NetworkResponse.swift
//  choco-test
//
//  Created by Val Atamanchuk on 16.11.21.
//

import Foundation

public struct NetworkResponse<T> {
    public typealias Result = Swift.Result<(T), Error>
    
    public let request: NetworkRequest
    public let urlResponse: URLResponse?
    public let result: Result
    public init(request: NetworkRequest, urlResponse: URLResponse?, result: Result) {
        self.request = request
        self.urlResponse = urlResponse
        self.result = result
    }
}
