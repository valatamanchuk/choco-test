//
//  ObjectConstructibleNetworkResponse.swift
//  choco-test
//
//  Created by Val Atamanchuk on 16.11.21.
//

import Foundation

public protocol ObjectConstructibleNetworkResponse {
    associatedtype Object: Codable
}

public extension ObjectConstructibleNetworkResponse where Self: NetworkRequest {
    func requestAndConstruct(completion: @escaping (NetworkResponse<Object>) -> Void) {
        requestAndConstructOnBackgroundThread(completion: { response in
            var constructedObjectResponse: NetworkResponse<Object>
            do {
                let networkResponseData = try response.result.get()
                let constructedObject = try JSONDecoder().decode(Object.self, from: networkResponseData)
                constructedObjectResponse = .init(request: response.request, urlResponse: response.urlResponse, result: .success(constructedObject))
            } catch {
                constructedObjectResponse = .init(request: response.request, urlResponse: response.urlResponse, result: .failure(error))
            }
            
            completion(constructedObjectResponse)
        })
    }
}
