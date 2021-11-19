//
//  NavigationProviderFactory.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

protocol NavigationProvider {
    static func viewController(for state: AccountSession.State) -> UIViewController
}

struct NavigationProviderFactory {
    
    static func navigationProvider(for state: AccountSession.State, from previousState: AccountSession.State?) -> NavigationProvider.Type? {
        if case .loggedOut = state { return LoggedOutNavigationProvider.self }
        
        guard let token = state.token else { return LoggedOutNavigationProvider.self }
        if let previousState = previousState, let previousToken = previousState.token, token == previousToken {
            return nil
        }
        
        return LoggedInNavigationProvider.self
    }
}
