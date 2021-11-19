//
//  HTTPClient.swift
//  choco-test
//
//  Created by Val Atamanchuk on 14.11.21.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    func request(_ networkRequest: URLRequest, completion: @escaping (Result) -> Void)
}
