//
//  URLSessionHTTPClient.swift
//  choco-test
//
//  Created by Val Atamanchuk on 15.11.21.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    private struct UnexpectedValuesError: Error {}
    
    private let urlSession: URLSession
    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    public func request(_ networkRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) {
        urlSession.dataTask(with: networkRequest) { data, response, error in
            completion(Result {
                if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else if let error = error {
                    throw error
                }
                
                throw UnexpectedValuesError()
            })
        }.resume()
    }
}
