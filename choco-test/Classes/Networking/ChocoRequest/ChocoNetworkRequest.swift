//
//  ChocoNetworkRequest.swift
//  choco-test
//
//  Created by Val Atamanchuk on 16.11.21.
//

import Foundation

private enum Constants {
    static let urlScheme: String = "https"
    
    // MARK: - Using mockapi instead of proposed host in the homework requirements to be able to get more data from the api for a showcase.
    static let urlHost: String = "618fea4af6bf450017484aa0.mockapi.io"
}

protocol ChocoNetworkRequest: NetworkRequest {}

extension ChocoNetworkRequest {
    var urlScheme: String {
        return Constants.urlScheme
    }
    
    var urlHost: String {
        return Constants.urlHost
    }
}
