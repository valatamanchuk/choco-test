//
//  AccountAuthorizationLoginRequest.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import Foundation

struct AccountAuthorizationLoginRequest: ChocoNetworkPostRequest, ObjectConstructibleNetworkResponse {
    typealias Object = AccountAuthorizationLoginResponse
    
    // MARK: - For this particular request we are going to override the default host to use one from 'homework test'
    // qo7vrra66k.execute-api.eu-west-1.amazonaws.com/choco/login
    var urlScheme: String = "https"
    var urlHost: String = "qo7vrra66k.execute-api.eu-west-1.amazonaws.com"
    var urlPath: String = "/choco/login"
    
    let email: String
    let password: String
    var bodyParameters: [String: Any] {
        return [
            "email": email as Any,
            "password": password as Any
        ]
    }
}

struct AccountAuthorizationLoginResponse {
    let token: String
}

extension AccountAuthorizationLoginResponse: Codable {}
