//
//  LoggedOutNavigationProvider.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

class LoggedOutNavigationProvider: NavigationProvider {
    static func viewController(for state: AccountSession.State) -> UIViewController {
        return ViewControllersFactory.makeViewController(withType: .authorizationMain, embedInNavigationController: true)
    }
}
