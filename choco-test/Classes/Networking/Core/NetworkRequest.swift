//
//  NetworkRequest.swift
//  choco-test
//
//  Created by Val Atamanchuk on 16.11.21.
//

import Foundation

public protocol NetworkRequest {
    var urlScheme: String { get }
    var urlHost: String { get }
    var urlPath: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var urlParameters: [String: CustomStringConvertible] { get }
    var bodyParameters: [String: Any] { get }
}

extension NetworkRequest {
    var headers: [String: String] {
        return [:]
    }
    
    var urlParameters: [String: CustomStringConvertible] {
        return [:]
    }
    
    var bodyParameters: [String: Any] {
        return [:]
    }
}

public extension NetworkRequest {
    var constructedURL: URL {
        var components = URLComponents()
        components.scheme = urlScheme
        components.host = urlHost
        components.path = urlPath
        
        if !urlParameters.keys.isEmpty {
            components.queryItems = urlParameters.compactMap { URLQueryItem(name: $0.key, value: $0.value.description) }
        }
        
        // swiftlint:disable:next force_unwrapping
        return components.url ?? URL(string: "https://any-url.com")!
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: constructedURL)
        request.allHTTPHeaderFields = headers
        request.httpMethod = httpMethod.rawValue
        
        if !bodyParameters.keys.isEmpty, let jsonSerializedData = try? JSONSerialization.data(withJSONObject: bodyParameters, options: []) {
            request.httpBody = jsonSerializedData
        }
        
        return request
    }
    
    func requestAndConstructOnBackgroundThread(completion: @escaping (NetworkResponse<Data>) -> Void) {
        DispatchQueue.global().async {
            URLSessionHTTPClient().request(urlRequest) { result in
                DispatchQueue.main.async {
                    let response: NetworkResponse<Data>
                    switch result {
                    case let .success((data, urlResponse)):
                        response = .init(request: self, urlResponse: urlResponse, result: .success(data))
                    case let .failure(error):
                        response = .init(request: self, urlResponse: nil, result: .failure(error))
                    }
                    
                    completion(response)
                }
            }
        }
    }
}
