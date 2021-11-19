//
//  ChocoNetworkPostRequest.swift
//  choco-test
//
//  Created by Val Atamanchuk on 16.11.21.
//

import Foundation

protocol ChocoNetworkPostRequest: ChocoNetworkRequest {}

extension ChocoNetworkPostRequest {
    var httpMethod: HTTPMethod {
        return .post
    }
}
