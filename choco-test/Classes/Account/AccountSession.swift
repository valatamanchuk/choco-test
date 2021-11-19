//
//  AccountSession.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import Foundation

class AccountSession {
    enum State {
        case loggedIn(String)
        case loggedOut
        
        var token: String? {
            switch self {
            case let .loggedIn(token):
                return token
            default:
                return nil
            }
        }
    }
    
    static let shared: AccountSession = AccountSession()
    var currentSession: ChocoSession? = ChocoSession.currentSession()
    var currentState: State {
        guard let currentSession = currentSession else {
            return .loggedOut
        }
        
        return .loggedIn(currentSession.token)
    }
    
    func authenticate(withToken token: String) {
        guard currentSession?.token != token else { return }
        
        try? currentSession?.deleteFromSecureStore()
        currentSession = ChocoSession(token: token)
        try? currentSession?.createInSecureStore()
    }
    
    func unauthenticate() {
        try? currentSession?.deleteFromSecureStore()
        currentSession = nil
    }
}
