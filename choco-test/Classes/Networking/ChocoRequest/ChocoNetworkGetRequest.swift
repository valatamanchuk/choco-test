//
//  ChocoNetworkGetRequest.swift
//  choco-test
//
//  Created by Val Atamanchuk on 16.11.21.
//

import Foundation

protocol ChocoNetworkGetRequest: ChocoNetworkRequest {}

extension ChocoNetworkGetRequest {
    var httpMethod: HTTPMethod {
        return .get
    }
}
